# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  outputs,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.disko.nixosModules.default
    inputs.musnix.nixosModules.musnix
    (import ./disk-config.nix {device = "/dev/nvme0n1";})
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };

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
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "thinkpad"; # Define your hostname.

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

  # Default display manager
  services.displayManager.cosmic-greeter.enable = true;

  # Use cosmic as DE
  services.desktopManager.cosmic.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  hardware.bluetooth.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
    ];
  };

  environment.shellAliases = {
    # Shortcut to enter shell
    nixld = "nix develop ~/.config/nixos/shells#nixld -c $SHELL";
  };

  # Enable virtualisation
  # programs.virt-manager.enable = true;
  # users.groups.libvirtd.members = ["petrus"];
  # virtualisation.libvirtd = {
  #   enable = true;
  #   # Enable efi
  #   qemu.ovmf.enable = true;
  # };
  # virtualisation.spiceUSBRedirection.enable = true;

  #Guitarix fix + audio delay optimization
  musnix.enable = true;

  services.avahi = {
    nssmdns4 = true;
    enable = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Enable the KDE Plasma Desktop Environment.
  #services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.steam.enable = true;
  programs.fish.enable = true;
  users.users.petrus = {
    isNormalUser = true;
    description = "Petrus";
    extraGroups = ["networkmanager" "wheel" "uucp" "dialout"];
    initialPassword = "123";
    shell = pkgs.fish;
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

    # Podman extras
    podman-compose
    podman-tui
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

  # Open syncthing ports
  services.syncthing.openDefaultPorts = true;

  system.stateVersion = "24.11";
}
