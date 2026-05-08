local opt = vim.opt

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

-- Display
opt.number = true
opt.scrolloff = 5
opt.background = "dark"
opt.termguicolors = true
opt.cursorline = true
opt.showmode = false  -- lualine shows mode
opt.ruler = true
opt.laststatus = 3    -- global statusline (neovim feature)
opt.showtabline = 1   -- show tabline only when 2+ tabs (matches classic vim)

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
opt.hidden = true
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

-- Trailing whitespace (native, styled via Whitespace highlight in ui.lua)
opt.list = true
opt.listchars = { trail = "·", tab = "  " }

-- Folding (treesitter-based)
-- Folding (treesitter-based, built-in neovim 0.10+)
-- foldlevelstart=99: files open fully expanded, but zM/zc/zR work immediately.
-- The fold query runs async on first open (reusing the existing parse tree).
-- Alternative: foldenable=false avoids all fold work at open but requires
-- `:set foldenable` before zM/zc will do anything.
-- Source: runtime/lua/vim/treesitter/_fold.lua (M.foldexpr, compute_folds_levels)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevelstart = 99  -- zM/zc to fold, zR to open all

-- Project-specific .nvim.lua
opt.exrc = true
opt.secure = true
