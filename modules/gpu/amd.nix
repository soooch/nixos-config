{
  pkgs,
  config,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [vaapiVdpau];
  };

  services.xserver.videoDrivers = ["amdgpu"];

  hardware.amdgpu = {
    # mesa drivers look fast enough
    amdvlk.enable = false;
    opencl.enable = true;
    initrd.enable = true;
  };

  # for opencl support on polaris
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };
}
