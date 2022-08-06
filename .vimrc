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
Plug 'itchyny/vim-gitbranch'
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

" When started with plain Vim, the plugin is not registered
" and PlugClean will try to remove it
if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
endif

call plug#end()

" Searching options
set hlsearch incsearch
set ignorecase smartcase

" Saner split
set splitright
set splitbelow

" General user interface
set number
set relativenumber
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

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,WinLeave   * if &nu                  | set nornu | endif
:augroup END

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
" imap jk <Esc>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>d :bprevious<CR>:bd#<CR>
map <UP> gk
map <DOWN> gj
nmap <silent> <tab> :bn<CR> :echo @%<CR>
nmap <silent> <s-tab> :bp<CR> :echo @%<CR>
nnoremap <silent> <leader><leader> <C-^>
nnoremap ; :
nnoremap : ;

" Commands from FZF
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
noremap <C-p> :Files<CR>

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
" Clear highlighted search
nnoremap <silent> <leader>/ :nohlsearch<CR>
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

" Lightline configuration
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'gitbranch_path'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Language server stuff
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>ca <Plug>(coc-codeaction-cursor)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
