return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Native fzf sorter for faster fuzzy matching
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_strategy = "bottom_pane",
          layout_config = { height = 0.4 },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
}
