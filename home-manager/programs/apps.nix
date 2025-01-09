{pkgs, ...}: {
  # Browsers
  programs.librewolf.enable = true;
  programs.chromium.enable = true;

  # Librewolf as default browser
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };
  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";

  # PDF viewer
  programs.zathura.enable = true;
  # Image viewer
  programs.imv.enable = true;

  home.packages = with pkgs; [
    spotify
    vesktop
    slack
    bitwarden-desktop
    whatsapp-for-linux
  ];
}
