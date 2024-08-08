local M = {
  "nvim-treesitter/nvim-treesitter",
  -- commit = "226c1475a46a2ef6d840af9caa0117a439465500",
  event = "BufReadPost",
  dependencies = {
<<<<<<< HEAD
    -- {
    --   "JoosepAlviste/nvim-ts-context-commentstring",
    --   event = "VeryLazy",
    --   -- commit = "729d83ecb990dc2b30272833c213cc6d49ed5214",
    -- },
=======
>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4
    {
      "nvim-tree/nvim-web-devicons",
      event = "VeryLazy",
    },
  },
}
function M.config()
  local treesitter = require "nvim-treesitter"
  local configs = require "nvim-treesitter.configs"

  configs.setup {
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python" }, -- put the language you want in this array
    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "" },                                                       -- List of parsers to ignore installing
    sync_install = false,                                                          -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true,       -- false will disable the whole extension
<<<<<<< HEAD
      disable = { "css" }, -- list of language that will be disabled
=======
      disable = { "c" }, -- list of language that will be disabled
>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4
    },
    autopairs = {
      enable = true,
    },
<<<<<<< HEAD
    indent = { enable = true, disable = { "python" } },

    -- context_commentstring = {
    --   enable = true,
    --   enable_autocmd = false,
    -- },
=======
    indent = { enable = true, disable = { "python", } },
>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4
  }
end

return M
