{pkgs, ...}: {
  home.packages = with pkgs; [
    # General
    pkg-config

    # Rust
    rustup

    # Haskell
    ghc
    ghcid
    haskell-language-server
    stack
    ormolu

    # CPP
    meson
    ninja
    clang-tools
    cmake
    lldb
    gdb

    # Ansible
    ansible
    ansible-lint
    sshpass

    # Python
    ruff
    uv
    python3

    # JS
    bun
  ];
}
