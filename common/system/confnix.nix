{ inputs, pkgs, lib, config, ... }: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes" "pipe-operators"];
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [ "root" "eee"];
    };
    package = pkgs.nix;
    nixPath = ["nixpkgs=${inputs.nixpkgs} nixpkgs-unstable=${inputs.nixpkgs-unstable}"];
    registry.nixpkgs.flake = inputs.nixpkgs;
    registry.nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
  } // lib.optionalAttrs (!config.isDroid) {
    gc = {
      automatic = true;
      dates = "weekly"; # "daily"
      options = "--delete-older-than 7d";
    };
  };
}
