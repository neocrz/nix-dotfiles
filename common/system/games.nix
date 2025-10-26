{pkgs, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    protontricks.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # lutris
    # playonlinux
    steam-run
    # wineWowPackages.staging
    # winetricks
  ];

  # programs.gamemode.enable = true;
}
