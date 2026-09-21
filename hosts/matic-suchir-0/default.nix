{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
    inputs.home-manager.nixosModules.home-manager
    ../../modules/home-manager/default.nix
    ../../modules/linux/user.nix
    ../../modules/linux/kernel.nix
    ../../modules/nixos-defaults.nix
    ../../modules/nix.nix
    ../../modules/locale.nix
    ../../modules/environment.nix
    ../../modules/cups.nix
    ../../modules/desktop/gnome/default.nix
    ../../modules/gpu/nvidia.nix
    ../../modules/ssd.nix
    ../../modules/logitech.nix
    ../../modules/docker.nix
    ../../modules/tailscale.nix
    ../../modules/zram.nix
    ../../modules/matic/default.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/Los_Angeles";

  networking.hostName = "matic-suchir-0";
  networking.networkmanager.enable = true;

  system.stateVersion = "26.05";
}
