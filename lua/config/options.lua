local options = vim.opt

options.number = true
options.relativenumber = true
options.scrolloff = 10
options.sidescrolloff = 5;

options.splitkeep = "screen"
options.splitright = true
options.splitbelow = true

options.cursorline = true
options.cursorlineopt = "number"

options.expandtab = true
options.autoindent = true
options.shiftround = true
options.smarttab = true
options.tabstop = 2
options.shiftwidth = 2

options.hlsearch = true
options.ignorecase = true
options.incsearch = true
options.smartcase = true

options.encoding = 'utf-8'

options.swapfile = false

options.termguicolors = true
options.clipboard = 'unnamedplus'
-- options.foldmethod = "syntax"
-- options.foldexpr = "nvim_treesitter#foldexpr()"
options.updatetime = 100
vim.cmd('colorscheme torte')
