{pkgs, ...}: {
  home.packages = with pkgs; [
    # General
    pkg-config
    just
    watchexec

    # Go
    go
    gopls
    golangci-lint
    delve

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

    # Arduino
    arduino-cli
    screen

    #Swift
    swift
    sourcekit-lsp
    swift-format
  ];
}
