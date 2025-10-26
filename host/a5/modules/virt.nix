{...}: {
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    daemon.settings = {
      features = {
        cdi = true;
      };
    };
  };
  hardware.nvidia-container-toolkit.enable = true;
  users.users.eee.extraGroups = ["docker"];
}
