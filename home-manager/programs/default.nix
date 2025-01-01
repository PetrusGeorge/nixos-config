{pkgs, ...}: {
  imports = [
    ./git.nix
    ./fish.nix
    ./ghostty.nix
    ./neovim
  ];
}
