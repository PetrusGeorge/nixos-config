{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.ghostty-hm.homeModules.default];
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.x86_64-linux.default;
    settings = {
      window-decoration = false;
    };
  };
}
