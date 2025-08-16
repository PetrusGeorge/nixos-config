{pkgs, lib, ...}: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      # Language Servers
      lua-language-server
      stylua
      rust-analyzer
      mesonlsp
      pyright
      python312Packages.jedi-language-server
      ruff
      nil
      clang-tools
      ansible-language-server
      bash-language-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      haskell-language-server

      # Dap
      lldb
    ];
  };

  xdg.configFile = {
    "helix/languages.toml".source = lib.mkForce ./languages.toml;
    "helix/config.toml".source = lib.mkForce ./config.toml;
  };
}
