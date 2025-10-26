{ inputs,  ... }:
let
  modulesPath = ../../common/system;
  modulesList = [
    "options.nix"
    
    "apps.nix"
    # "confnix.nix"
  ];
  modulesPathList = map (mod: modulesPath + mod) (map (mod: "/" + mod) modulesList);
in
{
  isDroid = true;
  android-integration.termux-setup-storage.enable = true;

  imports = [ ] ++ modulesPathList;

  # environment.packages = with pkgs; [ ];

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";
  
  
  time.timeZone = "America/Sao_Paulo";

  home-manager = {
    config = ../../home/droid;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
    };
  };
}