return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				rust_analyzer = { enabled = false },
				gdscript = { enabled = true },
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders=0",
						"--fallback-style=llvm",
					},
				},
				tailwindcss = {
					filetypes = {
						"html",
						"css",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
				},
				pyright = {
					settings = {
						python = {
							venvPath = ".venv",
							pythonPath = ".venv/bin/python",
						},
					},
				},
				arduino_language_server = {
					cmd = {
						"arduino-language-server",
						"-cli",
						"arduino-cli",
						"-cli-config",
						vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
						"-clangd",
						vim.fn.expand("~/.local/share/nvim/mason/bin/clangd"),
					},
				},
			},
		},
	},

	-- Rust LSP

	{
		"mrcjkb/rustaceanvim",
		opts = {
			server = {
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						-- Add clippy lints for Rust.
						checkOnSave = {
							allFeatures = true,
						},
						check = {
							-- Clippy is insanely slow to be constantly called in large projects
							-- command = "clippy",
							-- extraArgs = { "--no-deps" },
						},
						diagnostics = {
							disabled = { "proc-macro-disabled" },
						},
						imports = {
							granularity = {
								group = "module",
							},
						},
						inlayHints = { -- This is actually so annoying wtf
							chainingHints = {
								enable = false,
							},
							closingBraceHints = {
								enable = false,
							},
							parameterHints = {
								enable = false,
							},
							typeHints = {
								enable = false,
							},
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
				},
			},
		},
	},

	-- File Manager

	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Uncomment whichever supported plugin(s) you use
			-- "nvim-tree/nvim-tree.lua",
			"nvim-neo-tree/neo-tree.nvim",
			-- "simonmclean/triptych.nvim"
			"stevearc/oil.nvim",
		},
		opts = {
			-- used to see debug logs in file `vim.fn.stdpath("cache") .. lsp-file-operations.log`
			debug = false,
			-- select which file operations to enable
			operations = {
				willRenameFiles = true,
				didRenameFiles = true,
				willCreateFiles = true,
				didCreateFiles = true,
				willDeleteFiles = true,
				didDeleteFiles = true,
			},
			-- how long to wait (in milliseconds) for file rename information before cancelling
			timeout_ms = 10000,
		},
		config = function(_, opts)
			require("lsp-file-operations").setup(opts)
		end,
	},

	-- Markdown LSP

	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
			heading = {
				sign = false,
				icons = {},
			},
			checkbox = {
				enabled = false,
			},
			pipe_table = {
				-- Turn on / off pipe table rendering.
				enabled = true,
				-- Additional modes to render pipe tables.
				render_modes = false,
				-- Pre configured settings largely for setting table border easier.
				-- | heavy  | use thicker border characters     |
				-- | double | use double line border characters |
				-- | round  | use round border corners          |
				-- | none   | does nothing                      |
				preset = "none",
				-- Determines how individual cells of a table are rendered.
				-- | overlay | writes completely over the table, removing conceal behavior and highlights |
				-- | raw     | replaces only the '|' characters in each row, leaving the cells unmodified |
				-- | padded  | raw + cells are padded to maximum visual width for each column             |
				-- | trimmed | padded except empty space is subtracted from visual width calculation      |
				cell = "raw",
				-- Adjust the computed width of table cells using custom logic.
				cell_offset = function()
					return 0
				end,
				-- Amount of space to put between cell contents and border.
				padding = 1,
				-- Minimum column width to use for padded or trimmed cell.
				min_width = 0,
				-- Characters used to replace table border.
				-- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal.
				-- stylua: ignore
				border = {
					'┌', '┬', '┐',
					'├', '┼', '┤',
					'└', '┴', '┘',
					'│', '─',
				},
				-- Turn on / off top & bottom lines.
				border_enabled = false,
				-- Always use virtual lines for table borders instead of attempting to use empty lines.
				-- Will be automatically enabled if indentation module is enabled.
				border_virtual = false,
				-- Gets placed in delimiter row for each column, position is based on alignment.
				alignment_indicator = "━",
				-- Highlight for table heading, delimiter, and the line above.
				head = "RenderMarkdownTableHead",
				-- Highlight for everything else, main table rows and the line below.
				row = "RenderMarkdownTableRow",
				-- Determines how the table as a whole is rendered.
				-- | none   | { enabled = false }        |
				-- | normal | { border_enabled = false } |
				-- | full   | uses all default values    |
				style = "full",
			},
			win_options = {
				wrap = {
					default = false, -- Disables wrap in rendered view
					rendered = false,
				},
			},
		},
		ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
		config = function(_, opts)
			require("render-markdown").setup(opts)
			Snacks.toggle({
				name = "Render Markdown",
				get = require("render-markdown").get,
				set = require("render-markdown").set,
			}):map("<leader>um")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		enabled = false,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{
				"<leader>cp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		config = function()
			vim.cmd([[do FileType]])
		end,
	},
	{
		"selimacerbas/mdkite.nvim",
		ft = { "markdown", "md" },
		-- a kitehost.nvim checkout under another dir name needs its spec to
		-- say name = "kitehost.nvim", or lazy.nvim clones upstream beside it
		dependencies = { "selimacerbas/kitehost.nvim" },
		-- kitehost.nvim v2.0.0 or newer, the first release with its Host check
		opts = {
			-- all optional; sane defaults shown
			instance_mode = "takeover", -- "takeover" (one tab) or "multi" (tab per instance)
			port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
			open_browser = true,
			default_theme = "dark", -- "dark" or "light"; initial preview theme
			debounce_ms = 300,
			mermaid_elk = true,
			custom_css = "~/.config/nvim/mdkite.css",
			bottom_padding = 0.95, -- no extra space; last line sits at bototm edge
		},
		keys = {
			{
				"<leader>mks",
				"<cmd>MdKite start<CR>",
				desc = "Start MdKite preview",
				expr = false,
			},
			{
				"<leader>mkS",
				"<cmd>MdKite stop<CR>",
				desc = "Stop MdKite preview",
				expr = false,
			},
		},
	},

	-- Java LSP

	{
		"mfussenegger/nvim-jdtls",
		opts = {
			settings = {
				java = {
					inlayHints = {
						parameterNames = {
							enabled = "none",
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.lsp.config("jdtls", opts)
		end,
	},
}
