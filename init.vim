call plug#begin('~/.vim/plugged')

"Golang support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

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

"
" ###################
" ### Plugin conf ###
" ###################

syntax enable
set background=light
colorscheme solarized
let g:solarized_termcolors=256
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

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
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction

if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories = ['/Users/ayinla/.vim/UltiSnips', 'UltiSnips']

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" Ctrl P
let g:ctrlp_map = '<space><space>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|dmg)$',
  \ }
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:cssColorVimDoNotMessMyUpdatetime = 1

" #####################
" ### Personal conf ###
" #####################

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

"Terraform config
let g:terraform_fmt_on_save=1

set nocompatible
filetype plugin indent on
scriptencoding utf-8
syntax on

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
set shiftwidth=4

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
