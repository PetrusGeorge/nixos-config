# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common.nix
    inputs.disko.nixosModules.default
    inputs.musnix.nixosModules.musnix

    (import ./disk-config.nix {device = "/dev/nvme0n1";})
  ];


  networking.hostName = "desktop"; # Define your hostname.

  # AMD gpu tuning
  # programs.corectrl.enable = true;
  # hardware.amdgpu.overdrive.enable = true;

  # Home manager doesn't have thunar
  programs.thunar.enable = true;
  # Necessary to make hyprland appear as a session
  programs.hyprland.enable = true;

  # Enable virtualisation
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["petrus"];
  virtualisation.libvirtd = {
    enable = true;
    # Enable efi
    qemu.ovmf.enable = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # Mount external drives
  fileSystems = {
    "/media/SSD" = {
      device = "/dev/disk/by-partuuid/b17846f6-7486-4fcf-8a4e-8152177cf8a6";

      options = ["nofail"];
    };
    "/media/HD" = {
      device = "/dev/disk/by-partuuid/1158a310-61fe-4d75-9ac7-1f21b25e06e5";
      options = ["nofail"];
    };
  };

  system.stateVersion = "24.11";
}
