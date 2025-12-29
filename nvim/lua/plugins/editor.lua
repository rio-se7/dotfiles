-- ============================================================================
-- Editor Plugins
-- ============================================================================

return {
  -- Required dependency
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Oil.nvim - Edit your filesystem like a buffer
  {
    "stevearc/oil.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e",  "<cmd>Oil<cr>", desc = "Oil File Explorer" },
      { "<leader>fe", "<cmd>Oil<cr>", desc = "Oil File Explorer" },
      { "-",          "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      -- Default file explorer
      default_file_explorer = true,

      -- Columns to display
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },

      -- Buffer options
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },

      -- Window options
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },

      -- Delete to trash instead of permanently deleting
      delete_to_trash = false,

      -- Skip confirmation for simple edits
      skip_confirm_for_simple_edits = false,

      -- Prompt to save changes when selecting a new entry
      prompt_save_on_select_new_entry = true,

      -- Cleanup delay
      cleanup_delay_ms = 2000,

      -- Constrain cursor (valid values: "editable", "name", nil)
      constrain_cursor = "name", -- Allow cursor on ../ (parent directory)

      -- Watch for external changes
      watch_for_changes = false,

      -- Keymaps
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["<BS>"] = "actions.parent",
        ["h"] = "actions.parent",
      },

      use_default_keymaps = true,

      -- View options
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,

        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          return false
        end,

        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return false
        end,

        -- Natural ordering of file names
        natural_order = true,

        -- Sort file names in a more intuitive order for humans
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },

      -- Configuration for the floating window
      float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },

      -- Configuration for the preview window
      preview = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },

      -- Configuration for the progress window
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)

      -- Make oil the default file explorer
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Open oil when opening a directory
      vim.api.nvim_create_autocmd("BufEnter", {
        desc = "Open Oil when entering a directory",
        pattern = "*",
        callback = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          if vim.fn.isdirectory(bufname) ~= 0 then
            require("oil").open()
          end
        end,
      })

      -- Set absolute line numbers for oil buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = true
        end,
      })
    end,
  },

  -- Which-key for keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      spec = {
        { "g",             group = "goto" },
        { "gz",            group = "surround" },
        { "]",             group = "next" },
        { "[",             group = "prev" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>b",     group = "buffer" },
        { "<leader>c",     group = "code" },
        { "<leader>f",     group = "file/find" },
        { "<leader>g",     group = "git" },
        { "<leader>gh",    group = "hunks" },
        { "<leader>q",     group = "quit/session" },
        { "<leader>s",     group = "search" },
        { "<leader>u",     group = "ui" },
        { "<leader>w",     group = "windows" },
        { "<leader>x",     group = "diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },

  -- Auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
