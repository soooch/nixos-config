{pkgs, ...}: {
  imports = [
    ./git.nix
  ];

  home.packages = with pkgs; [
    # C, C++
    cmake
    lldb

    # Nix
    alejandra
    deadnix
    statix

    # Python
    (python3.withPackages (p: with p; [numpy pandas torch]))

    # Rust
    cargo
    rustfmt
  ];
}
