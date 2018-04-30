" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set modeline
set modelines=5


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup        " do not keep a backup file, use versions instead
endif
set history=500        " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch        " do incremental searching
set gdefault        " regex /g by default
set number
set relativenumber
set scrolloff=3
set wildmode=list:longest
set title
set tw=79
set laststatus=2
set t_Co=16

set formatoptions+=1n

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

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let undodir="$HOME/.vim/undo"
    set undofile
endif

filetype off
set rtp+=~/.vim/bundle/Vundle.vim


call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"
" Colorschemes
"
Plugin 'altercation/vim-colors-solarized'
Plugin 'nanotech/jellybeans.vim'
Plugin 'wgibbs/vim-irblack'
Plugin 'tpope/vim-vividchalk'
Plugin 'sickill/vim-monokai'
Plugin 'toupeira/vim-desertink'
Plugin 'molokai'


"
" Searching
"
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'wincent/command-t'

"
" General Editing
"
"
Plugin 'mattn/emmet-vim'
Plugin 'terryma/vim-expand-region'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ReplaceWithRegister'
Plugin 'godlygeek/tabular'
Plugin 'chrisbra/unicode.vim'
Plugin 'sjl/gundo.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'vim-scripts/Mark--Karkat'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-surround'

"
" Languages
"
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-scripts/VimClojure'
Plugin 'vim-ruby/vim-ruby'
Plugin 'elzr/vim-json'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'fatih/vim-go'
Plugin 'digitaltoad/vim-jade'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'fatih/vim-hclfmt'
Plugin 'jasontbradshaw/pigeon.vim'

"
" Development Tool Integration
"
"
Plugin 'rizzatti/dash.vim'
Plugin 'mattn/gist-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/Conque-GDB'
"
" Other
"
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'romainl/vim-qf'


call vundle#end()

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

  set autoindent        " always set autoindenting on
  echoerr "No autocmd support. you may have errors"

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
set tabstop=4
set shiftwidth=4
set expandtab
set wildignore=*.o,*.obj,*.bak,*.exe
"set backup

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

let mapleader = "\<Space>"
let g:ConqueGdb_Leader = "\\"
let g:go_fmt_command = "goimports"
let g:vim_markdown_new_list_item_indent = 0
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" markdown
let g:vim_markdown_json_frontmatter = 1
set conceallevel=2

" Copy & paste to system clipboard with <Space>p and <Space>y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" region expanding
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Stop that stupid window from popping up
map q: :q

" window splitting
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set splitbelow
set splitright

" j/k work with wrapped lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" better find
nnoremap <leader>f /<C-r><C-w><CR>
" git grep
nnoremap <leader>g :!git grep <C-r><C-w><CR>
nnoremap <leader>G :!git grep -i <C-r><C-w><CR>

" go to end of line and add closing paren
nnoremap <leader>) $a)<ESC>

" edit in current directory
cnoremap <C-e> <C-R>=expand("%:p:h") . "/" <CR>

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

" replace word with yank buffer
nnoremap s "_dwP
nnoremap S "_dWP

" Taglist plugin config
let Tlist_Use_Right_Window = 1
let Tlist_Inc_Winwidth = 0
let Tlist_WinWidth = 65
let Tlist_GainFocus_On_ToggleOpen= 1
" go language
let s:tlist_def_go_settings = 'go;g:enum;s:struct;u:union;t:type;' .
                           \ 'v:variable;f:function'

" utilisnips
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories=["vim-snippets/snippets", "UltiSnips"]
let g:UltiSnipsEditSplit="context"


if !has("gui_running")
    set t_Sf=^[[3%p1%dm
    set t_Sb=^[[4%p1%dm
else
    set guifont=Inconsolata:h12
    " window position
    winpos 0 23
    set lines=98
    set columns=312
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

if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

function DiffOriginal()
    exe "w !diff % -"
endfunction

function GitGrepTile(search)
    let files = split(system("git grep -l \"" . a:search . "\""))
    let l:fsize = len(files)
    if l:fsize > 10
        echom "refusing to split, too many files found: " . l:fsize
        return
    endif
    if v:shell_error > 0
        echom "no files found"
        return
    endif
    for f in files
        exe ":vsp " . f
    endfor
endfunction

let g:qf_loclist_window_bottom = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
" doesn't work: let g:syntastic_reuse_loc_lists = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['go', 'govet']
" Close syntastic window
nnoremap <leader>x :SyntasticReset<CR>

" pandoc
let g:pandoc#modules#disabled = ["folding", "chdir"]
let g:pandoc#formatting#textwidth = 79
let g:pandoc#formatting#equalprg = "pandoc -t markdown --columns=79"
let g:pandoc#formatting#extra_equalprg = ""


setlocal spell spelllang=en_us
colorscheme solarized
highlight SpellBad     ctermfg=darkred
