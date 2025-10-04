{
  options,
  pkgs,
  ...
}:{
    
  programs.nix-ld = {
    enable = true;
    libraries = options.programs.nix-ld.libraries.default ++ (
      with pkgs; [
        krb5
        dbus
        fontconfig
        freetype
        glib
        libGL
        libxkbcommon
        xorg.libX11
        xorg.libxcb
        wayland
        SDL2
        (pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
      ]
    );
  };

  environment.shellAliases = {
    # Shortcut to enter shell
    nixld = "nix develop ~/.config/nixos/shells#nixld -c $SHELL";
  };
}
