{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
    };
    themeFile = "Catppuccin-Mocha";
  };
}
