return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
				elixir = { "mix" },
				heex = { "mix" }, -- Apply mix format to .heex files
				javascript = { "prettier" },
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd" },
				json = { "prettierd" },
				css = { "prettierd" },
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ bufnr = 0 })
		end)
	end,
}
