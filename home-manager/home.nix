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
    ./impermanence.nix
    inputs.jerry.homeManagerModules.jerry
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  home = {
    username = "zaaz";
    homeDirectory = "/home/zaaz";
  };

  ## Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  programs.jerry = {
    enable = true;
    config = {
      provider = "yugen";
    };
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
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
      chezmoi
      slack
      librewolf
      chromium
      xfce.thunar
      kitty
      zed-editor
      steam-run
      bottles
    ]
    ++ [inputs.umu.packages.${pkgs.system}.umu];

  ## Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  ## Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
