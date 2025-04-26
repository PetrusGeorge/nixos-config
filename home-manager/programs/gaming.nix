{
  pkgs,
  inputs,
  ...
}: {
  programs.mangohud = {
    enable = true;
  };

  home.packages = with pkgs; [
    gamescope
    goverlay
    protonup-qt
    heroic
    wineWowPackages.stable
    winetricks
    inputs.umu.packages."x86_64-linux".umu-launcher
  ];
}
