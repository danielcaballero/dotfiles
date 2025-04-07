-- ~/.config/nvim/lua/config/keymaps.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ─────────────────────────────────────────────────────────
-- File explorer toggle
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- ─────────────────────────────────────────────────────────
-- Telescope mappings
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

-- ─────────────────────────────────────────────────────────
-- Copilot accept suggestion
keymap("i", "<C-/>", 'copilot#Accept("<CR>")', { expr = true, silent = true })

-- ─────────────────────────────────────────────────────────
-- Format buffer using LSP (global mapping, will only work if an LSP that supports formatting is attached)
keymap("n", "<leader>f", function()
  vim.lsp.buf.format()
end, { noremap = true, silent = true, desc = "Format file" })

-- ─────────────────────────────────────────────────────────
-- LSP Attach Autocmd (Global LSP Keymaps)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("MyGlobalLspKeymaps", {}),
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Go To Definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    -- Peek/hover doc
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- Rename symbol
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    -- List references
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    -- Diagnostics quickfix
    vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

