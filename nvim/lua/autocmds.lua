local au = vim.api.nvim_create_autocmd

-- Filetype detection
au({ "BufNewFile", "BufRead" }, { pattern = { "*/ghostty/config", "*.ghostty" }, command = "set ft=ghostty" })
