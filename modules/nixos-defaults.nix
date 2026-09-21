{
  # NixOS defaults we don't want.
  # only supports channels
  programs.command-not-found.enable = false;
  programs.nano.enable = false;
}
