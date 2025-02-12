require("lazy").setup({
  spec = {
    -- 🌈 Colorscheme
    {
      "rebelot/kanagawa.nvim",
      priority = 1000,
      config = function() vim.cmd.colorscheme("kanagawa") end,
    },

    -- 🌲 Treesitter (Syntax Highlighting)
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function() require("config.treesitter") end },

    -- 🔍 Telescope (Fuzzy Finder)
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("config.telescope") end },

    -- 📂 File Explorer (NvimTree)
    { "nvim-tree/nvim-tree.lua", config = function() require("config.nvimtree") end },

    -- 📝 Neorg (Notes)
    { "nvim-neorg/neorg", lazy = false, version = "*", config = function() require("config.neorg") end },

    -- 📌 Statusline
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("config.statusline") end },

    -- 🌿 Git Integration (Gitsigns)
    { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },

    -- 🚀 LSP
    { "williamboman/mason.nvim", config = function() require("mason").setup() end },
    { "neovim/nvim-lspconfig", dependencies = { "williamboman/mason.nvim" }, config = function() require("config.lsp") end },

    -- 🔥 Autocompletion
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
      end,
    },
  },
})

