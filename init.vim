:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set clipboard=unnamedplus
:set clipboard+=unnamedplus
:set ttyfast "Speed up scrolling in vim
:set backupdir=~/.cache/vim "Directory to store backup files
:set cursorline

let mapleader = " "


syntax enable

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/tpope/vim-fugitive' " Fugitive is the premier Vim plugin for Git
Plug 'Civitasv/cmake-tools.nvim' " workflow for CMake-based projects in Neovim
Plug 'https://github.com/nvim-lua/plenary.nvim' " Plenary Library
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ThePrimeagen/harpoon'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo', 

set encoding=UTF-8

call plug#end()

nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <C-r> :FZF<CR>

nmap <F8> :TagbarToggle<CR>

:set completeopt-=preview " For No Previews

:colorscheme jellybeans

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE
" :CocInstall coc-rust-analyzer

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = '◀️'
let g:airline_left_alt_sep = '⚫'
let g:airline_right_sep = '➤'
let g:airline_right_alt_sep = '⦿'
let g:airline_symbols.branch = '🌱'
let g:airline_symbols.readonly = '🔒'
let g:airline_symbols.linenr = '#'

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
" Harpoon Konfiguration

lua vim.api.nvim_set_keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
lua vim.api.nvim_set_keymap('n', '<leader>r', ':lua require("harpoon.mark").rm_file()<CR>', { noremap = true, silent = true })
lua vim.api.nvim_set_keymap('n', '<leader>m', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })
" navigates to next mark
lua vim.api.nvim_set_keymap('n', '<leader>n', ':lua require("harpoon.ui").nav_next()<CR>', { noremap = true, silent = true })     
" navigates to previous mark
lua vim.api.nvim_set_keymap('n', '<leader>b', ':lua require("harpoon.ui").nav_prev()<CR>', { noremap = true, silent = true })     
