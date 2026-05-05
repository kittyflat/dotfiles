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
          layout_config = {
            height = 0.5,         -- taller pane, more room for results
            preview_width = 0.45, -- less preview, more results width
          },
          mappings = {
            i = {
              ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
            },
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
}
