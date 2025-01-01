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
    ./gui
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

  # CLI
  programs.direnv.enable = true;
  programs.ripgrep.enable = true;
  programs.bat.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.tealdeer.enable = true;
  programs.starship.enable = true;
  programs.yazi.enable = true;
  programs.lazygit.enable = true;
  programs.btop.enable = true;
  programs.zellij.enable = true;
  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.thefuck.enable = true;

  # Browsers
  programs.librewolf.enable = true;
  programs.chromium.enable = true;

  # Editors
  #programs.neovim.enable = true;
  programs.zed-editor.enable = true;
  home.packages = with pkgs; [
    # CLI
    hyperfine
    duf
    tokei
    delta

    # Desktop apps
    spotify
    vesktop
    slack
    bitwarden-desktop

    nerd-fonts.jetbrains-mono

    #TODO: Gaming dir
    gamescope
    goverlay
    protonup-qt

    #TODO: Programming dir
    rustup
  ];

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "vim";
  };

  ## Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
