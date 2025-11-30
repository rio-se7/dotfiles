-- lua/plugins/git.lua

return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gblame" },
    keys = {
      { "<leader>gs", "<cmd>Git status<CR>", desc = "Git status" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<CR>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git log<CR>", desc = "Git log" },
    },
    config = function()
      -- Optional: additional mappings can go here
      -- Example: :Gbrowse integration etc.
    end,
  },
}
