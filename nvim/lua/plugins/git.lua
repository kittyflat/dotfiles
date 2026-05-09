return {
  -- Git signs in gutter + hunk actions
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigate hunks
        map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
        map("n", "[h", gs.prev_hunk, { desc = "Prev hunk" })

        -- Stage / reset hunks
        map({ "n", "v" }, "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
        map({ "n", "v" }, "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })

        -- Inline blame
        map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
      end,
    },
  },

  -- Git commands (:Git blame, :Git diff, etc.)
  { "tpope/vim-fugitive" },
}
