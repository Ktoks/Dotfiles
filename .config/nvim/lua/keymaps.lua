-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>s", "<cmd>nohlsearch<CR>", opts)

-- Close buffer
keymap("n", "<leader>c", "<cmd>Bdelete<CR>", opts)

-- Better paste
keymap("v", "p", "P", opts)

-- Inlay Hints
keymap("n", "<leader>h", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- Toggle NetRW
-- keymap("n", "<leader>e", ":Lexplore<CR>", opts)

-- Toggle Oil
keymap("n", "-", "<CMD>Oil<CR>", opts)

-- Toggle Terminal
keymap("n", "<leader>t", ":Toggleterm<CR>")

-- -- Telescope
-- keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
-- keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
-- keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)

-- -- Snippets
-- Source CMP and Snippets
keymap("n", "<leader><leader>s", "<cmd>source ~/AppData/Local/nvim/lua/user/cmp.lua<CR>")
-- keymap("n", "<leader><leader>x", "<cmd>source ~/AppData/Local/nvim/powerstream.json<CR>")
-- <C-k> = select previous item
-- <C-j> = select next item
-- <C-b> = completions - scroll docs "i", "c" }),
-- <C-f> = completions - scroll docs revers "i", "c" }),
-- <C-Space> = completions - complete
-- <C-e> = completions leader {
  -- <CR> = confirm
  -- <Tab> = mapping
-- }
