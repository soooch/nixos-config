{
  pkgs,
  config,
  ...
}: let
  driverPkg = config.boot.kernelPackages.nvidiaPackages.latest;
in {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    package = driverPkg;
    extraPackages = with pkgs; [vaapiVdpau];
  };

  services.xserver.videoDrivers = ["nvidia"];

  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    # https://forums.developer.nvidia.com/t/clarifying-560-series-drivers-open-sourcedness-vs-kernel-module-type-proprietary/292698
    open = false;
    nvidiaSettings = true;
    package = driverPkg;
  };

  virtualisation.docker.enableNvidia = true;
}
