set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set backspace=indent,eol,start
set mouse=a
set clipboard=unnamed

set number
set ruler
set showcmd
set cursorline
set showmatch

set incsearch
set hlsearch

set nobackup
set nowb
set noswapfile

set ts=4
set autoindent
set expandtab
set shiftwidth=4

syntax enable
let python_highlight_all = 1
set background=dark
colorscheme molokai_dark

au BufRead,BufNewfile *.yara set filetype=yara
au BufRead,BufNewfile *.yar set filetype=yara
