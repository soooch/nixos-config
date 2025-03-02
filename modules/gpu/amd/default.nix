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

  boot.kernelPatches = [
    {
      # https://lore.kernel.org/all/2025022644-blinked-broadness-c810@gregkh/
      name = "revert cve fix which broke chromium rendering for amdgpu";
      patch = ./0001-Revert-libfs-Use-d_children-list-to-iterate-simple_o.patch;
    }
  ];
}
