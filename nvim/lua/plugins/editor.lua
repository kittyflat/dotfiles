return {
  -- Surround text objects (upgrade from vim-surround)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Commenting (gc / gcc)
  { "tpope/vim-commentary" },

  -- Text coercion and substitution (crs, crc, cru, etc.)
  { "tpope/vim-abolish" },

  -- Session management
  { "tpope/vim-obsession" },

  -- Window swapping (\ww in two windows)
  { "wesQ3/vim-windowswap" },

  -- File explorer (replaces netrw / :E)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
    },
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {},
  },

  -- Language-specific
  { "hashivim/vim-terraform" },
  { "keith/rspec.vim" },
}
