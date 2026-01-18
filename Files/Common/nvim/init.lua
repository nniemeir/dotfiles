-- Plugins
vim.cmd("call plug#begin()")
vim.cmd("Plug 'folke/tokyonight.nvim'")
vim.cmd("Plug 'lervag/vimtex'")
vim.cmd("call plug#end()")

vim.cmd.colorscheme("tokyonight")

vim.g.mapleader = " "
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
vim.api.nvim_set_keymap("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap = true })
vim.keymap.set('n', '<leader>nv', ':vnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>nh', ':new<CR>', { noremap = true, silent = true })

-- Filetypes
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
