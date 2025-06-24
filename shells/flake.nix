{
  description = "Dev Shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system} = {
      # A general porpuse shell that activates nixld
      nixld = pkgs.mkShell {
        name = "nixld";
        shellHook = ''
          export LD_LIBRARY_PATH=${"$NIX_LD_LIBRARY_PATH"}
        '';
      };
    };
  };
}
