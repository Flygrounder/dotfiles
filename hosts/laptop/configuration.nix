{ ... }: {
  boot.initrd.luks.devices."luks-6f48c27b-c755-4d74-90b4-552685ae256a".device =
    "/dev/disk/by-uuid/6f48c27b-c755-4d74-90b4-552685ae256a";
  imports = [ ./hardware-configuration.nix ];
  networking.hostName = "laptop";
  services.tlp = {
    enable = true;

    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
  programs.light.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  custom = {
    desktop.enable = true;
    neovim.enable = true;
    cli.enable = true;
  };
}
