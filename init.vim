call plug#begin('~/.vim/plugged')

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

"Jsonnet
Plug 'google/vim-jsonnet'
"Auto complete
Plug 'Valloric/YouCompleteMe'

"Terraform
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'

"Dash documentation 
Plug 'rizzatti/dash.vim'

"Code formating
Plug 'google/vim-codefmt'

"Typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

"Bazel
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
Plug 'google/vim-glaive'

"Prettier"
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

"Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Time Tracking
Plug 'wakatime/vim-wakatime'

"Theme
Plug 'itchyny/lightline.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}

"File search
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

"Git
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Shortcuts
Plug 'tpope/vim-surround'

"Html
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque'

call plug#end()

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
"
" ###################
" ### Plugin conf ###
" ###################

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
colorscheme onehalfdark
let g:lightline.colorscheme='sublimetext'

" Prettier
let g:prettier#autoformat = 0
let g:prettier#quickfix_auto_focus = 0

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json,javascript,typescript AutoFormatBuffer prettier
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

"
" Ultisnip config
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" Ctrl P
let g:ctrlp_map = '<space><space>'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|build\|dist\|dist\|build\'

let g:cssColorVimDoNotMessMyUpdatetime = 1

" #####################
" ### Personal conf ###
" #####################

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

"Terraform config
let g:terraform_fmt_on_save=1

scriptencoding utf-8
syntax on
syntax enable
filetype plugin indent on

set nocompatible
set background=light

" let g:solarized_contrast ='high'
set fillchars+=stl:\ ,stlnc:\
set mouse=a
set noshowmode
set number
set relativenumber

set encoding=utf-8
set guifont=Inconsolata\ for\ Powerline:h15
set t_Co=256
set termencoding=utf-8

set backspace=2		        " allow backspacing over everything in insert mode
set hlsearch " highlight searches
set ruler		        " show the cursor position all the time
set visualbell " no beep

" Tabulation management
set autoindent
set cindent
set cinoptions=(0,u0,U0
set expandtab
set smartindent
set softtabstop=4
set tabstop=4

" Spellchecking
if has('spell') " if vim support spell checking
    " Download dictionaries automatically
    if !filewritable($HOME.'/.vim/spell')
        call mkdir($HOME.'/.vim/spell','p')
    endif
    set spellsuggest=10 " z= will show suggestions (10 at most)
    " spell checking for text, HTML, LaTeX, markdown and literate Haskell
    autocmd BufEnter *.txt,*.tex,*.html,*.md,*.ymd,*.lhs setlocal spell
    autocmd BufEnter *.txt,*.tex,*.html,*.md,*.ymd,*.lhs setlocal spelllang=fr,en
    " better error highlighting with solarized
    highlight clear SpellBad
    highlight SpellBad term=standout ctermfg=2 term=underline cterm=underline
    highlight clear SpellCap
    highlight SpellCap term=underline cterm=underline
    highlight clear SpellRare
    highlight SpellRare term=underline cterm=underline
    highlight clear SpellLocal
    highlight SpellLocal term=underline cterm=underline
endif

" -- vim-pandoc folding
let g:pandoc#modules#disabled = ['folding']
let g:vim_bootstrap_langs = 'javascript,python'
let g:vim_bootstrap_editor = 'vim'

" ----------------------------
"       File Management
" ----------------------------

"" Encoding
set binary
set bomb
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set expandtab
set shiftwidth=4
set softtabstop=0
set tabstop=4

"" Map leader to ,
let g:mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set ignorecase
set incsearch
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

if exists('*fugitive#statusline')
    set statusline+=%{fugitive#statusline()}
endif


"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let g:Grep_Default_Options = '-IR'
let g:Grep_Skip_Files = '*.log *.db'
let g:Grep_Skip_Dirs = '.git node_modules'

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
    function s:setupWrapping()
        set wrap
        set wrapmargin=2
        set textwidth=79
    endfunction
endif

"*****************************************************************************
"" Mappings
"*****************************************************************************

" ----------------------------
"       File Management
" ----------------------------
" search a file in the filetree

inoremap jk <Esc>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
    " pbcopy for OSX copy/paste
    vmap <C-x> :!pbcopy<CR>
    vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
