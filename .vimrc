set nocompatible

" ============================================================
" Plugins (vim-plug)
" https://github.com/junegunn/vim-plug
" Install: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Run: :PlugInstall
" ============================================================
call plug#begin()

" Core tpope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" Navigation / search
Plug 'wesQ3/vim-windowswap'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'airblade/vim-gitgutter'

" Statusline
Plug 'itchyny/lightline.vim'

" Syntax / language
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'elzr/vim-json'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'plasticboy/vim-markdown'
Plug 'hashivim/vim-terraform'
Plug 'keith/rspec.vim'
Plug 'vim-utils/vim-ruby-fold'

" LSP / completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colorscheme
Plug 'Luxed/ayu-vim'

" Misc
Plug 'Konfekt/FastFold'
Plug 'ntpeters/vim-better-whitespace'

call plug#end()

" ============================================================
" Plugin config
" ============================================================

" Markdown
let g:vim_markdown_folding_disabled = 1

" Lightline
set noshowmode
let g:lightline = { 'colorscheme': 'ayu_mirage' }
let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'readonly', 'relativepath', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ], [ 'percent' ] ] }
let g:lightline.inactive = {
    \ 'left': [ [ 'relativepath', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ], [ 'percent' ] ] }
let g:lightline.component_function = { 'gitbranch': 'FugitiveHead' }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'gitbranch' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }
let g:lightline.tab = {
      \ 'active': [ 'tabnum', 'filename', 'modified' ],
      \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

" fzf: open in a bottom split instead of a popup (avoids scrolling current buffer)
let g:fzf_layout = { 'window': "execute 'botright' float2nr(ceil(0.4 * &lines)) 'new'" }

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" JSON: always show quotes
let g:vim_json_syntax_conceal = 0

" CoC extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-diagnostic']

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>p  <Plug>(coc-format-selected)
nmap <leader>p  <Plug>(coc-format-selected)

" ESC ESC to close any floating CoC windows
nnoremap <silent> <ESC><ESC> :call coc#float#close_all()<CR>

" Whitespace highlight color
let g:better_whitespace_guicolor='#c63f4f'

" ============================================================
" Settings
" ============================================================

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set number
set colorcolumn=120
set scrolloff=5
set background=dark
set mouse=
set timeoutlen=500
set clipboard=unnamed
set history=1000
set fileformat=unix
set updatetime=300

set swapfile
set dir=~/.vim/tmp/swap
set backup
set backupdir=~/.vim/tmp/backup
set backupskip=~/.vim/tmp/backup/*
set writebackup
set undodir=~/.vim/tmp/undo

set noerrorbells
set t_vb=
set vb

set hlsearch
set ignorecase
set smartcase

set nohidden
set wildignore=*/tmp/*,*.so,*.swp,*.zip,*.pyc
set cryptmethod=blowfish2

" Allow project-specific .vimrc
set exrc
set secure

" ============================================================
" Colors
" ============================================================

set termguicolors
let g:ayucolor="mirage"
colorscheme ayu

highlight Normal       guibg=#0c1014
highlight LineNr       guifg=#6b6b47
highlight Comment      guifg=#527077
highlight Directory    guifg=#36A3D9
highlight Search       guifg=wheat    guibg=#6e2c71
highlight CursorLine   guibg=#070070
highlight CursorColumn guibg=#070070
highlight ColorColumn  guibg=#260030

set cursorline
set cursorcolumn

" ============================================================
" Key mappings
" ============================================================

" ; acts as : (faster command entry); ;; for original find-char ;
noremap ; :
noremap ;; ;

" Split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Split resize
noremap - <C-w>-
noremap + <C-w>+
noremap <C-n> <C-w><
noremap <C-m> <C-w>>

" Zoom current split to max; <C-w>= to equalize
noremap <C-w>z <c-w>_ \| <c-w>\|
" Remap <C-w>o (close others) to zoom to prevent accidental split closing
map <C-w>o <C-w>z

" FZF
nnoremap <C-p> :Files<Cr>
nnoremap <C-f> :GGrep<Cr>
nnoremap <leader>f :Rg<Cr>

" Move visual selection up/down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" ============================================================
" Command abbreviations
" ============================================================

cnoreabbrev E   Explore
cnoreabbrev E!  Explore!
cnoreabbrev H   Hexplore
cnoreabbrev H!  Hexplore!
cnoreabbrev V   Vexplore
cnoreabbrev V!  Vexplore!

cnoreabbrev Gb   Git<space>blame
cnoreabbrev Gbl  Git<space>blame
cnoreabbrev Gbla Git<space>blame

cnoreabbrev FormatJson %!python3 -m json.tool

" ============================================================
" Filetype detection
" ============================================================

au BufNewFile,BufRead *.ru,*.god,*.rabl,*.arb            set ft=ruby
au BufNewFile,BufRead *.hcl                              set ft=terraform
au BufNewFile,BufRead nginx*.conf,/etc/nginx/conf/*.conf set ft=nginx
au BufNewFile,BufRead *.tsx                              set filetype=typescriptreact
au BufNewFile,BufRead .env.*                             set ft=sh
au BufNewFile,BufRead .yml.*                             set ft=yaml
