" vi: fdm=marker

" Initialization: {{{
set nocompatible
set encoding=utf-8
set fenc=utf-8
set termencoding=utf-8
set nu rnu
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set hlsearch
set incsearch
set showcmd
set smarttab
set backspace=indent,eol,start
set autoindent
set smartindent
set scrolloff=3
syntax on

" nu on insert, rnu on norm/vis
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

if has('win32')
  set rtp+=~/.vim
endif

set nocompatible
filetype off

noremap <silent> <C-t> :tabnew<CR>
noremap <silent> <A-1> :tabmove -<CR>
noremap <silent> <A-3> :tabmove +<CR>
noremap <A-q> gT
noremap <A-e> gt
" }}}

" Plugins: {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'w0rp/ale'
Plugin 'cespare/vim-toml'
Plugin 'leafgarland/typescript-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'itchyny/lightline.vim'
Plugin 'itchyny/vim-gitbranch'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'alvan/vim-closetag'

call vundle#end()
filetype plugin indent on
" }}}

"Colors {{{
colorscheme ayu
set background=dark
" }}}

" {{{ Statusline
  set laststatus=2
  let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'fileanddir', 'modified' ] ]
        \ },
        \ 'inactive': {
        \   'left': [ ['readonly', 'fileanddir', 'modified'] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'gitbranch#name',
        \   'fileanddir': 'LightlineDirFile'
        \ },
        \ 'component': {
        \   'dirname': 'hello%:h:t'
        \ },
        \ 'colorscheme': 'ayu_dark'
      \ }

  function! LightlineDirFile()
    let dirname = expand('%:p:h:t')
    let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
    return dirname . '/' . filename
  endfunction
" }}}

"Plugin Config {{{
 " CtrlP: {{{
 "let g:ctrlp_user_command = [
    "\ '.git', 'cd %s && git ls-files . -co --exclude-standard',
    "\ 'find %s -type f'
    "\ ]
 let g:ctrlp_open_new_file = 'r' 
 let g:ctrlp_custom_ignore = {
     \ 'file': '\v\.(exe|so|dll|o|d)$',
     \ 'dir':  '\.git$\|hg$\|svn$\|node_modules$\|dist$\|build$'
     \}
 " }}}
 
 " YCM: {{{
   nnoremap <leader>jd :tab YcmCompleter GoTo<CR>
   let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
   let g:ycm_goto_buffer_command = 'split-or-existing-window'
   if !exists("g:ycm_semantic_triggers")
     let g:ycm_semantic_triggers = {}
   endif
   let g:ycm_semantic_triggers['typescript'] = ['re!\w|\.|\:']
 " }}}

 " delimitmate: {{{
   let delimitMate_expand_cr = 1
 " }}}
 
 " Nerdtree: {{{
   map <C-n> :NERDTreeToggle<CR>
 " }}}

 " {{{ Ale 

  " {{{ typescript
    " let b:ale_linters = ['tslint']
  " }}}

 " }}}

" }}}
