{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
    ../../modules/home-manager/default.nix
    ../../modules/system.nix
    ../../modules/desktop/gnome/default.nix
    ../../modules/gpu/nvidia.nix
    ../../modules/ssd.nix
    ../../modules/logitech.nix
    ../../modules/docker.nix
    ../../modules/tailscale.nix
    ../../modules/zram.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/Los_Angeles";

  networking.hostName = "matic-suchir-0";
  networking.networkmanager.enable = true;

  system.stateVersion = "26.05";
}
