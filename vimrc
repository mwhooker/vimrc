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

let g:ale_completion_enabled = 0
let g:ale_go_langserver_executable = 'gopls'
let g:ale_linters = {
	\ 'go': ['gopls'],
	\}

set runtimepath+=~/.vim/bundle/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/bundle/dein')
    call dein#begin('~/.vim/bundle/dein')

    call dein#add('~/.vim/bundle/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    call dein#add('deoplete-plugins/deoplete-go', {'build': 'make'})

"
" Colorschemes
"
    call dein#add('altercation/solarized', {'rtp': 'vim-colors-solarized'})
    call dein#add('chriskempson/base16-vim')
    call dein#add('vim-scripts/molokai')
    call dein#add('nanotech/jellybeans.vim')
    call dein#add('sickill/vim-monokai')
    call dein#add('toupeira/vim-desertink')
    call dein#add('tpope/vim-vividchalk')
    call dein#add('wgibbs/vim-irblack')
    call dein#add('chriskempson/tomorrow-theme', {'rtp': 'vim/'})

"
" Searching
"
    call dein#add('mileszs/ack.vim')

"
" General Editing
"
"
    call dein#add('chrisbra/unicode.vim')
    call dein#add('dhruvasagar/vim-table-mode')
    call dein#add('godlygeek/tabular')
    call dein#add('honza/vim-snippets')
    call dein#add('kien/rainbow_parentheses.vim')
    call dein#add('kshenoy/vim-signature')
    call dein#add('mattn/emmet-vim')
    call dein#add('vim-scripts/ReplaceWithRegister')
    call dein#add('SirVer/ultisnips')
    call dein#add('sjl/gundo.vim')
    call dein#add('terryma/vim-expand-region')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-surround')
    call dein#add('vim-scripts/Mark--Karkat')
    call dein#add('vim-scripts/ZoomWin')
" Whitespace editing in case <leader><del> stops working
" call dein#add('ntpeters/vim-better-whitespace')
" call dein#add('bronson/vim-trailing-whitespace')

"
" Languages
"
    call dein#add('digitaltoad/vim-jade')
    call dein#add('elzr/vim-json')
    call dein#add('fatih/vim-go')
    call dein#add('fatih/vim-hclfmt')
    call dein#add('fatih/gomodifytags')
    call dein#add('mwhooker/pigeon.vim', {'rev': 'patch-1' })
    call dein#add('kchmck/vim-coffee-script')
    call dein#add('sudar/vim-arduino-syntax')
    call dein#add('vim-pandoc/vim-pandoc')
    call dein#add('vim-pandoc/vim-pandoc-syntax')
    call dein#add('vim-ruby/vim-ruby')
    call dein#add('vim-scripts/VimClojure')
    call dein#add('w0rp/ale')
    call dein#add('hashivim/vim-terraform')

"
" Development Tool Integration
"
"
    call dein#add('rizzatti/dash.vim')
    call dein#add('mattn/webapi-vim')
    call dein#add('mattn/gist-vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-rhubarb')
" Conque is causing python warnings
" call dein#add('vim-scripts/Conque-GDB')
"
" Other
"
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('romainl/vim-qf')


    call dein#end()
    call dein#save_state()
endif


set rtp+=/usr/local/opt/fzf

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

" Golang
map <leader>i :GoInfo<CR>
let g:go_info_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_def_mode='gopls'
let g:go_fmt_command = "goimports"
let g:go_gocode_propose_source=0

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
let g:vim_markdown_new_list_item_indent = 0
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" markdown
let g:vim_markdown_json_frontmatter = 1
set conceallevel=2

" Copy & paste to system clipboard with <Space>p and <Space>y
vnoremap <Leader>d "+d
nnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

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

" replace word with yank buffer
nnoremap s "_dwP
nnoremap S "_dWP

nnoremap <leader>t :FZF<cr>

" utilisnips

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories=["vim-snippets/snippets", "UltiSnips"]
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<tab>"

call deoplete#custom#source('ultisnips', 'rank', 1000)
call deoplete#custom#option('auto_complete_delay', 100)
let g:deoplete#enable_at_startup = 1


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

" pandoc
let g:pandoc#modules#disabled = ["folding", "chdir"]
let g:pandoc#formatting#textwidth = 79
let g:pandoc#formatting#equalprg = "pandoc -t markdown --columns=79"
let g:pandoc#formatting#extra_equalprg = ""

setlocal spell spelllang=en_us
colorscheme solarized
highlight SpellBad     ctermfg=darkred
