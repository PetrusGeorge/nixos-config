# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  pkgs-stable,
  currentSystem,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  programs.fuse.userAllowOther = true;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs pkgs-stable currentSystem;};
    users = {
      "petrus" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };
}
