local au = vim.api.nvim_create_autocmd

-- Filetype detection
au({ "BufNewFile", "BufRead" }, { pattern = { "*.ru", "*.god", "*.rabl", "*.arb" }, command = "set ft=ruby" })
au({ "BufNewFile", "BufRead" }, { pattern = "*.hcl", command = "set ft=terraform" })
au({ "BufNewFile", "BufRead" }, { pattern = { "nginx*.conf", "/etc/nginx/conf/*.conf" }, command = "set ft=nginx" })
au({ "BufNewFile", "BufRead" }, { pattern = ".env.*", command = "set ft=sh" })
au({ "BufNewFile", "BufRead" }, { pattern = ".yml.*", command = "set ft=yaml" })

-- Format on save (mirrors coc-settings.json formatOnSaveFiletypes)
au("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.css", "*.md" },
  callback = function(ev)
    require("conform").format({ bufnr = ev.buf, lsp_fallback = true })
  end,
})
