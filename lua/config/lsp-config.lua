
local servers = { "lua_ls", "rust_analyzer", "zls", "csharp_ls", "pylsp", "ts_ls" }

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers
})

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, lsp in ipairs(servers) do
  require("lspconfig")[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<C-y>"] = cmp.mapping.select_next_item(),
    ["<C-t>"] = cmp.mapping.select_prev_item(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-r>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" }
  })
})

require('nvim-treesitter.configs').setup {
  ensure_installed = { "javascript", "typescript", "tsx" },
  highlight = { enable = true },
}
