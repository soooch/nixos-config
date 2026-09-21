{ pkgs, lib, ... }:
{
  imports = [
    ./direnv.nix
    ./fzf.nix
    ./git.nix
  ];

  home.packages =
    with pkgs;
    [
      # Utils
      fd

      # System
      htop

      # C, C++
      clang
      cmake
      lldb

      # Nix
      cachix
      deadnix
      nix-output-monitor
      nixfmt
      statix

      # Python
      (python3.withPackages (
        p: with p; [
          numpy
          pandas
          torch
        ]
      ))

      # Rust
      rust-bin.stable.latest.complete

      # Bazel
      buildifier
    ]
    ++ lib.optionals stdenv.isLinux [
      # Utils
      wl-clipboard

      # Audio (PipeWire)
      crosspipe
      easyeffects
      pwvucontrol
    ];
}
