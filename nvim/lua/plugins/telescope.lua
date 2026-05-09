return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Native fzf sorter for faster fuzzy matching
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<C-p>",      "<CMD>Telescope find_files<CR>",                                                               desc = "Find files" },
      { "<C-f>",      "<CMD>Telescope grep_string<CR>",                                                              desc = "Find word under cursor" },
      { "<leader>ff", "<CMD>Telescope find_files<CR>",                                                               desc = "Find files" },
      { "<leader>fg", "<CMD>Telescope live_grep<CR>",                                                                desc = "Live grep" },
      { "<leader>fw", "<CMD>Telescope grep_string<CR>",                                                              desc = "Find word under cursor" },
      { "<leader>fb", "<CMD>Telescope buffers<CR>",                                                                  desc = "Buffers" },
      { "<leader>fr", function() require("telescope.builtin").oldfiles({ cwd_only = true }) end,                     desc = "Recent files (project)" },
      { "<leader>fR", "<CMD>Telescope oldfiles<CR>",                                                                 desc = "Recent files (all)" },
      { "<leader>fh", "<CMD>Telescope help_tags<CR>",                                                                desc = "Help tags" },
      { "<leader>fk", "<CMD>Telescope keymaps<CR>",                                                                  desc = "Keymaps" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_strategy = "bottom_pane",
          layout_config = {
            height = 0.5,
            preview_width = 0.45,
          },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--hidden", "--no-ignore-vcs", "--exclude", ".git", "--exclude", "node_modules" },
          },
          live_grep = {
            previewer = false,
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
}
