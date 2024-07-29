vim.opt.autoindent = true;
vim.opt.clipboard = 'unnamedplus'
vim.opt.conceallevel = 2
vim.opt.cursorline = true
vim.opt.expandtab = true;
vim.opt.fillchars = { eob = ' '; fold = ' '; foldopen = ''; foldsep = ' '; foldclose = ''; }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.showtabline = 0
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.softtabstop = -1
vim.opt.spelllang = 'en_us'
vim.opt.swapfile = false
vim.opt.syntax = 'on'
vim.opt.tabstop = 8
vim.opt.termguicolors = true
vim.opt.timeout = true;
vim.opt.timeoutlen = 400
vim.opt.title = true
vim.opt.undofile = true
vim.opt.wrap = false
vim.opt.shortmess:append "sfI"

vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0
vim.g.netrw_localcopydircmd = 'cp -r'

if vim.g.neovide then
    vim.o.guifont = 'Recursive Mn Csl St:h10'
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_legnth = 0.05
    vim.g.neovide_input_use_logo = false
    vim.g.neovide_scale_factor = 1.0
end
