{inputs, ...}: {
  imports = [inputs.ghostty-hm.homeModules.default];
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.x86_64-linux.default;
    settings = {
      theme = "catppuccin-mocha";
      window-decoration = false;
    };
  };
}
