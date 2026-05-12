local map = vim.keymap.set

-- ; as : for faster command entry, ;; to keep original find-char ;
map({ "n", "v", "o" }, ";", ":", { noremap = true })
map({ "n", "v", "o" }, ";;", ";", { noremap = true })

-- Split navigation
map("n", "<C-h>", "<C-w>h", { noremap = true })
map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })

-- Split resize
map("n", "-", "<C-w>-", { noremap = true })
map("n", "+", "<C-w>+", { noremap = true })
map("n", "<C-n>", "<C-w><", { noremap = true })
map("n", "<C-m>", "<C-w>>", { noremap = true })

-- Zoom current split to max; <C-w>= to equalize
map("n", "<C-w>z", "<C-w>_ | <C-w>|", { noremap = true })
-- Remap <C-w>o (close others) to zoom to prevent accidental split closing
map("n", "<C-w>o", "<C-w>z", { noremap = true })

-- Move visual selection up/down
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true })

-- Clear search highlight and close floating windows
map("n", "<Esc>", function()
  vim.cmd("nohlsearch")
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { silent = true })

-- Commands
vim.api.nvim_create_user_command("Prettier", function()
  require("conform").format({ formatters = { "prettier" } })
end, {})

-- Abbreviations
vim.cmd("cnoreabbrev E Oil")
