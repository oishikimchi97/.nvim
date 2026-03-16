-- Patch NvChad UI for Neovim 0.11+ compatibility

-- Fix: vim.lsp.util.get_progress_messages() removed in Neovim 0.11
local ok, statusline = pcall(require, "nvchad_ui.statusline.default")
if ok and statusline and statusline.LSP_progress then
  statusline.LSP_progress = function()
    return ""
  end
end

-- Fix: vim.lsp.get_active_clients() deprecated in Neovim 0.11
-- Redirect to vim.lsp.get_clients()
if vim.lsp.get_active_clients and not vim.lsp._patched_get_active_clients then
  vim.lsp._patched_get_active_clients = true
  local orig = vim.lsp.get_active_clients
  vim.lsp.get_active_clients = function(...)
    return vim.lsp.get_clients(...)
  end
end
