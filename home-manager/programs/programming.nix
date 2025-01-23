{pkgs, ...}: {
  home.packages = with pkgs; [
    # General
    pkg-config

    # Rust
    rustup

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
  ];
}
