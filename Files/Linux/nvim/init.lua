-- Plugins
vim.cmd("call plug#begin()")
vim.cmd("Plug 'preservim/nerdtree'")
vim.cmd("Plug 'lervag/vimtex'")
vim.cmd("Plug 'junegunn/fzf.vim'")
vim.cmd("Plug 'nvim-tree/nvim-web-devicons'")
vim.cmd("Plug 'neovim/nvim-lspconfig'")
vim.cmd("Plug 'hrsh7th/nvim-cmp'")
vim.cmd("Plug 'hrsh7th/cmp-nvim-lsp'")
vim.cmd("Plug 'neovim/nvim-lspconfig', { 'tag': 'v1.8.0', 'frozen': 1 }")
vim.cmd("Plug 'mason-org/mason.nvim', { 'tag': 'v1.11.0', 'frozen': 1 }")
vim.cmd("Plug 'mason-org/mason-lspconfig.nvim', { 'tag': 'v1.32.0', 'frozen': 1 }")
vim.cmd("Plug 'hrsh7th/nvim-cmp'")
vim.cmd("Plug 'hrsh7th/cmp-nvim-lsp'")
vim.cmd("Plug 'folke/tokyonight.nvim'")
vim.cmd("call plug#end()")

vim.cmd[[colorscheme tokyonight]]

vim.g.mapleader = " "
vim.opt.encoding = "utf-8"
vim.opt.backup = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.conceallevel = 1

-- Spellcheck
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Display
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.wildmenu = true
vim.opt.wildmode = { "list", "longest" }
vim.opt.number = true
vim.opt.linebreak = true
vim.cmd("syntax on")
vim.opt.mouse = "a"
vim.opt.laststatus = 2

-- Highlighting
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Keymappings
vim.api.nvim_set_keymap("n", "<down>", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "<up>", "gk", { noremap = true })
vim.api.nvim_set_keymap("n", "gj", "<down>", { noremap = true })
vim.api.nvim_set_keymap("n", "gk", "<up>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-b>", ":NERDTreeToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-F>", ":call fzf#vim#files('.')", { noremap = true })

-- Filetypes
vim.cmd([[
  filetype on
  filetype plugin on
  filetype indent on
]])
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  command = "setlocal tabstop=4 shiftwidth=4 expandtab"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "syn region match start=/\\$\\$/ end=/\\$\\$/"
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "syn match math '\\$[^$].\\{-}\\$'"
})

-- Vimtex
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = "abdmg"

-- LSP Configuration
local function LspAttached()
  local map = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true } 
  map(0, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  map(0, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  map(0, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  map(0, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  map(0, "n", "go", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  map(0, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  map(0, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  map(0, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  map(0, "n", "<C-p>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
  map(0, "x", "<C-p>", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts)
  map(0, "n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = LspAttached
})

-- Lua Configuration
require("mason").setup({})
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
  }
})

local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})

vim.keymap.set('n', '<leader>nv', ':vnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>nh', ':new<CR>', { noremap = true, silent = true })



