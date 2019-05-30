call plug#begin('~/.vim/plugged')

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

"Jsonnet
Plug 'google/vim-jsonnet'

"Terraform
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'

"Dash documentation 
Plug 'rizzatti/dash.vim'

"Jsonnet
Plug 'google/vim-jsonnet'

"Bazel
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'

" REQUIRED: Add a syntax file. YATS is the best
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

Plug 'jason0x43/vim-js-indent'

" For async completion
Plug 'Shougo/deoplete.nvim'

" For Denite features
Plug 'Shougo/denite.nvim' , {'do':'UpdateRemotePlugins'}

Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" Snippets
" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" neosnippet
Plug 'autozimu/LanguageClient-neovim', {
           \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-jedi'

" For func argument completion
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'

" Time Tracking
Plug 'wakatime/vim-wakatime'

" Theme
Plug 'itchyny/lightline.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}

" File search
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" Distraction Free Writting
Plug 'junegunn/goyo.vim'

" Linting and Fixing
Plug 'w0rp/ale'

"Git
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Html
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-surround'

"typesript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

call plug#end()

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
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" Enable deoplete at startup
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
let g:deoplete#enable_at_startup = 1
call deoplete#initialize()

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

" Required for operations modifying multiple buffers like rename.
let g:deoplete#enable_at_startup = 1
let g:neosnippet#enable_completed_snippet = 1

"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
            \ 'jsx',
            \ 'javascript.jsx',
            \ 'vue',
            \ '...'
            \ ]

let g:LanguageClient_serverCommands = {
            \ 'javascript': ['javascript-typescript-stdio'],
            \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
            \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" Ctrl P
let g:ctrlp_map = '<space><space>'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|build\|dist\|dist\|build\'

let g:cssColorVimDoNotMessMyUpdatetime = 1


" Asynchronous Lint Engine (ALE)
" Limit linters used for JavaScript.

let g:ale_linters = {
            \'html': ['HTMLHint', 'write-good', 'alex', 'tidy'],
            \'css': ['prettier'],
            \'scss': ['prettier'],
            \'json': ['prettier'],
            \'python': ['flake8'],
            \'graphql': ['prettier'],
            \'javascript': ['eslint'],
            \'typescript': ['tsserver'],
            \'yaml': ['yamllint'],
            \'vim': ['vint'],
            \'markdown': ['mdl'],
            \'docker': ['hadolint'],
            \'terraform': ['fmt'],
            \}

let g:ale_fixers = {
            \'css': ['prettier'],
            \'scss': ['prettier'],
            \'graphql': ['prettier'],
            \'javascript': ['prettier'],
            \'typscript': ['tsserver'],
            \'json': ['prettier'],
            \}

highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)

"let g:ale_sign_error = '>>' " could use emoji
"let g:ale_sign_warning = '--' " could use emoji
"let g:ale_statusline_format = ['X %d', '? %d', '']
"let g:ale_sign_column_always = 1
"let g:ale_completion_enabled = 1
"
"let g:ale_fix_on_save = 1
"let g:ale_javascript_prettier_options = '--write'
"
"" %linter% is the name of the linter that provided the message
"" %s is the error or warning message
"
"let g:ale_echo_msg_format = '%linter% says %s'
"
"" Map keys to navigate between lines with errors and warnings.
"nnoremap <leader>an :ALENextWrap<cr>
"nnoremap <leader>ap :ALEPreviousWrap<cr>

" #####################
" ### Personal conf ###
" #####################

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

"Terraform config
set nocompatible
syntax on
let g:terraform_fmt_on_save=1

"Terraform config end

filetype plugin indent on

au BufNewFile,BufRead *.ejs set filetype=html

syntax enable
set background=light

" let g:solarized_contrast ='high'
set noshowmode
set number
set relativenumber
set fillchars+=stl:\ ,stlnc:\
set mouse=a

set guifont=Inconsolata\ for\ Powerline:h15
set encoding=utf-8
set t_Co=256
set termencoding=utf-8

scriptencoding utf-8

set backspace=2		        " allow backspacing over everything in insert mode
set ruler		        " show the cursor position all the time

set hlsearch " highlight searches

set visualbell " no beep

" Tabulation management
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set cindent
set cinoptions=(0,u0,U0

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
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set softtabstop=0
set shiftwidth=4

"" Map leader to ,
let g:mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set incsearch
set ignorecase
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
