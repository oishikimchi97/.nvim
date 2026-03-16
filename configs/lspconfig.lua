local capabilities = require("plugins.configs.lspconfig").capabilities

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
})

vim.lsp.config("pyright", {
  capabilities = capabilities,
  filetypes = { "python" },
})

-- servers with default config
local servers = { "html", "cssls", "ts_ls", "clangd" }

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end

vim.lsp.enable(vim.list_extend({ "rust_analyzer", "pyright" }, servers))
