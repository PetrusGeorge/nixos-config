{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        #line-number = "relative";
        lsp.display-messages = true;
        cursor-shape.insert = "bar";
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";
      };
    };
    languages = {
      language = [
        {
          name = "haskell";
          auto-format = true;
        }
      ];
      language-server = {
        rust-analyzer.config = {
          check.command = "clippy";
          cargo.features = "all";
        };
      };
    };
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
}
