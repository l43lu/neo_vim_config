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




" Lua-Konfiguration für cmake-tools.nvim
lua << EOF
local osys = require("cmake-tools.osys")
require("cmake-tools").setup {
  cmake_command = "cmake", -- this is used to specify cmake command path
  ctest_command = "ctest", -- this is used to specify ctest command path
  cmake_use_preset = true,
  cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
  cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
  cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
  cmake_build_directory = function()
    if osys.iswin32 then
      return "out\\${variant:buildType}"
    end
    return "out/${variant:buildType}"
  end,
  cmake_soft_link_compile_commands = true,
  cmake_compile_commands_from_lsp = false,
  cmake_kits_path = nil,
  cmake_variants_message = {
    short = { show = true },
    long = { show = true, max_length = 40 },
  },
  cmake_dap_configuration = {
    name = "cpp",
    type = "codelldb",
    request = "launch",
    stopOnEntry = false,
    runInTerminal = true,
    console = "integratedTerminal",
  },
  cmake_executor = {
    name = "quickfix",
    opts = {},
    default_opts = {
      quickfix = {
        show = "always",
        position = "belowright",
        size = 10,
        encoding = "utf-8",
        auto_close_when_success = true,
      },
      toggleterm = {
        direction = "float",
        close_on_exit = false,
        auto_scroll = true,
        singleton = true,
      },
      overseer = {
        new_task_opts = {
          strategy = {
            "toggleterm",
            direction = "horizontal",
            auto_scroll = true,
            quit_on_exit = "success"
          }
        },
        on_new_task = function(task)
          require("overseer").open(
              { enter = false, direction = "right" }
          )
        end,
      },
      terminal = {
        name = "Main Terminal",
        prefix_name = "[CMakeTools]: ",
        split_direction = "horizontal",
        split_size = 11,
        single_terminal_per_instance = true,
        single_terminal_per_tab = true,
        keep_terminal_static_location = true,
        auto_resize = true,
        start_insert = false,
        focus = false,
        do_not_add_newline = false,
      },
    },
  },
  cmake_runner = {
    name = "terminal",
    opts = {},
    default_opts = {
      quickfix = {
        show = "always",
        position = "belowright",
        size = 10,
        encoding = "utf-8",
        auto_close_when_success = true,
      },
      toggleterm = {
        direction = "float",
        close_on_exit = false,
        auto_scroll = true,
        singleton = true,
      },
      overseer = {
        new_task_opts = {
          strategy = {
            "toggleterm",
            direction = "horizontal",
            auto_scroll = true,
            quit_on_exit = "success"
          }
        },
        on_new_task = function(task)
        end,
      },
      terminal = {
        name = "Main Terminal",
        prefix_name = "[CMakeTools]: ",
        split_direction = "horizontal",
        split_size = 11,
        single_terminal_per_instance = true,
        single_terminal_per_tab = true,
        keep_terminal_static_location = true,
        auto_resize = true,
        start_insert = false,
        focus = false,
        do_not_add_newline = false,
      },
    },
  },
  cmake_notifications = {
    runner = { enabled = true },
    executor = { enabled = true },
    spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    refresh_rate_ms = 100,
  },
  cmake_virtual_text_support = true,
}
EOF
