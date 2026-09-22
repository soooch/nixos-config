{ pkgs, ... }:
let
  # nixpkgs links bin/tailscale straight at the binary inside the app. Started
  # through a symlink it cannot find its bundle and aborts, so exec it by its
  # real path, as Tailscale's own /usr/local/bin/tailscale wrapper does.
  tailscale-gui = pkgs.tailscale-gui.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      rm "$out/bin/tailscale"
      cat > "$out/bin/tailscale" <<EOF
      #!/bin/sh
      exec "$out/Applications/Tailscale.app/Contents/MacOS/Tailscale" "\$@"
      EOF
      chmod +x "$out/bin/tailscale"
    '';
  });
in
{
  # Tailscale's macOS app rather than services.tailscale: we want the GUI.
  environment.systemPackages = [ tailscale-gui ];
}
