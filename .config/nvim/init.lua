vim.g.mapleader = " "
vim.o.backup = false
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 1
vim.o.completeopt = "menuone"
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.fileencoding = "utf-8"
vim.o.fileformat = "unix"
vim.o.guifont = "FiraCode Nerd Font Mono:h14"
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.mouse = "a"
vim.o.number = true
vim.o.numberwidth = 4
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.showtabline = 0
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.tabstop = 4
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 300
vim.o.winborder = "rounded"
vim.o.wrap = false

vim.keymap.set('n', '<leader>u', ':update<CR>')
vim.keymap.set('n', '<leader>r', ':source ~/.config/nvim/init.lua<CR>')

vim.pack.add({
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/ktoks/gruvbox.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require "nvim-treesitter.configs".setup({
  ensure_installed = { "python", "bash", "perl" },
  highlight = { enable = true }
})
require "which-key".setup{}

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")

vim.lsp.enable({"lua_ls", "bashls", "perl-language-server"})
vim.keymap.set('n', '<leader>lf', 'vim.lsp.buf.format')

vim.cmd("colorscheme gruvbox")
vim.cmd(":hi statusline guibg=NONE")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")
vim.keymap.set("n", "<leader>c", ":bdelete<CR>")
vim.keymap.set("v", "p", "P")
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")


