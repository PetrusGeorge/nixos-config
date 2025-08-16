{
  pkgs,
  pkgs-stable,
  ...
}: {
  programs.mangohud = {
    enable = true;
    # enableSessionWide = true;
  };

  home.packages = with pkgs; [
    pkgs-stable.gamescope
    goverlay
    protonup-qt
    heroic
    wineWowPackages.stable
    winetricks
    umu-launcher
  ];
}
