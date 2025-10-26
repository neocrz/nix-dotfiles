{ lib, ... }: {
  options = {
    isDroid = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable this for a Nix-on-Droid environment.";
    };
  };
}