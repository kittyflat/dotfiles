set nocompatible

" Don't need filetype off/on trick with vim-plug
" https://github.com/junegunn/vim-plug/issues/83
" filetype off

" Plug plugin manager https://github.com/junegunn/vim-plug
" To install:
" Download plug.vim and put it under ~/.vim/autoload/
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Run :PlugInstall
call plug#begin()

Plug 'tpope/vim-sensible'
" Minimal informative tablines
" Plug 'lukelbd/vim-tabline'
" Plug 'mkitt/tabline.vim'


" Plug 'webdevel/tabulous'
" let tabulousCloseStr = ''
" " Don't remove path and type
" " The defaults are :t:r which remove directories and file extension from a tab label name.
" let tabulousLabelNameOptions = ':t'
" let tabulousLabelLeftStr = ' '
" " Map C-t to rename tab
" noremap <C-t> :call g:tabulous#renameTab()<cr>

" https://github.com/wesQ3/vim-windowswap
" Enter `\ww` in one window, and repeat in another window to swap
Plug 'wesQ3/vim-windowswap'

" For Prettier
" https://github.com/prettier/prettier/blob/master/docs/vim.md
Plug 'sbdchd/neoformat'
" autocmd BufWritePre *.js Neoformat
" https://github.com/sbdchd/neoformat
augroup fmt
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.ts Neoformat
augroup END
" autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --parser\ flow\ --single-quote\ --trailing-comma\ es5
autocmd FileType javascript,javascriptreact setlocal formatprg=npx\ prettier\ --stdin\ --stdin-filepath\ %
autocmd FileType typescript,javascriptreact setlocal formatprg=npx\ prettier\ --parser\ typescript\ --stdin\ --stdin-filepath\ %
" Use formatprg when available
let g:neoformat_try_formatprg = 1
noremap <leader>p :Neoformat<cr>

" vim-prettier doesn't return cursor to original position on splits
" Plug 'prettier/vim-prettier'
" let g:prettier#quickfix_enabled = 0 " disable quickfix
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jdb/models/TermPolicy/Helpers/manage/issue.jssx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" home-made prettier mapping, difficulty returning cursor/scroll
" noremap <leader>p ma :%!prettier --stdin --stdin-filepath %<cr> `a
" " autocmd BufWritePre *.js ma :%!prettier --stdin-filepath % `a

" disabled prettier in ale because it didn't respect .prettierignore? is it
" possible to fix that? seems hard to pass stdin/stdin-filepath or ignore-path options
" still using ale for eslint
Plug 'w0rp/ale' " Linter
let g:ale_fixers = {}
" let g:ale_fixers['javascript'] = ['prettier']
let g:ale_linters_explicit = 1
let g:ale_linters = {}
let g:ale_linters['javascript'] = ['eslint']
" let g:ale_javascript_prettier_use_local_config = 1
" let g:ale_javascript_prettier_options = ' --no-semi --single-quote --trailing-comma es5'
let g:ale_lint_delay = 500
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'always'
" let g:ale_fix_on_save = 1
let g:ale_set_signs = 1
let g:ale_sign_warning = '!'
let g:ale_sign_error = 'x'
" let g:ale_sign_offset = 1000000
let g:ale_change_sign_column_color = 1

" Plug 'valloric/youcompleteme' " Completion framework
" From https://github.com/getethos/devops/blob/master/dev/vim/.vimrc#L81
" let g:ycm_auto_trigger = 0
" let g:ycm_min_num_of_chars_for_completion = 4
" let g:ycm_min_num_identifier_candidate_chars = 4
" let g:ycm_enable_diagnostic_highlighting = 0
" let g:javascript_plugin_jsdoc = 1
"
" " Disables inline preview when typing
" set completeopt-=preview
" let g:ycm_add_preview_to_completeopt = 0

" " Fancy status lines
" " https://github.com/vim-airline/vim-airline
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let g:airline_extensions = []
" let g:airline_highlighting_cache = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline_powerline_fonts = 1
" " let g:airline_theme='dark_minimal'
" let g:airline_theme='ayu'

" To enable folding in general see:
" https://github.com/getethos/devops/blob/master/dev/vim/.vimrc#L81
Plug 'Konfekt/FastFold' " Supposed to solve slow code folding

" Plug 'Raimondi/delimitMate' " adds closing delimiters

Plug 'tpope/vim-abolish' " https://github.com/tpope/vim-abolish
Plug 'tpope/vim-commentary' " Comment lines
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'tpope/vim-markdown'
"Plug 'gabrielelana/vim-markdown'
" Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

" Minimal status line
Plug 'itchyny/lightline.vim'
" -- INSERT -- is unnecessary anymore because the mode information is displayed
" in the statusline.
set noshowmode
let g:lightline = {
      \   'colorscheme': 'ayu_mirage',
      \ }
      " \   'active': {
      " \     'left': [ ['mode', 'paste'], ['readonly', 'filename', 'modified'] ]
      " \   },
      " \   'inactive': {
      " \     'left': [ ['relativepath'] ],
      " \     'right': [ ['lineinfo'], ['percent'] ]
      " \   },
      " \   'component_function': {
      " \     'gitbranch': 'FugitiveHead',
	    " \     'fileformat': 'LightlineFileformat',
      " \   },
      " \ }

let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'readonly', 'relativepath', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ], [ 'percent' ] ] }
    " \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
let g:lightline.inactive = {
    \ 'left': [ [ 'relativepath' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ] ] }

let g:lightline.component_function = { 'gitbranch': 'FugitiveHead' }
" \ 'fileformat': 'LightlineFileformat' },
" function! LightlineFileformat()
"   return winwidth(0) > 70 ? &fileformat : ''
" endfunction

let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'gitbranch' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
let g:lightline.tab = {
      \ 'active': [ 'tabnum', 'filename', 'modified' ],
      \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

function! LightlineFilename()
  return winwidth(0) > 70 ? &filename : &relativepath
endfunction

"Plug 'kchmck/vim-coffee-script'
"Plug 'groenewege/vim-less'
"Plug 'mileszs/ack.vim'
"Plug 'Lokaltog/vim-powerline'
"Plug 'evanmiller/nginx-vim-syntax'
"Plug 'matchit.zip'
" Plug 'flazz/vim-colorschemes'

"let g:yankring_history_dir="~"
"let g:yankring_history_file=".yankring"
"let g:yankring_zap_keys = 'f F t T / ?'
"noremap <leader>y :YRShow<cr>

" Plug 'altercation/vim-colors-solarized'
" let g:solarized_termtrans=0
" let g:solarized_termcolors=256
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"

" Plug 'kien/ctrlp.vim'
"" let g:ctrlp_user_command = 'find %s -type f'
"let g:ctrlp_working_path_mode = 'rc'
"let g:ctrlp_custom_ignore = { 'dir': '\.git$\|\.hg$\|\.svn$' }
"noremap <leader>p :CtrlP<cr>

" set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules/*,dist/*
" let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|node_modules|dist|coverage)$'

" Fuzzy finder
" fzf#install() makes sure that you have the latest binary
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

" Don't use default popup window for fzf (this scrolls the current window a
" lot more and results in losing the current line))
" let g:fzf_layout = { 'down': '40%' }

" Better layout for opening window from bottom
" https://github.com/junegunn/fzf/issues/1825#issuecomment-575863230
let g:fzf_layout = { 'window': "execute 'botright' float2nr(ceil(0.4 * &lines)) 'new'" }

" Customize fzf colors to match your color scheme (This doesn't really work)
" - fzf#wrap translates this to a set of `--color` options
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

" Advanced fzf customizations
" https://github.com/junegunn/fzf.vim#example-customizing-files-command
" command! -bang -nargs=? -complete=dir Files
"     \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview']}, <bang>0)

" Fzf git grep wrapper
" https://github.com/junegunn/fzf.vim/blob/master/README.md#example-git-grep-wrapper
" https://github.com/junegunn/fzf.vim/issues/676#issuecomment-407964464
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" https://github.com/junegunn/fzf.vim#example-rg-command-with-preview-window
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Plug 'scrooloose/nerdtree'
" let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.sock$']
" noremap <leader>n :NERDTreeToggle<cr>

Plug 'airblade/vim-gitgutter' " Show git additions/changes/deletions in gutter

"Plug 'nathanaelkane/vim-indent-guides' " Show indent guides
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 3
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey
"" hi IndentGuidesOdd  guibg=red   ctermbg=3
"" hi IndentGuidesEven guibg=green ctermbg=4
"let g:indent_guides_color_change_percent = 10

" https://github.com/Yggdroot/indentLine
" Plug 'Yggdroot/indentLine'
" " IndentLine {{
" let g:indentLine_char = ''
" let g:indentLine_first_char = ''
" let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_setColors = 0
" }}

" Ruby/Rails stuff now ships with vim by default?
" Plug 'vim-ruby/vim-ruby'
" Plug 'tpope/vim-rails'
" Plug 'slim-template/vim-slim'

" JavaScript syntax
" breaks in certain situations with backticks, not sure if it still happens
" with maxmellon/vim-jsx-pretty
Plug 'pangloss/vim-javascript'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'othree/yajs'
" Plug 'othree/javascript-libraries-syntax'
" let g:used_javascript_libs = 'react'

" JSX
" Package is deprecated
" Plug 'mxw/vim-jsx'
" let g:jsx_ext_required = 0
Plug 'maxmellon/vim-jsx-pretty'

" JSON
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" TypeScript
Plug 'leafgarland/typescript-vim' " TypeScript highlighting
Plug 'ianks/vim-tsx' " TypeScript for React tsx

" Completion
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Otherwise complains node version 10.6.0 < 10.12.0
" let g:coc_disable_startup_warning = 1
" CoC extensions
" solargraph requires `gem install solargraph`
let g:coc_global_extensions = ['coc-tsserver', 'coc-solargraph']

" " Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" https://github.com/neoclide/coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>p  <Plug>(coc-format-selected)
nmap <leader>p  <Plug>(coc-format-selected)

" " Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Press ESC twice to close COC tips (they sometimes get stuck on the screen)
" https://www.reddit.com/r/vim/comments/jzjbdd/coc_auto_suggestions_are_stuck_on_the_screen/gdflzy0?utm_source=share&utm_medium=web2x&context=3
" nnoremap <silent> <ESC><ESC> :nohlsearch \| match none \| 2match none \| call coc#float#close_all()<CR>
nnoremap <silent> <ESC><ESC> :call coc#float#close_all()<CR>

Plug 'ayu-theme/ayu-vim' " or other package manager

Plug 'hashivim/vim-terraform'

Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_guicolor='#c63f4f'

Plug 'keith/rspec.vim'
call plug#end()

" These are added by default with `vim-plug`
" https://github.com/junegunn/vim-plug/issues/379
"
" syntax on             " Enable syntax highlighting
" filetype on           " Enable filetype detection
" filetype indent on    " Enable filetype-specific indenting
" filetype plugin on    " Enable filetype-specific plugins

" let loaded_matchparen = 1
" let python_highlight_all = 1

" if has("gui_running")
"   set guioptions+=mLlRrb
"   set guioptions-=mLlRrb
"   set guioptions-=T
"   set guioptions+=c
"   " set guifont=Profont:h9
" endif

" " Status line
" " set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%8p
" " source: http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" " set statusline=%t       "tail of the filename
" set statusline=%f       " typed/relative path
" set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
" set statusline+=%{&ff}] " file format
" set statusline+=%h      " help file flag
" set statusline+=%m      " modified flag
" set statusline+=%r      " read only flag
" set statusline+=%y      " filetype
" set statusline+=%=      " left/right separator
" set statusline+=%c,     " cursor column
" set statusline+=%l/%L   " cursor line/total lines
" set statusline+=\ %P    " percent through file
" highlight StatusLine cterm=NONE ctermfg=8 ctermbg=3

" set nocompatible
set tabstop=2 "how many cols each tab counts for
set shiftwidth=2
set softtabstop=2
set expandtab
" set nowrap
set number "display line numbers
" http://joshorourke.com/2012/06/29/vim-tip-how-to-use-vertical-guides
set colorcolumn=80
set swapfile
set dir=~/.vim/tmp/swap
set backup
set backupdir=~/.vim/tmp/backup
set backupskip=~/.vim/tmp/backup/*
set writebackup
set undodir=~/.vim/tmp/undo
set scrolloff=5             " Keep 5 lines around the cursor
" set splitright
set background=dark
set mouse=
set backspace=2
set laststatus=2
set ruler
set gdefault
set noerrorbells
set t_vb=
set vb
set autoindent
set ttyfast
set wildmenu                " turn on wild menu :e <Tab>
set wildmode=list:longest   " set wildmenu to list choice
set wildignore=*/tmp/*,*.so,*.swp,*.zip,*.pyc
set nohidden
set cryptmethod=blowfish
set hlsearch
set noantialias
set incsearch
set ignorecase
set smartcase
set timeoutlen=500 " Timeout for double-key presses
set clipboard=unnamed " iTerm, allow yank to go to OS clipboard
"set t_Co=256 "http://vim.wikia.com/wiki/256_colors_in_vim
set history=200 " Keep longer history than default
set fileformat=unix
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300


" " Enable/Configure folding
" " From https://github.com/getethos/devops/blob/master/dev/vim/.vimrc#L81
" syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
" " Code folding
" " syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
" set foldenable
" set foldlevel=3
" set foldlevelstart=4
" set foldnestmax=5
" set foldmethod=syntax
" let g:javaScript_fold = 1

" Key mappings
" :help map-which-keys
" Unused keys: https://vim.fandom.com/wiki/Unused_keys

" http://vim.wikia.com/wiki/Map_semicolon_to_colon
noremap ; :
noremap ;; ;
" I don't like this mapping because requires ;; for normal ;
" Instead mapping space to ; works nicely
" Inspiration from https://vim.fandom.com/wiki/Short_mappings_for_common_tasks
" nnoremap <Space> :

" make j,k move btwn visual lines when wrap is enabled
" noremap j gj
" noremap k gk

" noremap <leader>m :MRU<cr>
" noremap <leader>q :qa!<cr>

" Explore
" Alias :E for :Explore
" With plugin 'ntpeters/vim-better-whitespace' just E alone is ambiguous
cnoreabbrev E Explore
cnoreabbrev E! Explore!
cnoreabbrev H Hexplore
cnoreabbrev H! Hexplore!
cnoreabbrev V Vexplore
cnoreabbrev V! Vexplore!

" Move between splits with ctrl+kjhl
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Netrw overrides <C-l> for refresh listing. Map that to <C-r> instead
" @see https://github.com/christoomey/vim-tmux-navigator/issues/53

" augroup navigator
"   autocmd!
"   autocmd FileType netrw call s:reset_netrw_keys()
" augroup END
"
" function s:reset_netrw_keys() abort
"   " nmap <buffer> <silent> <c-h> <Plug>NetrwHideEdit
"   " nmap <buffer> <silent> <c-r> <Plug>NetrwRefresh
"   noremap <C-l> <C-w>l
" endfunction

" Resize window
noremap - <C-w>-
noremap + <C-w>+
noremap <C-n> <C-w><
noremap <C-m> <C-w>>

" Map fzf search to ctrl-p
nnoremap <C-p> :Files<Cr>
" Map Fzf GGrep to ctrl-f
" (Overwrites PageDown but there is Shift-Down/Up and Ctrl-D/U anyway)
nnoremap <C-f> :GGrep<Cr>
nnoremap <leader>f :Rg<Cr>
" unmap <C-g>

" Eh?
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" vnoremap <leader>h :!tidy -q -i<cr><cr>
" vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left> " replace selection
" vnoremap > >gv
" vnoremap < <gv

" XXX This conflicts with moving between splits!
" " Move block of lines
" " https://dockyard.com/blog/2013/09/26/vim-moving-lines-aint-hard
" " Normal mode
" nnoremap <C-j> :m .+1<CR>==
" nnoremap <C-k> :m .-2<CR>==
" " Insert mode
" inoremap <C-j> <ESC>:m .+1<CR>==gi
" inoremap <C-k> <ESC>:m .-2<CR>==gi
" " Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" au Filetype javascript setlocal ts=2 sts=2 sw=2
" au Filetype ruby setlocal ts=2 sts=2 sw=2
" au Filetype haml setlocal ts=2 sts=2 sw=2 indentexpr=
" au Filetype html setlocal ts=2 sts=2 sw=2 indentexpr=
" au Filetype eruby setlocal ts=2 sts=2 sw=2 indentexpr=
" au Filetype htmldjango setlocal ts=2 sts=2 sw=2 indentexpr=
" au Filetype jade setlocal ts=2 sts=2 sw=2 indentexpr=
" au Filetype sass setlocal ts=2 sts=2 sw=2 indentexpr=
" au Filetype yaml setlocal ts=2 sts=2 sw=2
" au Filetype python setlocal ts=4 sts=4 sw=4

au BufNewFile,BufRead *.ru,*.god,*.rabl                   set ft=ruby
au BufNewFile,BufRead *.hcl                               set ft=terraform
au BufNewFile,BufRead nginx*.conf,/etc/nginx/conf/*.conf  set ft=nginx
" au BufNewFile,BufRead *.mobile.erb,*.html.erb,*.jst.ejs   set ft=eruby.html

"colorscheme solarized
"colorscheme molokai
"colorscheme gruvbox
"colorscheme PaperColor
"colorscheme jellybeans
"colorscheme Tomorrow-Night-Eighties

" ayu-theme/ayu-vim
set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
colorscheme ayu
" ayu default's LineNr:
" LineNr         xxx ctermfg=11 guifg=#2D3640

" Color overrides
highlight Normal guibg=#0c1014 " ayu dark bg
highlight LineNr guifg=#6b6b47 " yellowish grey
highlight Comment guifg=#527077 " lighter bluegrey
" customize directory highlight for netrw, etc
highlight Directory guifg=#36A3D9 " ayu's tag color
" let g:netrw_special_syntax=1
" highlight Search guifg=wheat guibg=peru
highlight Search guifg=wheat guibg=#6e2c71
highlight CursorLine guibg=#060060 " darkblue
highlight CursorColumn guibg=#060060 " darkblue
highlight ColorColumn guibg=#320040 " darkpurp
" These get overridden by lightline
" hi StatusLine guifg=#E7E1CF guibg=#14191F
" highlight StatusLine guifg=wheat guibg=peru

" Tabline color theme from https://github.com/mkitt/tabline.vim
" hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
" hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
" hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE

" Highlight current line and column
set cursorline
set cursorcolumn
" hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Enable project-specific .vimrc
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure

" Enable true color under tmux (doesn't seem necessary)
" https://github.com/tmux/tmux/issues/1246
" if exists('+termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif


" Set tablines (using https://github.com/lukelbd/vim-tabline)
" :help setting-tablines
" set tabline=%!MyTabLine()
" function MyTabLine()
"   let s = ''
"   for i in range(tabpagenr('$'))
"     " select the highlighting
"     if i + 1 == tabpagenr()
"       let s .= '%#TabLineSel#'
"     else
"       let s .= '%#TabLine#'
"     endif

"     " set the tab page number (for mouse clicks)
"     let s .= '%' . (i + 1) . 'T'

"     " the label is made by MyTabLabel()
"     let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
"   endfor

"   " after the last tab fill with TabLineFill and reset tab page nr
"   let s .= '%#TabLineFill#%T'

"   " right-align the label to close the current tab page
"   if tabpagenr('$') > 1
"     let s .= '%=%#TabLine#%999Xclose'
"   endif

"   return s
" endfunction

" function MyTabLabel(n)
"   let buflist = tabpagebuflist(a:n)
"   let winnr = tabpagewinnr(a:n)
"   return bufname(buflist[winnr - 1])
" endfunction
