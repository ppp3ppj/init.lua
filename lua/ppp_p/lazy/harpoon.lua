return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local toggle_opts = {
            border = "rounded",
            title_pos = "center",
            ui_width_ratio = 0.40,
        }

        require("harpoon"):setup({
            settings = {
                save_on_toggle = true, -- Save state on window toggle
            },
        })

        vim.keymap.set("n", "<leader>a", function() require("harpoon"):list():add() end)
        vim.keymap.set("n", "<C-e>",
            function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list(), toggle_opts) end)

        vim.keymap.set("n", "<C-h>", function() require("harpoon"):list():select(1) end)
        vim.keymap.set("n", "<C-t>", function() require("harpoon"):list():select(2) end)
        vim.keymap.set("n", "<C-n>", function() require("harpoon"):list():select(3) end)
        vim.keymap.set("n", "<C-s>", function() require("harpoon"):list():select(4) end)

        vim.keymap.set("n", "<leader>hc", function() require("harpoon"):list():clear() end)
        vim.keymap.set("n", "<leader>hn", function() require("harpoon"):list():next() end)
        vim.keymap.set("n", "<leader>hp", function() require("harpoon"):list():prev() end)
    end,
    --config = true,


    --keys = {
    --	{ "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Mark file with harpoon" },
    --		{ "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", desc = "Go to next harpoon mark" },
    --		{ "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", desc = "Go to previous harpoon mark" },
    --		{ "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Show harpoon marks" },
    --       { "<C-h>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Go to harpoon mark 1" },
    --      { "<C-t>", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", desc = "Go to harpoon mark 2" },
    --     { "<C-n>", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", desc = "Go to harpoon mark 3" },
    --     { "<C-s>", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", desc = "Go to harpoon mark 4" },
    --	},
}
--local mark = require("harpoon.mark")
--local ui = require("harpoon.ui")

--vim.keymap.set("n", "<leader>a", mark.add_file)
--vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

--vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
--vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
--vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
--vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
