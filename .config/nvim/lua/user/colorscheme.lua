local M = {
  "ellisonleao/gruvbox.nvim",
<<<<<<< HEAD
  --commit = "e52c41314e83232840d6970e6b072f9fba242eb9",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 100, -- make sure to load this before all the other start plugins
=======
  -- commit = "e52c41314e83232840d6970e6b072f9fba242eb9",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4
}

M.name = "gruvbox"
function M.config()
<<<<<<< HEAD
  local status_ok, some_error pcall(vim.cmd.colorscheme, M.name)
=======
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4
  if not status_ok then
    return
  end
end

return M
