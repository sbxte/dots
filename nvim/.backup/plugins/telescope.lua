return {
  -- Telescope
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      "debugloop/telescope-undo.nvim",
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      'LukasPietzschmann/telescope-tabs',


      'debugloop/telescope-undo.nvim',
    },
    init = function()
      local ts = require('telescope')

      ts.setup {
	extensions = {
	  undo = {
	    use_delta = true,
	    use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
	    side_by_side = true,
	    diff_context_lines = vim.o.scrolloff,
	    entry_format = "state #$ID, $STAT, $TIME",
	    time_format = "",
	    saved_only = false,
	  },
	},
      }

      local load = function(name)
	ts.load_extension(name)
      end

      load('undo')
      load('file_browser')
      load('live_grep_args')
      load('telescope-tabs')
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}
