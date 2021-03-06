"vim config by @xluffy
" Leader
let mapleader = " "
let g:dracula_italic = 0

syntax on
filetype plugin on
filetype indent on
set background=dark

colorscheme dracula
set termguicolors

" This is only necessary if you use "set termguicolors".
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" General Settings "
set nocompatible
set backspace=indent,eol,start
set ruler
set nobackup
set ffs=unix
set encoding=utf-8
set fileencoding=utf-8
set scrolloff=10
set backspace=2
set laststatus=2
set t_Co=256
set showcmd
set autowrite
set autoread
set showtabline=2

" tabs and indenting
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=1
set number relativenumber

" system clipboard
set clipboard=unnamed

set undodir=~/.vim/undodir
set undofile

" Buffer
set hidden

" Make these commonly mistyped commands still work
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

" Use :C to clear hlsearch
command! C nohlsearch

" Force write readonly files using sudo
command! WS w !sudo tee %
nnoremap ; :

" vim-plug plugin-manager
call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdTree'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'Yggdroot/indentLine'
  Plug 'jhawthorn/fzy'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/limelight.vim'
  Plug 'nvie/vim-flake8'
  Plug 'w0rp/ale'
  Plug 'hashivim/vim-terraform'
  Plug 'juliosueiras/vim-terraform-completion'
  Plug 'pearofducks/ansible-vim'
  Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
  " Align terraform code
  Plug 'godlygeek/tabular'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-commentary'
  Plug 'brooth/far.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'vim-ruby/vim-ruby'
  Plug 'dhruvasagar/vim-zoom'
  Plug 'mbbill/undotree'
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'ConradIrwin/vim-bracketed-paste'
  Plug 'jgdavey/tslime.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'wakatime/vim-wakatime'
  Plug 'arcticicestudio/nord-vim'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'brooth/far.vim'
  Plug 'tomtom/tcomment_vim'
  Plug 'majutsushi/tagbar'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'mitsuhiko/vim-jinja'
  Plug 'mhartington/oceanic-next'
  Plug 'honza/vim-snippets'
  Plug 'SirVer/ultisnips'
  Plug 't9md/vim-choosewin'
  Plug 'airblade/vim-rooter'
call plug#end()

nmap <leader>n :NERDTreeToggle<CR>

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '⚠ %dW ⤫%dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'alestatus'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'alestatus': 'LinterStatus'
      \ },
      \ }

let g:airline#extensions#ale#enabled = 1

let g:ale_linters = {
      \ 'python': ['flake8', 'pylint'],
      \ 'javascript': ['eslint', 'prettier'],
      \ 'css': ['prettier'],
      \ 'ruby': ['rubocop'],
      \ 'terraform': ['tflint', 'terraform'],
      \ 'yaml': ['prettier'],
      \ 'haml': ['hamllint'],
      \ 'sass': ['sasslint'],
      \ 'lua': ['luacheck']
      \}

let g:ale_fixers = {
      \ 'ruby': ['rubocop'],
      \ 'javascript': ['eslint', 'prettier'],
      \ 'css': ['prettier'],
      \ 'haml': ['hamllint'],
      \ 'sass': ['sasslint'],
      \ 'lua': ['luacheck']
      \}
let g:ale_fix_on_save = 0

let g:ale_sign_error = 'ⓧ'
let g:ale_sign_warning = '⚠'
let g:ale_set_highlights = 0

let g:ale_yaml_yamllint_options='-d "{extends: relaxed, rules: {line-length: disable}}"'

let g:ale_ruby_ruby_executable = 'ruby'
let g:ale_ruby_rubocop_executable = 'bundle'

nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ap :ALEPreviousWrap<CR>

" map leader
:nnoremap <leader>d dd
:nnoremap <leader>g gg
:nnoremap <Leader>w :w<CR>

" Remove newbie crutches in Command Mode
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>
" Remove newbie crutches in Insert Mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
" Remove newbie crutches in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

let g:indentLine_enabled = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '┆'

map <leader><Enter> :w<CR>:!python3 %<CR>
map <F8> :w <CR> :!g++ % -o %< && ./%< <CR>
let python_highlight_all=1

" terraform
let g:terraform_align=1
let g:terraform_fold_sections=0
let g:terraform_remap_spacebar=1
let g:terraform_completion_keys = 1

autocmd BufEnter *.tf* colorscheme dracula

" Tab for cycling buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>

" Support Jenkinsfile syntax
au BufNewFile,BufRead Jenkinsfile set filetype=groovy

" python-mode
let g:pymode_python = 'python3'

" Better whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
" Autopair
let g:AutoPairsMultilineClose = 0

nnoremap <silent> <leader>f :FZF<CR>
nnoremap <silent> <leader>F :FZF ../<CR>

nmap <Leader>/ :Rg<Space>
nmap <Leader>l :Limelight!!<CR>

map <leader>bo :call Send_to_Tmux("rubocop ". expand('%:p') ."\n")<CR>
" autocmd VimEnter * Limelight
" Far
set lazyredraw
set regexpengine=1
" shortcut for far.vim find
nnoremap <silent> <Find-Shortcut>  :Farf<cr>
vnoremap <silent> <Find-Shortcut>  :Farf<cr>

" shortcut for far.vim replace
nnoremap <silent> <Replace-Shortcut>  :Farr<cr>
vnoremap <silent> <Replace-Shortcut>  :Farr<cr>

let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'

let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

nmap <Leader>t :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/opt/ctags/bin/ctags'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

nmap <Leader>- <Plug>(choosewin)
" if you want to use overlay feature
let g:choosewin_overlay_enable = 1
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
inoremap jk <ESC>
