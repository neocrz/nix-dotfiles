{inputs, ...}: let
  userName = "err";
in let
  # COMMON MODULES
  modulesPath = ../../common/home;
  modulesList = [
    "options.nix"

    "apps.nix"
    "bash.nix"
    "confnix.nix"
    "git.nix"
    "services.nix"
    "tmux.nix"
  ];
  modulesPathListCommon = map (mod: modulesPath + mod) <| map (mod: "/" + mod) modulesList;
in let
  # HOME MODULES
  modulesPath = ./modules;
  modulesList = [
  ];
  modulesPathListThis = map (mod: modulesPath + mod) <| map (mod: "/" + mod) modulesList;

  modulesPathList = modulesPathListCommon ++ modulesPathListThis;
in {
  imports = [] ++ modulesPathList;

  home.username = userName;
  home.homeDirectory = "/home/${userName}";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
