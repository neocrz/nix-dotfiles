{...}: let
  modulesPath = ../../common/home;
  modulesList = [
    "options.nix"
    
    "apps.nix"
    "bash.nix"
    "git.nix"
    "tmux.nix"
    # "confnix.nix"
  ];
  modulesPathList = map (mod: modulesPath + mod) (map (mod: "/" + mod) modulesList);
in {
  home.stateVersion = "24.05";
  imports = modulesPathList;
  
  isDroid = true;
}