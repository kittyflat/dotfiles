return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Replaces: vim-javascript, vim-jsx-pretty, typescript-vim, vim-tsx,
        --           vim-json, plasticboy/vim-markdown
        ensure_installed = {
          "javascript", "typescript", "tsx", "json", "markdown", "markdown_inline",
          "ruby", "python", "terraform", "lua", "vim", "vimdoc", "bash", "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
