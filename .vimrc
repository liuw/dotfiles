set nocompatible
set nobackup
" let mapleader = ','
let mapleader = "\<Space>"

" Plugins
"  See https://github.com/junegunn/vim-plug
"  Need to have vim-plug installed
call plug#begin('~/.vim/plugged')

" UI improvement
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

" Language server protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language support
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'

call plug#end()

" Searching options
set hlsearch incsearch
set ignorecase smartcase

" Saner split
set splitright
set splitbelow

" General user interface
set number
set ruler
set showcmd
set wildmenu wildmode=list:longest
set showmatch
set linebreak
set laststatus=2
set guioptions-=T
set ttyfast
set mouse=a
syntax on
colorscheme desert

" Highlight boundary. Use 80 by default but can be overridden.
set colorcolumn=80

" Inspect first and last 10 lines for Vim modeline
" Help modeline for more information
set modelines=10

" Enable Vim to edit multiple files
set hidden

" Bigger command history
set history=1000

" Text editing, can be override by modeline
set textwidth=0
set nowrap
set autoread autowrite
set clipboard+=unnamed " yanks go to clipboard

" Customized mappings
imap jk <Esc>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>d :bprevious<CR>:bd#<CR>
map <UP> gk
map <DOWN> gj
nmap <silent> <tab> :bn<CR> :echo @%<CR>
nmap <silent> <s-tab> :bp<CR> :echo @%<CR>
nnoremap <silent> <leader><leader> <C-^>
nnoremap ; :
nnoremap <F5> :buffers<CR>:buffer<Space>
" FZF
map <C-p> :Files<CR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
" Clear highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>
" Shortcut to edit file in the same directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" Show invisibles
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
" set list

" Auto change directory to current buffer
" set autochdir
" autocmd BufEnter * silent! lcd %:p:h " make sure plugins work

" Commands and auto commands
"
command! W exec 'w !sudo tee % > /dev/null' | e!
autocmd BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown spell
autocmd BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit tw=72 wrap spell
autocmd BufRead,BufNewFile {*.py} set et sts=4 sw=4 ts=4

" Jump back to last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Rust settings
let g:rustfmt_autosave = 1
autocmd FileType rust set colorcolumn=100 shiftwidth=4 softtabstop=4 tabstop=4 et

" Read any local settings
if filereadable($HOME . "/.vimrc.local")
    source $HOME/.vimrc.local
endif

" For a list of highlight colors, use :hi
hi Pmenu  ctermfg=0 ctermbg=8 guibg=Magenta
