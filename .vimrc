source $VIMRUNTIME/vimrc_example.vim

set encoding=utf-8

set nocompatible
filetype plugin on
set laststatus=2
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set backspace=2
set autoindent
set smartindent

if has("gui_running")
    " Remove menu, tool and scrollbars
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    if has("gui_gtk2")
        set guifont=Inconsolata\ 13
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h13:cANSI
    endif
endif

set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on

:set number relativenumber

let g:NERDSpaceDelims=1
let g:NERDTrimTrailingWhitespace=1

let delimitMate_expand_cr=1

" colorscheme darkspectrum
colorscheme gruvbox
set background=dark

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

set diffexpr=MyDiff(test)
function! MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg1 = substitute(arg1, '!', '\!', 'g')
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg2 = substitute(arg2, '!', '\!', 'g')
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let arg3 = substitute(arg3, '!', '\!', 'g')
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            if empty(&shellxquote)
                let l:shxq_sav = ''
                set shellxquote&
            endif
            let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    let cmd = substitute(cmd, '!', '\!', 'g')
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
    endif
endfunction

