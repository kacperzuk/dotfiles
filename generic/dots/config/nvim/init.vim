" plugins
" requires https://github.com/junegunn/vim-plug

if !empty(globpath(&rtp, 'autoload/plug.vim'))
    call plug#begin()
    Plug('editorconfig/editorconfig-vim')
    Plug('pangloss/vim-javascript')
    Plug('easymotion/vim-easymotion')
    Plug('nathanaelkane/vim-indent-guides')
    Plug('vim-airline/vim-airline')
    Plug('vim-airline/vim-airline-themes')
    Plug('airblade/vim-gitgutter')
    Plug('freeo/vim-kalisi')
    Plug('frankier/neovim-colors-solarized-truecolor-only')
    call plug#end()
    let g:airline_theme='kalisi'
endif

syntax on
filetype plugin indent on

autocmd FileType text setlocal textwidth=78
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

autocmd BufNewFile,BufRead *.pde setlocal ft=arduino
autocmd BufNewFile,BufRead *.ino setlocal ft=arduino
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set relativenumber
set number
set ignorecase
set smartcase
set hidden
set wildmenu
set cmdheight=2
set nobackup
set nowritebackup
set backspace=indent,eol,start
set history=50
set ruler
set showcmd
set incsearch
set mouse=a
set hlsearch
set clipboard+=unnamed
set updatetime=250

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
silent! colorscheme solarized