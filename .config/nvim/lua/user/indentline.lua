local M = {
  "lukas-reineke/indent-blankline.nvim",
  -- main = "ibl",
  -- commit = "8299fe7703dfff4b1752aeed271c3b95281a952d",
  event = "BufReadPre",
  opts = {
  },
  config = function()
    local highlight = {
      "NeutralBlue",
      "NeutralOrange",
      "NeutralGreen",
      "NeutralViolet",
      "NeutralCyan",
      "NeutralRed",
      "NeutralYellow",
    }

    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "NeutralRed", { fg = "#db2814" })
      vim.api.nvim_set_hl(0, "NeutralYellow", { fg = "#ca8d0f" })
      vim.api.nvim_set_hl(0, "NeutralBlue", { fg = "#739588" })
      vim.api.nvim_set_hl(0, "NeutralOrange", { fg = "#ee7009" })
      vim.api.nvim_set_hl(0, "NeutralGreen", { fg = "#b8bb26" })
      vim.api.nvim_set_hl(0, "NeutralViolet", { fg = "#d3869b" })
      vim.api.nvim_set_hl(0, "NeutralCyan", { fg = "#689d6a" })
    end)

    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

    -- hooks.register(hooks.type.WHITESPACE,
    --   hooks.builtin.hid_first_space_indent_level
    -- )
    require("ibl").setup{ indent = { highlight = highlight, char = "▏" } }
  end,
}

return M
