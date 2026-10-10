return {
  -- Leaping and jumping
  {
    'ggandor/leap.nvim',
    init = function()
      local leap = require('leap')

      leap.setup {
        max_phase_one_targets = nil,
        highlight_unlabeled_phase_one_targets = true,
        max_highlighted_traversal_targets = 10,
        case_sensitive = false,
        equivalence_classes = { ' \t\r\n', },
        substitute_chars = {},
        safe_labels = 'sfnut/SFNLHMUGTZ?',
        labels = 'sfnjklhodweimbuyvrgtaqpcxz/SFNJKLHODWEIMBUYVRGTAQPCXZ?',
        special_keys = {
          next_target = '<enter>',
          prev_target = '<tab>',
          next_group = '<space>',
          prev_group = '<tab>',
          multi_accept = '<enter>',
          multi_revert = '<backspace>',
        },
      }
      -- leap.create_default_mappings(true)
    end
  },

}
