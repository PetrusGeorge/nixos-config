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
    (import ./disk-config.nix {device = "/dev/nvme0n1";})
  ];

  networking.hostName = "thinkpad"; # Define your hostname.

  hardware.bluetooth.enable = true;
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  environment.shellAliases = {
    # Shortcut to enter shell
    nixld = "nix develop ~/.config/nixos/shells#nixld -c $SHELL";
  };

  system.stateVersion = "24.11";
}
