call plug#begin()
Plug 'davidhalter/jedi-vim'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'HansPinckaers/ncm2-jedi'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'

" Plug 'nvim-lua/completion-nvim'
" Plug 'aca/completion-tabnine', { 'do': './install.sh' }

Plug 'scrooloose/nerdtree'

Plug 'majutsushi/tagbar'

Plug 'junegunn/fzf', {'dir': '~/.fzf'}
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'

Plug 'airblade/vim-gitgutter'

Plug 'lervag/vimtex'

Plug 'easymotion/vim-easymotion'

Plug 'mbbill/undotree'

Plug 'heavenshell/vim-pydocstring'

Plug 'ryanoasis/vim-devicons'

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'dense-analysis/ale'

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" " Plug 'Shougo/deoplete-lsp'
" Plug 'deoplete-plugins/deoplete-jedi'

" All of your Plugs must be added before the following line
call plug#end()
let g:python3_host_prog = '/Users/e29154/.pyenv/shims/python'

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:tagbar_autopreview = 1
autocmd BufEnter * nested :call tagbar#autoopen(1)
let g:fzf_tags_command = 'ctags -R'
map <leader>o :FZF<CR>
nmap <leader>f :Tags<CR>
let g:tex_flavor = 'latex'
" " Jump to anywhere you want with minimal keystrokes, with just one key binding.
" " `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
let g:pydocstring_doq_path = "/Users/e29154/.pyenv/shims/doq"

let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#ale#enabled = 1
let g:ale_open_list = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf'],
\}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0

" lua require'nvim_lsp'.pyls.setup{}
" require'nvim_lsp'.jedi_language_server.setup{}
" require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach}
" require'nvim_lsp'.jedi_language_server.setup{}
" require'nvim_lsp'.jedi_language_server.setup{on_attach=require'completion'.on_attach}
silent! lua << EOF
require'nvim_lsp'.jedi_language_server.setup{}
EOF

" let g:completion_chain_complete_list = {
"     \ 'python': [
"     \    {'complete_items': ['lsp']},
"     \    {'mode': '<c-p>'},
"     \    {'mode': '<c-n>'}
"     \]
" \}

" " tabnine priority (default: 0)
" " Defaults to lowest priority
" let g:completion_tabnine_priority = 0
" " max tabnine completion options(default: 7)
" let g:completion_tabnine_max_num_results=5
" " sort by tabnine score (default: 0)
" let g:completion_tabnine_sort_by_details=1

silent! lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}
EOF

silent! lua <<EOF
require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
    smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "grr",
          },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "g*",
        goto_previous_usage = "g#",
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  },
}
EOF

" ncm2 settings
autocmd BufEnter * call ncm2#enable_for_buffer()
" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#documentation_command = "<leader>k"
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'i'
let g:jedi#enable_speed_debugging=0
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = "<leader>a"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" call deoplete#custom#var('tabnine', {
" \ 'line_limit': 500,
" \ 'max_num_results': 5,
" \ })

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" let g:completion_chain_complete_list = {
"     \ 'default': [
"     \    {'complete_items': ['lsp', 'snippet', 'tabnine' ]},
"     \    {'mode': '<c-p>'},
"     \    {'mode': '<c-n>'}
"     \]
" \}
"
set encoding=utf-8 fileformat=unix
set nocompatible              " be iMproved, required
filetype off                  " required
"
filetype plugin indent on    " required
"
set t_ut=
set t_Co=256
set background=dark
silent! colorscheme gruvbox
"
syntax on
"
set number relativenumber
"
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set hlsearch
set incsearch
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set cursorline
hi clear CursorLine
hi CursorLine cterm=underline
set cursorcolumn
hi clear CursorColumn
hi CursorColumn cterm=None ctermfg=10
set colorcolumn=80
hi ColorColumn ctermbg=10
set showmatch

set hidden
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
"
nnoremap <leader>b :Buffers<CR>
map <leader>e :NERDTreeToggle<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nmap <leader>t :TagbarToggle<CR>
nmap <leader>- <Plug>(pydocstring)
"
set updatetime=250
"
set laststatus=2 " Always display the statusline in all windows
set clipboard+=unnamedplus
"
" let g:deoplete#enable_at_startup = 1
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" let g:jedi#completions_enabled = 1
" let g:deoplete#sources#jedi#show_docstring = 1
" let g:deoplete#sources#jedi#enable_typeinfo = 0

" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
"
