" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set modelines=0

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
endif
set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set gdefault        " regex /g by default
set number
set scrolloff=3
set wildmode=list:longest
set title

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gqip

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype off

call pathogen#runtime_append_all_bundles()

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd     " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
set wildignore=*.o,*.obj,*.bak,*.exe

set statusline="set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P"
set tags=~/.vim/tags/tv_tags,./tags
map <F6> :b#<CR>

" run file with PHP CLI (CTRL-M)
"autocmd FileType php nnoremap <C-M> :w!<CR>:!/usr/bin/php %<CR>

" " PHP parser check (CTRL-L)
autocmd FileType php nnoremap <C-L> :!/usr/bin/php -l %<CR>

"inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php nnoremap <C-P> :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <C-P> :call PhpDocRange()<CR> 

"sessions
au VimLeave * exe 'if exists("g:cmd") && g:cmd == "gvims" | if strlen(v:this_session) | exe "wviminfo! " . v:this_session . ".viminfo" | else | exe "wviminfo! " . "~/.vim/session/" . g:myfilename . ".session.viminfo" | endif | endif '
au VimLeave * exe 'if exists("g:cmd") && g:cmd == "gvims" | if strlen(v:this_session) | exe "mksession! " . v:this_session | else | exe "mksession! " . "~/.vim/session/" . g:myfilename . ".session" | endif | endif'

"cursor color
if &term =~ "xterm\\|rxvt"
    :silent !echo -ne "\033]12;red\007"
    let &t_SI = "\033]12;orange\007"
    let &t_EI = "\033]12;red\007"
    autocmd VimLeave * :!echo -ne "\033]12;red\007"
endif

" window splitting
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" tab navigation. not case sensitive, breaks redraw
" nnoremap <C-H> :tabPrevious<CR>
" nnoremap <C-L> :tabNext<cr>

" scratch
nnoremap <leader><tab> :Sscratch<CR>

" escape to normal mode
inoremap jj <ESC>

" make ; same as :
nnoremap ; :

" clear search highlighting
nnoremap <leader><space> :noh<cr>

" use tab to go to matching bracket pairs
nnoremap <tab> %
vnoremap <tab> %

nnoremap <leader><BS> mz:%s/\s\+$//<CR>`z

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Taglist plugin mapping
noremap <silent> <Leader>T :TlistToggle<CR>

" Taglist plugin config
let Tlist_Use_Right_Window = 1
let Tlist_Inc_Winwidth = 0
let Tlist_WinWidth = 45
let Tlist_GainFocus_On_ToggleOpen= 1
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

if !has("gui_running")
	set t_Co=8
	set t_Sf=^[[3%p1%dm
	set t_Sb=^[[4%p1%dm
    colorscheme desertink
else
    set guifont=Inconsolata:h12
    " window position
    winpos 0 23
    set lines=98
    set columns=312
    colorscheme solarized
endif

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif
