local au = vim.api.nvim_create_autocmd

-- Filetype detection
au({ "BufNewFile", "BufRead" }, { pattern = { "*/ghostty/config", "*.ghostty" }, command = "set ft=ghostty" })

-- Keep scroll-wheel scrolling but drop click-to-position in normal editing
-- buffers only, so clicks still work in Oil, pickers, and other plugin UIs.
au("BufWinEnter", {
  callback = function()
    if vim.bo.buftype == "" then
      -- Note: deliberately excludes visual mode — a click there must still
      -- cancel the selection as normal, or an accidental click leaves you
      -- stuck in visual mode and scrolling looks like it's extending a
      -- highlight.
      for _, mode in ipairs({ "n", "i" }) do
        for _, click in ipairs({ "<LeftMouse>", "<2-LeftMouse>", "<3-LeftMouse>", "<4-LeftMouse>" }) do
          vim.keymap.set(mode, click, "<Nop>", { buffer = true })
        end
        vim.keymap.set(mode, "<LeftDrag>", "<Nop>", { buffer = true })
        vim.keymap.set(mode, "<LeftRelease>", "<Nop>", { buffer = true })
      end
    end
  end,
})
