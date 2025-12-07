return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Mason is pinned to version 1 for now: https://github.com/LazyVim/LazyVim/issues/6039
		--
		-- "williamboman/mason.nvim",
		-- "williamboman/mason-lspconfig.nvim",
		{ "mason-org/mason.nvim", version = "^1.0.0" },
		{ "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp"
        },
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"stevearc/conform.nvim",
	},

	config = function()
		require("conform").setup({ formatters_by_ft = {} })

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					vim.lsp.config[server_name].setup = {
						capabilities = capabilities,
					}

					-- https://github.com/neovim/nvim-lspconfig/pull/3232
					-- for fix tsserver to ts_ls
					if server_name == "tsserver" then
						server_name = "ts_ls"
					end
				end,

				zls = function()
					local lspconfig = vim.lsp.config
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
						settings = {
							zls = {
								enable_inlay_hints = true,
								enable_snippets = true,
								warn_style = true,
							},
						},
					})
					vim.g.zig_fmt_parse_errors = 0
					vim.g.zig_fmt_autosave = 0
				end,

				["lua_ls"] = function()
					local lspconfig = vim.lsp.config
					lspconfig.lua_ls.setup = {
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					}
				end,

				ocamllsp = function()
					local lspconfig = vim.lsp.config
					lspconfig.ocamllsp.setup = {
						manual_install = true,
						cmd = { "dune", "tools", "exec", "ocamllsp" },
						-- cmd = { "dune", "exec", "ocamllsp" },
						settings = {
							codelens = { enable = true },
							inlayHints = { enable = true },
							syntaxDocumentation = { enable = true },
						},

						server_capabilities = { semanticTokensProvider = false },
					}
				end,

				tailwindcss = function()
					local lspconfig = vim.lsp.config
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						settings = {
							tailwindCSS = {
								classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
								includeLanguages = {
									eelixir = "html-eex",
									eruby = "erb",
									htmlangular = "html",
									templ = "html",
									heex = "html-eex",
									elixir = "html-eex",
								},
								lint = {
									cssConflict = "warning",
									invalidApply = "error",
									invalidConfigPath = "error",
									invalidScreen = "error",
									invalidTailwindDirective = "error",
									invalidVariant = "error",
									recommendedVariantOrder = "warning",
								},
								validate = true,
							},
						},
					})
				end,

				lexical = function()
					local lspconfig = vim.lsp.config
					lspconfig.lexical.setup = {
						filetypes = { "elixir", "eelixir", "heex" },
						-- cmd = { "lexical" },
						-- cmd = { "/home/pppam/.local/share/nvim/mason/bin/lexical", "server" },
						cmd = { vim.fn.expand("$HOME/.local/share/nvim/mason/bin/expert") },
						root_dir = function(fname)
							return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or nil
						end,
					}
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
