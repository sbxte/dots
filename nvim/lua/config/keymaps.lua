-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "t" }, "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode with double escape" })

-- Remap macro recording from q to alt q <M-q>
-- Use q for closing windows instead
map({ "n", "v" }, "q", function()
	-- Catch "cannot close last window" error with pcall and ignore it
	pcall(vim.api.nvim_win_close, vim.api.nvim_get_current_win(), false)
end, { noremap = true, desc = "Close currently focused window" })

map({ "n", "v" }, "<M-q>", "q", { noremap = true, desc = "Record vim macro" })
