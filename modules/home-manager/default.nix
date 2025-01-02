{
  lib,
  ...
}: {
  imports = [
    ./sunshine.nix
  ];

  services.sunshine.enable = lib.mkDefault false;
}
