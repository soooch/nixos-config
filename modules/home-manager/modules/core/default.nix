{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./fzf.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    # Utils
    bat
    fd
    wl-clipboard

    # System
    htop

    # Audio
    easyeffects
    helvum
    pwvucontrol

    # C, C++
    clang
    cmake
    lldb

    # Nix
    alejandra
    cachix
    deadnix
    nix-output-monitor
    statix

    # Python
    (python3.withPackages (p: with p; [numpy pandas torch]))

    # Rust
    rust-bin.stable.latest.complete

    # Bazel
    buildifier
  ];
}
