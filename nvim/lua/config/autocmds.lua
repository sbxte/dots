-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Auto Commands
local autocmd = vim.api.nvim_create_autocmd
local editing = vim.api.nvim_create_augroup("editing", {})

-- Use editorconfig or language-specific formatters instead, 
-- had an issue with adventofcode (AOC) 2025 day 6 where trailing whitespaces actually mattered
--
-- autocmd({ "BufWritePre" }, { -- Automatically remove all trailing whitespaces
-- 	group = editing,
-- 	pattern = "*",
-- 	command = [[%s/\s\+$//e]],
-- })

-- User Commands
local usercmd = vim.api.nvim_create_user_command
local nvimpath = vim.fn.stdpath("config")

-- TODO: have autocomplete
usercmd("License", function(opts)
	local open = io.open

	local function read_file(path)
		local file = open(path, "rb") -- r read mode and b binary mode
		if not file then
			return nil
		end
		local content = file:read("*a") -- *a or *all reads the whole file
		file:close()
		return content
	end

	local license = read_file(nvimpath .. "/licenses/" .. opts.args .. ".txt")
	if license == nil then
		vim.cmd('echo "Invalid License"')
		return
	end
	license = license:gsub("<<YEAR>>", os.date("%Y"))
	license = license:gsub("<<NAME>>", "SByte")

	local currentdir = vim.fn.getcwd()
	local file = io.open(currentdir .. "/LICENSE", "w+")
	if not file then
		return
	end
	file:write(license)
	file:close()
end, {
	nargs = 1,
	-- complete = function(ArgLead, CmdLine, CursorPos)
	-- 	return licenses
	-- end
})
