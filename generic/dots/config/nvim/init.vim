" plugins
" requires https://github.com/junegunn/vim-plug

if !empty(globpath(&rtp, 'autoload/plug.vim'))
    call plug#begin()
    Plug('editorconfig/editorconfig-vim')
    Plug('pangloss/vim-javascript')
    Plug('nathanaelkane/vim-indent-guides')
    Plug('vim-airline/vim-airline')
    Plug('vim-airline/vim-airline-themes')
    Plug('noah/fu')
    Plug('airblade/vim-gitgutter')
    Plug('tpope/vim-fugitive')
    Plug('KabbAmine/zeavim.vim')
    Plug('terryma/vim-multiple-cursors')
    Plug('elixir-lang/vim-elixir')
    Plug('lervag/vimtex')
    Plug('w0rp/ale')
    "Plug('Valloric/YouCompleteMe')
    call plug#end()
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
set tabstop=2
set softtabstop=2
set shiftwidth=2
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

set background=dark
silent! colorscheme fu
silent! let g:airline_powerline_fonts = 1
silent! let g:indent_guides_auto_colors = 0
silent! let g:indent_guides_guide_size = 1
silent! let g:indent_guides_start_level = 2
silent! let g:indent_guides_enable_on_vim_startup = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

nnoremap <Leader>zz :let &scrolloff=9999-&scrolloff<CR>
let b:ale_linters = {
\  'javascript': ['standard'],
\  'c': ['clangd']
\}

let b:ale_fixers = {
\   'python': [
\     'add_blank_lines_for_python_control_statements',
\     'isort',
\     'remove_trailing_lines',
\     'trim_whitespace',
\     'yapf'
\   ],
\   'javascript': [
\     'standard',
\   ],
\   'c': [
\     'remove_trailing_lines',
\     'trim_whitespace',
\     'clang-format'
\   ],
\   'cuda': [
\     'remove_trailing_lines',
\     'trim_whitespace',
\     'clang-format'
\   ]
\ }
let g:ale_c_parse_compile_commands = 1
let g:ale_fix_on_save = 1
let g:ale_c_build_dir_names = ['bin', 'build', 'builddir']
let g:ale_cuda_clangd_options = '--cuda-path /opt/cuda'
