local is_hidden = function()
	local files = vim.fs.find(".nodcrpc", {
		path = vim.api.nvim_buf_get_name(0),
		upward = true,
		limit = math.huge,
	})

	return #files > 0
end

return {
	{
		"vyfor/cord.nvim",
		lazy = false,
		build = ":Cord update",
		opts = {
			display = {
				theme = "default",
				flavor = "dark",
			},
			editor = {
				tooltip = "fingers go brrr",
			},
			text = {
				editing = function(opts)
					if is_hidden() then
						return "Editing file"
					else
						return "Editing " .. opts.filename
					end
				end,
				workspace = function(opts)
					if is_hidden() then
						return "Wololo"
					else
						return "In " .. opts.workspace
					end
				end,
				viewing = function(opts)
					if is_hidden() then
						return "Viewing file"
					else
						return "Viewing " .. opts.filename
					end
				end,
				file_browser = function(opts)
					if is_hidden() then
						return "Browsing files"
					else
						return "Browsing files in " .. opts.name
					end
				end,
				plugin_manager = function(opts)
					if is_hidden() then
						return "Managing plugins"
					else
						return "Managing plugins in " .. opts.name
					end
				end,
				lsp = function(opts)
					if is_hidden() then
						return "Configuring LSP"
					else
						return "Configuring LSP in " .. opts.name
					end
				end,
				docs = function(opts)
					if is_hidden() then
						return "Reading docs"
					else
						return "Reading " .. opts.name
					end
				end,
				vcs = function(opts)
					if is_hidden() then
						return "Version control shenanigans"
					else
						return "VCS with " .. opts.name
					end
				end,
				notes = function(opts)
					if is_hidden() then
						return "Taking notes"
					else
						return "Taking notes in " .. opts.name
					end
				end,
				debug = function(opts)
					if is_hidden() then
						return "Le debugging"
					else
						return "Debugging in " .. opts.name
					end
				end,
				test = function(opts)
					if is_hidden() then
						return "Testing stuff"
					else
						return "Testing in " .. opts.name
					end
				end,
				diagnostics = function(opts)
					if is_hidden() then
						return "Reading diagnostics"
					else
						return "Fixing problems in " .. opts.name
					end
				end,
				games = function(opts)
					if is_hidden() then
						return "Beep boop"
					else
						return "Playing " .. opts.name
					end
				end,
				terminal = function(opts)
					if is_hidden() then
						return "Running commands"
					else
						return "Running commands in " .. opts.name
					end
				end,
				dashboard = "Yipeeeee",
			},
		},
	},
}
