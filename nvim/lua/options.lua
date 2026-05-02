local opt = vim.opt

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

-- Display
opt.number = true
opt.colorcolumn = "120"
opt.scrolloff = 5
opt.background = "dark"
opt.termguicolors = true
opt.cursorline = true
opt.cursorcolumn = true
opt.showmode = false  -- lualine shows mode
opt.ruler = true
opt.laststatus = 3    -- global statusline (neovim feature)

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Behavior
opt.mouse = ""
opt.timeoutlen = 500
opt.clipboard = "unnamed"
opt.history = 1000
opt.fileformat = "unix"
opt.updatetime = 300
opt.hidden = false
opt.backspace = "indent,eol,start"
opt.belloff = "all"

-- Wild menu
opt.wildmenu = true
opt.wildmode = "list:longest"
opt.wildignore = "*/tmp/*,*.so,*.swp,*.zip,*.pyc"

-- Persistent undo + swap/backup (stored in neovim data dir)
local data = vim.fn.stdpath("data")
opt.swapfile = true
opt.directory = data .. "/swap"
opt.backup = true
opt.backupdir = data .. "/backup"
opt.undofile = true
opt.undodir = data .. "/undo"

-- Ensure directories exist
for _, dir in ipairs({ data .. "/swap", data .. "/backup", data .. "/undo" }) do
  vim.fn.mkdir(dir, "p")
end

-- Project-specific .nvim.lua
opt.exrc = true
opt.secure = true
