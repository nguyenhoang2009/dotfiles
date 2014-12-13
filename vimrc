"-----------------------------------------------
" file:     ~/.vimrc
" author:   jason ryan - http://jasonwryan.com/
" vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=vim
"-----------------------------------------------

syntax on
filetype plugin on
filetype indent on

colorscheme monokai

set t_Co=256                            " ALL the colours!
set ttyfast                             " don't lag…
set cursorline                          " track position
set nocompatible                        " leave the old ways behind…
set nowrap                              " don't wrap lines
set nobackup                            " disable backup files (filename~)
set splitbelow                          " place new files below the current
set showmatch                           " matching brackets & the like
set clipboard+=unnamed                  " yank and copy to X clipboard
set encoding=utf-8                      " UTF-8 encoding for all new files
set backspace=2                         " full backspacing capabilities (indent,eol,start)
set scrolloff=10                        " keep 10 lines of context
set number                              " show line numbers
set ww=b,s,h,l,<,>,[,]                  " whichwrap -- left/right keys can traverse up/down
set linebreak                           " attempt to wrap lines cleanly
set wildmenu                            " enhanced tab-completion shows all matching cmds in a popup menu
set wildmode=list:longest,full          " full completion options
set spelllang=en_gb                     " real English spelling
set dictionary+=/usr/share/dict/words   " use standard dictionary
set spellfile=$HOME/Sync/vim/spell/en.utf-8.add

let g:is_posix=1                        " POSIX shell scripts
let g:loaded_matchparen=1               " disable parenthesis hlight plugin
let g:is_bash=1                         " bash syntax the default for hlighting
let g:vimsyn_noerror=1                  " hack for correct syntax hlighting

" printer
set pdev=L7-HP4250

" tabs and indenting
set tabstop=4                           " tabs appear as n number of columns
set shiftwidth=4                        " n cols for auto-indenting
set expandtab                           " spaces instead of tabs
set autoindent                          " auto indents next new line

" searching
set hlsearch                            " highlight all search results
set incsearch                           " increment search
set ignorecase                          " case-insensitive search
set smartcase                           " uppercase causes case-sensitive search

" listchars
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ 

" status bar info and appearance
set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ 
set laststatus=2
set cmdheight=1

" keep cursor centered
:nnoremap j jzz
:nnoremap k kzz

" space bar un-highlights search
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

" Allows writing to files with root priviledges
cmap w!! w !sudo tee % > /dev/null

" command to pull image URL
:command -nargs=1 Url :read !vimgurl <args>

" disable syntax highlighting in vimdiff...
if &diff | syntax off | endif

" {{{ autocomds
if has("autocmd")
    " always jump to the last cursor position
    autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$") | exe "normal g`\""|endif
    " settings for specific filetypes
    autocmd BufRead *.txt set tw=79
    autocmd BufRead /tmp/vimprobable* set tw=79 spell
    autocmd BufRead *.tex,*.markdown,*.md,*.txt set spell
    autocmd BufRead,BufNewFile ~/.mutt/temp/mutt-* set ft=mail wrap lbr nolist spell tw=0 wm=0
    autocmd BufRead *.markdown,*tex call DistractFree#DistractFreeToggle() | wincmd w
endif
" }}}

" {{{ DistractFree
let g:distractfree_width = '75%'
let g:distractfree_colorscheme = 'mirowriter'
let g:distractfree_keep_options = 'textwidth=79'
" }}}

" {{{ Map keys to toggle functions
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction

command! -nargs=+ MapToggle call MapToggle(<f-args>)
" Keys & functions
MapToggle <F4> number
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch
MapToggle <F8> wrap
" }}}

" {{{ toggle colored right border after 80 chars
set colorcolumn=0
let s:color_column_old = 80

function! s:ToggleColorColumn()
    if s:color_column_old == 0
        let s:color_column_old = &colorcolumn
        windo let &colorcolumn = 0
    else
        windo let &colorcolumn=s:color_column_old
        let s:color_column_old = 0
    endif
endfunction

nnoremap <bar> :call <SID>ToggleColorColumn()<cr>
" }}}
