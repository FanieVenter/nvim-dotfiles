-- 🏗️ Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local output = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "❌ Failed to clone lazy.nvim!\n", "ErrorMsg" },
      { output, "WarningMsg" }
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 📦 Load Lazy.nvim and Plugins
require("lazy").setup({
  {
    -- 🌈 Colorscheme
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function() vim.cmd.colorscheme("kanagawa") end,
  },

  -- 🌲 Treesitter (Syntax Highlighting)
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        highlight = { enable = true },
      })
    end
  },

  -- 🔍 Telescope (Fuzzy Finder)
  { 
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("telescope").setup({}) end
  },

  -- 📂 File Explorer (NvimTree)
  { 
    "nvim-tree/nvim-tree.lua",
    config = function() require("nvim-tree").setup({}) end
  },

  -- 📝 Neorg (Notes & Documentation)
  { 
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = { notes = "~/notes" },
              default_workspace = "notes",
            },
          },
        },
      })
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end
  },

  -- 📌 Statusline (Lualine)
  { 
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "kanagawa",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
      })
    end
  },

  -- 🌿 Git Integration (Gitsigns)
  { 
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup({}) end
  },

  -- 🚀 LSP (Language Server Protocol)
  { 
    "williamboman/mason.nvim",
    config = function() require("mason").setup({}) end
  },

  { 
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("lspconfig").lua_ls.setup({})
    end
  },

  -- 🔥 Autocompletion (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    end
  },
})

-- 🎛️ Basic Editor Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.termguicolors = true

-- 🖥️ Keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
