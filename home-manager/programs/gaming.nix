{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  programs.mangohud = {
    enable = true;
  };

  home.packages = with pkgs; [
    pkgs-stable.gamescope
    goverlay
    protonup-qt
    heroic
    wineWowPackages.stable
    winetricks
    inputs.umu.packages."x86_64-linux".umu-launcher
  ];
}
