vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldlevel = 99 -- start with all folds open

vim.keymap.set("n", "<Tab>", "za", { buffer = true, desc = "Toggle fold" })
vim.keymap.set("n", "<S-Tab>", "zA", { buffer = true, desc = "Toggle fold recursively" })
