vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

-- File Explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

