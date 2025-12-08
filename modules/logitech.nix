{ pkgs, ... }:
{
  hardware.logitech.wireless.enable = true;
  services.ratbagd.enable = true;
  environment.systemPackages = with pkgs; [
    solaar
    piper
  ];
}
