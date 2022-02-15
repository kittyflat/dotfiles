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

" https://github.com/wesQ3/vim-windowswap
" Enter `\ww` in one window, and repeat in another window to swap
Plug 'wesQ3/vim-windowswap'

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
    \ 'left': [ [ 'relativepath', 'modified' ] ],
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

Plug 'airblade/vim-gitgutter' " Show git additions/changes/deletions in gutter

" JavaScript syntax
Plug 'pangloss/vim-javascript'

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
"
" CoC extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-diagnostic']

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
" Using :set gdefault creates confusion because then %s/// is global,
" whereas %s///g is not (that is, g reverses its meaning).
" https://vim.fandom.com/wiki/Search_and_replace
" set gdefault
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

au BufNewFile,BufRead *.ru,*.god,*.rabl,*.arb             set ft=ruby
au BufNewFile,BufRead *.hcl                               set ft=terraform
au BufNewFile,BufRead nginx*.conf,/etc/nginx/conf/*.conf  set ft=nginx
au BufNewFile,BufRead *.tsx                               set filetype=typescriptreact

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
