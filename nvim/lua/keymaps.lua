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
map("n", "<ESC><ESC>", function()
  vim.cmd("nohlsearch")
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { silent = true })

-- File explorer
map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })

-- Telescope (defined here for discoverability; plugin lazy-loads on use)
map("n", "<C-p>", "<CMD>Telescope find_files<CR>")
map("n", "<C-f>", function()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  require("telescope.builtin").live_grep({ cwd = git_root })
end)
map("n", "<leader>f", "<CMD>Telescope live_grep<CR>")

-- Format (also set per-buffer on LspAttach in lsp.lua)
map({ "n", "v" }, "<leader>p", function()
  require("conform").format({ lsp_fallback = true })
end)

-- Commands
vim.api.nvim_create_user_command("Prettier", function()
  require("conform").format({ formatters = { "prettier" } })
end, {})

-- Abbreviations
local abbrevs = {
  { "E",    "Oil" },
  { "Gb",   "Git blame" },
  { "Gbl",  "Git blame" },
  { "Gbla", "Git blame" },
}
for _, a in ipairs(abbrevs) do
  vim.cmd(string.format("cnoreabbrev %s %s", a[1], a[2]))
end
