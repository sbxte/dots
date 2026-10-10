-- Returns true when current buffer name starts with "oil:/" aka an oil.nvim buffer
local in_oil_buf = function()
	local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
	local start = bufname.find(bufname, "oil:/")
	return start == 1
end

local open_oil = function()
	if in_oil_buf() then
		return
	end
	require("oil").open(nil, {}, nil)
end

return {
	{
		"stevearc/oil.nvim",
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		-- Optional dependencies
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n", desc = "Show keymaps" },
				["<CR>"] = { "actions.select" },
				["gv"] = { "actions.select", opts = { vertical = true } },
				["gs"] = { "actions.select", opts = { horizontal = true } },
				["gt"] = { "actions.select", opts = { tab = true } },
				["gp"] = { "actions.preview" },
				["<C-c>"] = { "actions.close", mode = "n" },
				["<leader>e"] = { "actions.close", mode = "n" },
				["<leader>fe"] = { "actions.close", mode = "n" },
				["gr"] = { "actions.refresh" },
				["-"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gS"] = { "actions.change_sort", mode = "n" },
				["gx"] = { "actions.open_external" },
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
				["gc"] = {
					callback = function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						local cwd = oil.get_current_dir()
						if not entry or not cwd then
							return
						end
						local abs_path = vim.fs.joinpath(cwd, entry.name)
						vim.fn.setreg("+", abs_path)
						vim.notify("Copied " .. abs_path .. " to system clipboard", vim.log.levels.INFO)
					end,
					mode = "n",
					desc = "Copy absolute path of the current entry at the cursor into system clipboard",
				},
				["gC"] = {
					callback = function()
						local oil = require("oil")
						local cwd = oil.get_current_dir()
						if not cwd then
							return
						end
						vim.fn.setreg("+", cwd)
						vim.notify("Copied " .. cwd .. " to system clipboard", vim.log.levels.INFO)
					end,
					mode = "n",
					desc = "Copy current working directory into system clipboard",
				},
			},
			use_default_keymaps = false,
			watch_for_changes = true,
		},
		keys = {
			{ "<leader>e", open_oil, desc = "Explorer Oil", expr = false },
			{ "<leader>fe", open_oil, desc = "Explorer Oil", expr = false },
		},
		config = function(_, opts)
			local wk = require("which-key")
			for k, v in pairs(opts.keymaps) do
				local mapping = {
					k,
					group = "Oil",
					desc = v.desc,
					cond = in_oil_buf,
					mode = v.mode or "n",
				}

				if type(v[1]) == "string" then
					if string.find(v[1], "actions.") == 1 then
						local action = string.sub(v[1], 9)
						local actions = require("oil.actions")
						mapping.desc = mapping.desc or actions[action].desc
					end
				end

				wk.add(mapping)
			end

			require("oil").setup(opts)
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
	},
}
