return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "main",
        lazy = false,
        config = function()
            -- Install parsers
            require("nvim-treesitter").setup({
                ensure_installed = {
                    "vimdoc",
                    "javascript",
                    "typescript",
                    "c",
                    "lua",
                    "rust",
                    "jsdoc",
                    "bash",
                    -- Elixir dev
                    "elixir",
                    "heex",
                    "eex",
                },
            })

            -- Enable highlighting (built-in Neovim API, NOT nvim-treesitter module)
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
}
