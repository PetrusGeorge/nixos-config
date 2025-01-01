return {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = {
        plugins = { spelling = true },
        defaults = {
            mode = { "n", "v" },
            { "<leader>d", group = "Dap" },
            { "<leader>t", group = "ToDo/Trouble" },
            { "<leader>l", group = "LSP" },
            { "<leader>lw", group = "Workspace" },
            { "<leader>e", group = "NvimTree" },
            { "<leader>f", group = "Telescope" },
            { "<leader>g", group = "Git" },
            { "<leader>k", group = "Kill" },
        },
    },
    config = function(_, opts)
        require("which-key").setup(opts)
        require("which-key").add(opts.defaults)
    end,
}
