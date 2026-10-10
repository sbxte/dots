return {
  -- Better tabs
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'BufEnter',
    config = function()
      require('bufferline').setup {
        options = {
          separator_style = 'slant',
          indicator = {
            style = 'icon'
          },
          tab_size = 14,
          truncate_names = false,
          diagnostics = 'nvim_lsp',
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          always_show_bufferline = true
        }
      }
    end
  },

}
