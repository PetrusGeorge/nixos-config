# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ./programs
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  home = {
    username = "petrus";
    homeDirectory = "/home/petrus";
  };

  ## Add stuff for your user as you see fit:
  programs.direnv.enable = true;
  programs.neovim.enable = true;
  programs.starship.enable = true;
  home.packages = with pkgs;
    [
      ripgrep
      bat
      fd
      delta
      fzf
      steam
      spotify
      vesktop
      slack
      librewolf
      chromium
      ghostty
      zed-editor
      nerd-fonts.jetbrains-mono
    ];

  programs.home-manager.enable = true;

  ## Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
