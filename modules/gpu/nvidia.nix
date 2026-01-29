{
  pkgs,
  ...
}:
{
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
    cudaSupport = true;
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos-cuda.org"
    ];
    trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_RestrictProfilingToAdminUsers=0"
  ];

  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
  };

  hardware.nvidia-container-toolkit.enable = true;
  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit
    gpu-burn
  ];
}
