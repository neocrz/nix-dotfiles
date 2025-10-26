{...}: {
  home.shellAliases = {
    g = "git";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
    '';
  };
}
