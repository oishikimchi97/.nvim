---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- tmux navigator (migrated from core/mappings.lua)
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Window left" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Window right" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Window up" },

    -- custom mappings
    ["<Leader>s"] = { ":s/<C-r><C-w>/", "Substitute word under cursor" },
    ["<Leader>r"] = { ":registers<CR>", "Show registers" },
    ["<Leader>ps"] = { "<cmd>Lazy sync<CR>", "Lazy sync" },
    ["<Leader>fs"] = { "<cmd>w<CR>", "File save" },
    ["<Leader>,"] = { "<cmd>Telescope buffers<CR>", "Switch buffer" },
    ["<Leader><Leader>"] = { "<cmd>Telescope frecency workspace=CWD<CR>", "Find file (frecency)" },
    ["<Leader>qq"] = { "<cmd>confirm qa<CR>", "Quit all" },

    -- telescope frecency override (migrated from core/mappings.lua)
    ["<leader>ff"] = { "<cmd>Telescope frecency workspace=CWD<CR>", "Find files (frecency)" },
  },

  t = {
    -- tmux navigator in terminal mode (migrated from core/mappings.lua)
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Window left" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Window up" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Window right" },
  },
}

M.dataviewer = {
  n = {
    ["<leader>df"] = {
      function()
        require("nvterm.terminal").send("fx " .. vim.fn.expand "%:p", "float")
      end,
      "Open in fx (JSON/YAML)",
    },
    ["<leader>dt"] = {
      function()
        require("nvterm.terminal").send("tw " .. vim.fn.expand "%:p", "float")
      end,
      "Open in Tabiew (CSV/table)",
    },
    ["<leader>dF"] = {
      function()
        local lines = vim.fn.input("Lines to load (default 1000): ", "1000")
        local file = vim.fn.expand "%:p"
        require("nvterm.terminal").send("head -n " .. lines .. " " .. file .. " | fx", "float")
      end,
      "Open in fx (partial)",
    },
    ["<leader>dT"] = {
      function()
        local lines = vim.fn.input("Lines to load (default 1000): ", "1000")
        local file = vim.fn.expand "%:p"
        require("nvterm.terminal").send("head -n " .. lines .. " " .. file .. " | tw", "float")
      end,
      "Open in Tabiew (partial)",
    },
  },
}

return M
