{
  pkgs,
  ...
}: {
  programs.mangohud = {
    enable = true;
    # enableSessionWide = true;
  };

  home.packages = with pkgs; [
    gamescope
    goverlay
    protonup-qt
    heroic
    wineWowPackages.stable
    winetricks
    umu-launcher
  ];
}
