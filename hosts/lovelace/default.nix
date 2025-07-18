{
  imports = [
    # Include the results of the hardware scan.
    ../../modules/system.nix
    ../../modules/desktop/gnome/default.nix
    ../../modules/gpu/amd/default.nix
    ../../modules/ssd.nix
    ../../modules/logitech.nix
    ../../modules/docker.nix
    ../../modules/ios.nix
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # https://github.com/NixOS/nixos-hardware/blob/master/gigabyte/b650/b650-fix-suspend.nix
  # see https://bbs.archlinux.org/viewtopic.php?pid=2227023
  boot.kernelParams = [
    "acpi_osi=\"!Windows 2015\""
  ];

  # disable disabling amdgpu (using amd gpu)
  # # disable integrated amd gpu (interfering with nvidia)
  # boot.kernelParams = ["module_blacklist=amdgpu"];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  networking.hostName = "lovelace"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
