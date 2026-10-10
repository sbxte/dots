-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.guicursor =
	"a:block-lCursor,i-ci-ve:ver25,r-cr:hor20,o:hor50,sm:block-blinkwait175-blinkoff150-blinkon175"

vim.o.nu = true
vim.o.rnu = true

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = false -- Use tabs instead of spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.wrap = false

vim.o.swapfile = false
vim.o.backup = false

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.scrolloff = 5
vim.o.signcolumn = "yes"

vim.o.clipboard = "" -- Do NOT use system clipboard by default

vim.o.updatetime = 1250
vim.o.timeout = true
vim.o.timeoutlen = 500

vim.o.foldcolumn = "0"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.autoread = true

-- LazyVim's auto format 
-- Disabling this option means before every buffer write the formatter will be run
vim.g.autoformat = true

-- https://neovim.io/doc/user/luvref.html#uv.os_uname()
if vim.uv.os_uname().sysname == "Linux" then
	vim.o.shell = "zsh"
else
	vim.o.shell = "pwsh"
end

-- Language specific settings

-- Rust
-- vim.g.rust_recommended_style = false
