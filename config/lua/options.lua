vim.opt.fillchars = {
	eob = ' ',
	fold = ' ',
	foldopen = '',
	foldsep = ' ',
	foldclose = '',
}

vim.opt.listchars = {
	extends  = '⟩',
	lead     = '·',
	nbsp     = '␣',
	precedes = '⟨',
	space = '·',
	tab      = '▏ ',
	trail    = '*',
}

vim.opt.autoindent = true;
vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.smarttab = false
vim.opt.softtabstop = -1
vim.opt.tabstop = 4

vim.opt.clipboard = 'unnamedplus'
vim.opt.conceallevel = 2
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.scrolloff = 8
vim.opt.showtabline = 0
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.spelllang = 'en_us'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.syntax = 'on'
vim.opt.termguicolors = true
vim.opt.timeout = true;
vim.opt.timeoutlen = 400
vim.opt.title = true
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.shortmess:append "sfI"

vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_localcopydircmd = 'cp -r'
