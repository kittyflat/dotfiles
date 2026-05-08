return {
  -- Icons (used by lualine, telescope, oil)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Colorscheme
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      require("ayu").setup({
        mirage = true,
        overrides = {
          Normal       = { bg = "None" },       -- use terminal background
          LineNr       = { fg = "#6b6b47" },
          Comment      = { fg = "#527077" },
          Directory    = { fg = "#36A3D9" },
          Search       = { fg = "#f5deb3", bg = "#6e2c71" },
          CursorLine   = { bg = "#101068" },  -- blue row highlight
          Whitespace   = { fg = "#c63f4f" },  -- trailing space indicator
          IblIndent    = { fg = "#252b38" },  -- nearly invisible inactive guides
          IblScope     = { fg = "#4d5566" },  -- visible scope highlight
        },
      })
      vim.cmd("colorscheme ayu")
    end,
  },

  -- Statusline (replaces lightline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "ayu_dark", section_separators = "", component_separators = "" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "readonly", { "filename", path = 1 }, "modified" },
        lualine_c = {},
        lualine_x = { "diagnostics", "filetype", "encoding" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { { "filename", path = 1 }, "modified" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      tabline = {
        lualine_a = {},
        lualine_b = { { "tabs", mode = 1, max_length = function() return vim.o.columns end, tabs_color = { active = { fg = "#B3B1AD", gui = "bold" }, inactive = { fg = "#5C6773" } }, fmt = function(name, ctx) return ctx.tabnr .. " " .. name end } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = {
      indent = { char = "│", highlight = "IblIndent" },
      scope  = { enabled = true, highlight = "IblScope" },
    },
  },

  -- Keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

}
