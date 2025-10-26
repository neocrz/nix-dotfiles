{
  pkgs,
  lib,
  config,
  ...
}: let
  isDroid = config.isDroid;

  commonApps = [];
  desktopApps = with pkgs.unstable; [
    appimage-run
  ];
  droidApps = with pkgs; [
    openssh
    procps
    killall
    utillinux
    tzdata
    hostname
    man
  ];
in let
  systemPackages =
    []
    ++ commonApps
    ++ lib.optionals isDroid droidApps
    ++ lib.optionals (!isDroid) desktopApps;
in {
  environment =
    if isDroid
    then {
      packages = systemPackages;
    }
    else {
      systemPackages = systemPackages;
    };
}
