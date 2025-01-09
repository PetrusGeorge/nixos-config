{
  lib,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # Language Servers
      lua-language-server
      stylua
      rust-analyzer
      mesonlsp
      pyright
      nil
      clang-tools

      # Dap
      lldb

      # Telescope
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig = let
      plugins = with pkgs.vimPlugins; [
        bufferline-nvim
        cmp-buffer
        cmp-nvim-lsp
        cmp-nvim-lsp-signature-help
        cmp-nvim-lua
        cmp-path
        cmp_luasnip
        conform-nvim
        crates-nvim
        dressing-nvim
        friendly-snippets
        gitsigns-nvim
        indent-blankline-nvim
        lualine-nvim
        mini-bufremove
        mini-indentscope
        nvim-autopairs
        nvim-cmp
        nvim-dap
        nvim-dap-ui
        nvim-lspconfig
        nvim-nio
        nvim-tree-lua
        nvim-treesitter
        nvim-web-devicons
        plenary-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        todo-comments-nvim
        toggleterm-nvim
        # tokyonight-nvim
        trouble-nvim
        vim-illuminate
        which-key-nvim
        {
          name = "catppuccin";
          path = catppuccin-nvim;
        }
        {
          name = "LuaSnip";
          path = luasnip;
        }
        {
          name = "Comment.nvim";
          path = comment-nvim;
        }
      ];
      mkEntryFromDrv = drv:
        if lib.isDerivation drv
        then {
          name = "${lib.getName drv}";
          path = drv;
        }
        else drv;
      lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
    in ''
      --cd to argument directory
      local group_cdpwd = vim.api.nvim_create_augroup("group_cdpwd", { clear = true })
      vim.api.nvim_create_autocmd("VimEnter", {
        group = group_cdpwd,
      	 pattern = "*",
        callback = function()
           vim.api.nvim_set_current_dir(vim.fn.expand("%:p:h"))
        end,
      })

      vim.g.mapleader = " "

      require("lazy").setup({
        defaults = {
        	lazy = true,
        },
        dev = {
          -- reuse files from pkgs.vimPlugins.*
          path = "${lazyPath}",
          patterns = { "" },
          -- fallback to download
          fallback = false,
        },
        spec = {
            -- import/override with your plugins
            { import = "plugins" },
        },
      })
      require("autocmds")
      require("options")
      require("mappings")
    '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source = let
    parsers = pkgs.symlinkJoin {
      name = "treesitter-parsers";
      paths =
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
          with plugins; [
            c
            cpp
            lua
            nix
            meson
            python
            rust
          ]))
        .dependencies;
    };
  in "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./lua;
}
