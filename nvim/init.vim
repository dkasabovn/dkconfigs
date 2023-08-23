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


lua <<EOF
vim.cmd('colorscheme base16-bright')

local nvim_lsp = require'lspconfig'
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

require 'go'.setup({
  goimport = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls', -- if set to gopls will use golsp format
  max_line_len = 120,
  tag_transform = false,
  test_dir = '',
  comment_placeholder = '   ',
  lsp_cfg = true, -- false: use your own lspconfig
  lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true, -- use on_attach from go.nvim
  dap_debug = true,
})

local protocol = require'vim.lsp.protocol'

-- Run gofmt + goimport on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

nvim_lsp['pyright'].setup {
	on_attach = on_attach,
}

-- Ccls setup
nvim_lsp.ccls.setup {
  init_options = {
	  compilationDatabaseDirectory = "build";
	  index = {
		  threads = 0;
	  };
	  clang = {
		  excludeArgs = { "-frounding-math" };
	  };
  }
}
EOF

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
