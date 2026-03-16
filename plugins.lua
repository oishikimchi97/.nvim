local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override which-key to load on VeryLazy instead of <leader> key trigger
  {
    "folke/which-key.nvim",
    keys = {},
    event = "VeryLazy",
  },

  -- Override plugin definition options
  -- 
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },
  {
    "tpope/vim-surround",
    lazy = false
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      { "<leader>l", mode = { "n", "x", "o" }, function() require("flash").jump({ search = { mode = "search" }, pattern = "^", label = { after = { 0, 0 } } }) end, desc = "Flash jump to line" },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
      heading = {
        position = 'inline',
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      -- heading navigation: ]h = next heading, [h = previous heading
      vim.keymap.set("n", "]h", function()
        vim.fn.search("^#", "W")
      end, { desc = "Next heading", buffer = false })
      vim.keymap.set("n", "[h", function()
        vim.fn.search("^#", "bW")
      end, { desc = "Previous heading", buffer = false })
    end,
  },

  {
    "crispgm/telescope-heading.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    ft = { "markdown" },
    config = function()
      require("telescope").load_extension("heading")
      vim.keymap.set("n", "<leader>mh", "<cmd>Telescope heading<CR>", { desc = "Markdown headings" })
    end,
  },

  {
    "HakonHarnes/img-clip.nvim",
    ft = { "markdown", "latex", "typst", "rst", "org" },
    opts = {
      default = {
        dir_path = "assets",
        prompt_for_file_name = false,
        relative_to_current_file = true,
      },
    },
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
    },
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },

  {
    "sphamba/smear-cursor.nvim",
    lazy = false,
    opts = {},
  },

  {
    "3rd/diagram.nvim",
    dependencies = {
      {
        "3rd/image.nvim",
        opts = {
          tmux_show_only_in_active_window = true,
          editor_only_render_when_focused = true,
        },
      },
    },
    ft = { "markdown", "norg" },
    opts = {
      renderer_options = {
        mermaid = {
          scale = 10,
          theme = "dark",
          background = "transparent",
        },
      },
    },
    keys = {
      { "<leader>md", function() require("diagram").show_diagram_hover() end, desc = "Diagram hover (large)", ft = { "markdown", "norg" } },
      { "<leader>mo", function()
        local cache_dir = vim.fn.stdpath("cache") .. "/diagram-cache/mermaid"
        local files = vim.fn.glob(cache_dir .. "/*.png", false, true)
        if #files > 0 then
          -- sort by modification time, open most recent
          table.sort(files, function(a, b)
            return vim.fn.getftime(a) > vim.fn.getftime(b)
          end)
          vim.ui.open(files[1])
        else
          vim.notify("No diagram image found", vim.log.levels.WARN)
        end
      end, desc = "Open diagram in editor", ft = { "markdown", "norg" } },
    },
  },

  {
    "lervag/vimtex",
    ft = { "tex", "latex", "bib" },
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }
      vim.fn.serverstart("/tmp/nvim_vimtex")
    end,
  },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject diff" },
    },
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
