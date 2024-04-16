{pkgs, ...}: {
  imports = [
    ./fzf.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    # Utils
    bat
    fd

    # C, C++
    clang
    cmake
    lldb

    # Nix
    alejandra
    deadnix
    statix

    # Python
    (python3.withPackages (p: with p; [numpy pandas torch]))

    # Rust
    (rust-bin.selectLatestNightlyWith
      (toolchain:
        toolchain.default.override {
          extensions = ["rust-src" "miri"];
        }))
  ];
}
