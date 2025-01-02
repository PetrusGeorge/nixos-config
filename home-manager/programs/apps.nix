{pkgs, ...}: {
  # Browsers
  programs.librewolf.enable = true;
  programs.chromium.enable = true;

  home.packages = with pkgs; [
    spotify
    vesktop
    slack
    bitwarden-desktop
  ];
}
