{
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [vaapiVdpau];
  };

  services.xserver.videoDrivers = ["nvidia"];

  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
  };

  virtualisation.docker.enableNvidia = true;
}
