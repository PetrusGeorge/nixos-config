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
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/petrus/.config/nixos";
  };
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
      spotify
      vesktop
      slack
      librewolf
      chromium
      kitty
      protonup-qt
      zed-editor
      nerd-fonts.jetbrains-mono
    ] ++
    [
      inputs.ghostty.packages.x86_64-linux.default
    ];

  programs.home-manager.enable = true;

  ## Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
