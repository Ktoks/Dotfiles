local M = {
  "ellisonleao/gruvbox.nvim",
  --commit = "e52c41314e83232840d6970e6b072f9fba242eb9",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 100, -- make sure to load this before all the other start plugins
}

M.name = "gruvbox"
function M.config()
  local status_ok, some_error pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
