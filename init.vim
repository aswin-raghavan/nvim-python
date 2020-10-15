call plug#begin()

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'

Plug 'nvim-lua/completion-nvim'
Plug 'aca/completion-tabnine', { 'do': './install.sh' }


Plug 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'majutsushi/tagbar'
let g:tagbar_autopreview = 1
autocmd BufEnter * nested :call tagbar#autoopen(1)

Plug 'junegunn/fzf', {'dir': '~/.fzf'}
Plug 'junegunn/fzf.vim'
let g:fzf_tags_command = 'ctags -R'
map <leader>o :FZF<CR>
nmap <leader>f :Tags<CR>

Plug 'tpope/vim-surround'

Plug 'airblade/vim-gitgutter'

Plug 'lervag/vimtex'
let g:tex_flavor = 'latex'

Plug 'easymotion/vim-easymotion'
" " Jump to anywhere you want with minimal keystrokes, with just one key binding.
" " `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

Plug 'mbbill/undotree'

Plug 'heavenshell/vim-pydocstring'
let g:pydocstring_doq_path = "/usr/local/bin/doq"

Plug 'ryanoasis/vim-devicons'

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'dense-analysis/ale'

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
" Plug 'Shougo/deoplete-lsp'
" Plug 'deoplete-plugins/deoplete-jedi'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" All of your Plugs must be added before the following line
call plug#end()

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
silent! lua << EOF
require'nvim_lsp'.jedi_language_server.setup{on_attach=require'completion'.on_attach}
EOF

" vimrc
let g:completion_chain_complete_list = {
    \ 'python': [
    \    {'complete_items': ['lsp',  'tabnine']},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
\}

" tabnine priority (default: 0)
" Defaults to lowest priority
let g:completion_tabnine_priority = 0
" max tabnine completion options(default: 7)
let g:completion_tabnine_max_num_results=5
" sort by tabnine score (default: 0)
let g:completion_tabnine_sort_by_details=1

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
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF

silent! lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

silent! lua <<EOF
require'nvim-treesitter.configs'.setup {
  refactor = {
    highlight_definitions = { enable = true },
  },
}
EOF

silent! lua <<EOF
require'nvim-treesitter.configs'.setup {
  refactor = {
    navigation = {
      enable = true,
      keymaps = {
        goto_definition_lsp_fallback = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
}
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

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
" let g:jedi#completions_enabled = 0
" let g:deoplete#sources#jedi#show_docstring = 1

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
