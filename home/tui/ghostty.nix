{inputs, ...}: {
  home.packages = [inputs.ghostty.packages.x86_64-linux.default];
  xdg.configFile."ghostty/config".text = ''
    theme = rose-pine
  '';
}
