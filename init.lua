-- Add custom dir to runtimepath so ftplugin/ and after/ are picked up
vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/lua/custom")
vim.wo.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.autoread = true

-- Auto-reload files changed outside nvim (e.g. by Claude Code)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  callback = function()
    vim.cmd("silent! checktime")
  end,
})


-- Remove lazy.nvim's <Space> handler and set leader mappings after all plugins load
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.schedule(function()
      -- Delete the expr mapping on bare <Space> set by lazy.nvim keys handler
      pcall(vim.keymap.del, "n", "<Space>")
      vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope frecency workspace=CWD<CR>", { desc = "Find file (frecency)" })
    end)
  end,
})

-- Disable indent-blankline in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.list = false
    vim.b.indent_blankline_enabled = false
  end,
})

-- Highlight on yank (migrated from core/init.lua)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

-- Switch to English input method when leaving insert mode (macOS only)
if vim.fn.has("mac") == 1 then
  vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
    callback = function()
      vim.fn.jobstart({ "im-select", "com.apple.inputmethod.Kotoeri.RomajiTyping.Roman" }, { detach = true })
    end,
  })
end
