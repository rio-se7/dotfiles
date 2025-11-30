-- lua/plugins/ui.lua

return {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          -- Local mappings for git actions
          local gs = package.loaded.gitsigns
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Navigation between hunks
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, "Next git hunk")

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, "Prev git hunk")

          -- Stage / reset hunks
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
          map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
          map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
          map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

          -- Preview / blame
          map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, "Blame line")

          -- Toggle display
          map("n", "<leader>ht", gs.toggle_current_line_blame, "Toggle line blame")
          map("n", "<leader>hd", gs.diffthis, "Diff this")
        end,
      })
    end,
  },

  -- Oil: file explorer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        delete_to_trash = true,
        keymaps = {
          ["<C-s>"] = "actions.change_sort",
        },
        default_file_explorer = true,
        view_options = {
          show_hidden = true,
        },
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
          "git_status",
        },
      })
      vim.keymap.set(
        "n",
        "<leader>e",
        "<cmd>Oil<CR>",
        { desc = "Open Oil file explorer" }
      )
    end,
  },

  -- Oil git status integration
  {
    "refractalize/oil-git-status.nvim",
    dependencies = { "stevearc/oil.nvim" },
    config = function()
      require("oil-git-status").setup()
    end,
  },
}
