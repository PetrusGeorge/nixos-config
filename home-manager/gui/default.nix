{pkgs, ...}: {
  imports = [
    ./hyprland
    ./gtk.nix
    ./media.nix
  ];
}
