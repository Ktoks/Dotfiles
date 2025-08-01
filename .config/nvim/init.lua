vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.backup = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"
vim.o.undofile = true
vim.o.cmdheight = 1
vim.o.completeopt = "menuone"
vim.o.fileencoding = "utf-8"
vim.o.ruler = true
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.mouse = "a"
vim.o.pumheight = 10
vim.o.smartcase = true
vim.o.showmode = false
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.updatetime = 300
vim.o.showtabline = 0
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.cursorline = true
vim.o.laststatus = 3
vim.o.numberwidth = 4
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.clipboard = "unnamedplus"
-- vim.o.shortmess:append "c"
-- vim.o.whichwrap:append "<,>,[,],h,l"
vim.o.fileformat = "unix"
vim.o.guifont = "FiraCode Nerd Font Mono:h14"

vim.keymap.set('n', '<leader>r', ':update<CR> :source<CR>')

vim.pack.add({
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})
require "which-key".setup{}

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
  ensure_installed = { "python", "bash" },
  highlight = { enable = true }
})

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")

vim.lsp.enable({"lua_ls", "bashls"})
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


