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
<<<<<<< HEAD
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
=======
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)
>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
<<<<<<< HEAD
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffer
keymap("n", "<leader>c", "<cmd>Bdelete<CR>", opts)
-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)
=======
keymap("n", "<leader>s", "<cmd>nohlsearch<CR>", opts)

-- Close buffer
keymap("n", "<leader>c", "<cmd>Bdelete<CR>", opts)
>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4

-- Better paste
keymap("v", "p", "P", opts)

<<<<<<< HEAD
=======
-- Inlay Hints
keymap("n", "<leader>h", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", opts)

>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4
-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

<<<<<<< HEAD
-- netrw
-- keymap("n", "<leader>e", ":Ex<CR>", opts)

keymap("n", "-", "<CMD>Oil<CR>", opts)

=======
-- Toggle NetRW
-- keymap("n", "<leader>e", ":Lexplore<CR>", opts)

-- Toggle Oil
keymap("n", "-", "<CMD>Oil<CR>", opts)

-- Toggle Terminal
keymap("n", "<leader>t", ":Toggleterm<CR>")

>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4
-- -- Telescope
-- keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
-- keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
-- keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
<<<<<<< HEAD
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- -- DAP
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
=======
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
>>>>>>> 0d0cf315624b7ef3db82bd0494eac8a73101e4d4
