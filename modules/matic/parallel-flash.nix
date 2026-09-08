# Jetson parallel flashing: RCM interface (0955:7623) and the USB NICs the bots
# expose while being flashed (0955:7035).
#
# 61-matic-parallel-flash.rules is a verbatim copy of
# rust/nvidia/fuji_parallel_flash/61-matic-parallel-flash.rules in the matic
# repo. Eventually the matic repo should be a flake input and this file
# referenced from it. It must keep its 61- prefix: the NAME= rule inside has to
# sort before 80-net-setup-link.rules.
{ pkgs, ... }:
{
  # Not services.udev.extraRules: that would put it in 99-local.rules, after 80.
  services.udev.packages = [
    (pkgs.runCommand "matic-parallel-flash-udev-rules" { } ''
      install -Dm444 ${./61-matic-parallel-flash.rules} $out/etc/udev/rules.d/61-matic-parallel-flash.rules
    '')
  ];
}
