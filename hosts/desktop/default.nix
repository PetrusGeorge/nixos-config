# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  outputs,
  lib,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.disko.nixosModules.default
    (import ./disk-config.nix {device = "/dev/nvme0n1";})
  ];

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    FLAKE = "${XDG_CONFIG_HOME}/nixos";
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["petrus"];
  };

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Fix for 60% layout
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';

  networking.hostName = "desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Home manager doest have thunar
  programs.thunar.enable = true;
  # Necessary to make hyprland appear as a session
  programs.hyprland.enable = true;
  # Default display manager
  services.displayManager.ly.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #services.displayManager.sddm.wayland.enable = true;
  #services.displayManager.sddm.enable = true;
  #services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.steam.enable = true;
  programs.fish.enable = true;
  users.users.petrus = {
    isNormalUser = true;
    description = "Petrus";
    extraGroups = ["networkmanager" "wheel"];
    initialPassword = "123";
    shell = pkgs.fish;
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    gcc
    gnumake
    unzip
    wget
  ];

  # Enable zram
  zramSwap.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Mount external drives
  fileSystems = {
    "/run/media/SSD" = {
      device = "/dev/sda1";
      options = ["nofail"];
    };
    "/run/media/HD" = {
      device = "/dev/sdb1";
      options = ["nofail"];
    };
  };
  
  system.stateVersion = "24.11";
}
