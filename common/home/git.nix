{ config, pkgs, ...}: {
  programs.git = {
    enable = true;
    userName  = "neocrz";
    userEmail = "neo59crz@gmail.com";
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
