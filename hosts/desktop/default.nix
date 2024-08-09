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
    inputs.nixos-cosmic.nixosModules.default
    (import ./disko-config.nix {device = "/dev/nvme0n1";})
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    FLAKE = "${XDG_CONFIG_HOME}/nixos";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["zaaz"];
  };

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  #programs.hyprland = {
  #  enable = true;
  #  package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #  xwayland.enable = true;
  #};

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  services.xserver.enable = false;

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

  users.users.zaaz = {
    isNormalUser = true;
    description = "Zaaz";
    extraGroups = ["networkmanager" "wheel"];
    initialPassword = "123";
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
    greetd.tuigreet
  ];

  #services.greetd = let
  #  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  #  hyprland-session = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/wayland-sessions";
  #in {
  #  enable = true;
  #  settings = {
  #    default_session = {
  #      command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
  #      user = "greeter";
  #    };
  #  };
  #};
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

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +14); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      #"/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      #"/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      #{ file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };

  systemd.tmpfiles.rules = [
    "d /persist/home/ 1777 root root -" # /persist/home created, owned by root
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
