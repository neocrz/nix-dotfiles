{
  description = "My Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-neocrz = {
      url = "github:neocrz/my-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-neocrz,
    nix-on-droid,
    home-manager,
    ...
  } @ inputs: let
    # HELPERS
    unstableOverlay = system: final: prev: {
      unstable = import nixpkgs-unstable {
        inherit prev;
        inherit system;
        config.allowUnfree = true;
      };
    };

    myPkgsOverlay = final: prev: {
      neocrz = nixpkgs-neocrz.overlays.default final prev;
    };

    mkPkgs = {
      system,
      o ? [],
    }:
      import nixpkgs {
        inherit system;
        overlays =
          [
            (unstableOverlay system)
            myPkgsOverlay
          ]
          ++ o;
        config.allowUnfree = true;
        android_sdk.accept_license = true;
      };
  in {
    nixosConfigurations = {
      a5 = let
        system = "x86_64-linux";
        pkgs = mkPkgs {inherit system;};
      in
        nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            {
              nixpkgs.overlays = [
                (unstableOverlay system)
                myPkgsOverlay
              ];
            }
            ./host/a5
          ];
        };
    };

    homeConfigurations = {
      eee = let
        system = "x86_64-linux";
        pkgs = mkPkgs {inherit system;};
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {inherit inputs;};
          modules = [ ./home/eee ];
        };
      err = let
        system = "x86_64-linux";
        pkgs = mkPkgs {inherit system;};
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {inherit inputs;};
          modules = [ ./home/err ];
      };
    };
    nixOnDroidConfigurations.default = let
      system = "aarch64-linux";
      pkgs = mkPkgs {
        inherit system;
        o = [nix-on-droid.overlays.default];
      };
    in
      nix-on-droid.lib.nixOnDroidConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [
          ./host/droid
        ];
        home-manager-path = home-manager.outPath;
      };
  };
}
