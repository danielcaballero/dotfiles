-- ~/.config/nvim/lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Sensible defaults
  { "tpope/vim-sensible" },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "go", "javascript", "typescript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local api = require("nvim-tree.api")
      require("nvim-tree").setup({
        update_focused_file = { enable = true },
        view = { width = 30 },
        on_attach = function(bufnr)
          api.config.mappings.default_on_attach(bufnr)
        end,
      })
    end,
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!**/.git/*",
            "--glob=!**/node_modules/*"
          },
        },
      })
    end,
  },

  -- Mason for managing external tools like LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "gopls" }, -- add more if needed
      })
    end,
  },

  -- LSP support
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua LSP config
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            format = { enable = true },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Go LSP config
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              unusedwrite = true,
            },
            staticcheck = true,
          },
        },
      })
      -- TypeScript/JavaScript LSP config
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          -- Turn off formatting if using Prettier or something else
          client.server_capabilities.documentFormattingProvider = false
          -- Optional: keymaps or other setup per buffer
        end,
        -- Optional: filetypes if you want to limit to JS/TS
        -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })
    end,
  },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Statusline
  { "nvim-lualine/lualine.nvim" },

  -- Colorscheme
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  -- },
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      -- Optional: Set style (available: "dark", "light")
      vim.o.background = "dark"

      require("vscode").setup({
        -- Optional configuration
        transparent = false,
        italic_comments = true,
      })

      -- Apply the colorscheme
      vim.cmd("colorscheme vscode")
    end,
  },


  -- GitHub Copilot
  { "github/copilot.vim" }
})
