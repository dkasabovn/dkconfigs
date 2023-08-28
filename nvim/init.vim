set shell=/bin/bash
let mapleader = "\<Space>"

set nocompatible
filetype off
call plug#begin(stdpath('data'))
Plug 'itchyny/lightline.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'ray-x/go.nvim'
Plug 'jvirtanen/vim-hcl'

Plug 'RRethy/nvim-base16'
call plug#end()

lua require('global')
lua require('clangd')

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

set number
set relativenumber

set completeopt=menuone,noinsert,noselect

set shortmess+=c

set updatetime=300

set wildmenu

nmap <leader>ff gg=G<CR>
nmap <leader>; :Buffers<CR>
nmap <leader>w :w<CR>
nmap <leader>ta :tab ba<CR>
nmap <leader>fi :belowright split<CR>:term bash<CR>:resize 10<CR>

map <C-p> :FZF<CR>
map H ^
map L $

tnoremap <C-W>n <C-\><C-n>

set tabstop=4
set shiftwidth=4
set softtabstop=4

if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

noremap <leader>s :Rg<CR>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)
set clipboard+=unnamedplus
