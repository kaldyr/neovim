--
-- Options
--
-- Define the Leader Key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- General
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

-- Folding
vim.o.foldcolumn = '1'
vim.o.foldenable = true
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'

-- Indenting
vim.opt.autoindent = true;
vim.opt.expandtab = false
vim.opt.shiftwidth = 0
vim.opt.smarttab = false
vim.opt.softtabstop = -1
vim.opt.tabstop = 4

-- Special characters
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

--
-- Keybinds
-- 
-- All Modes
vim.keymap.set('', '<Space>', '<Nop>', { silent = true })

-- Normal Mode
-- Escape removes highlights
vim.keymap.set('n', '<ESC>', ':noh<CR>', { silent = true })
-- Move current line
vim.keymap.set('n', '<', '<<', { silent = true, noremap = true })
vim.keymap.set('n', '>', '>>', { silent = true, noremap = true })
vim.keymap.set('n', '<Down>', ':move .+1<CR>==', { silent = true, noremap = true })
vim.keymap.set('n', '<Up>', ':move .-2<CR>==', { silent = true, noremap = true })
-- Move character under cursor
vim.keymap.set('n', '<Left>', '"mxh"mP', { silent = true })
vim.keymap.set('n', '<Right>', '"mx"mp', { silent = true })
-- Window management
vim.keymap.set('n', '<C-w>n', ':new<CR>:Telescope find_files<CR>', { desc = 'Split down', silent = true })
vim.keymap.set('n', '<C-w>v', ':vnew<CR>:Telescope find_files<CR>', { desc = 'Split to right', silent = true })
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', { silent = true })
-- Movement
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- Spellcheck
vim.keymap.set('n', '<leader>S', ':set invspell<CR>', { desc = 'Toggle Spellcheck', silent = true, noremap = true })
-- Replace word under cursor
vim.keymap.set(
	'n',
	'<leader>r',
	':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gcI<left><left><left><left>',
	{ desc = 'Replace [W]ord under cursor', silent = false }
)
-- Smart dd - if the line is empty don't override registers
vim.keymap.set(
	'n',
	'dd',
	function()
		if vim.api.nvim_get_current_line():match('^%s*$') then
			return '"_dd'
		end
		return 'dd'
	end,
	{ expr = true }
)

-- Visual Mode
-- Stay in visual mode after indent
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })
-- Move text
vim.keymap.set('v', '<Down>', ":move '>+1<CR>gv=gv", { silent = true, noremap = true })
vim.keymap.set('v', '<Up>', ":move '<-2<CR>gv=gv", { silent = true, noremap = true })
-- Execute/Replay Macro over selection
vim.keymap.set('x', '.', ':norm .<CR>', { silent = true, noremap = true })
vim.keymap.set('x', '@', ':norm @@<CR>', { silent = true, noremap = true })
-- Replace selection
vim.keymap.set(
	'v',
	'<leader>r',
	'"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>',
	{ desc = 'Replace [S]election', silent = false }
)

-- Stuff to set whenever first entering neovim
vim.api.nvim_create_autocmd( 'VimEnter', {
	pattern = '*',
	callback = function()

		-- Turn on list characters, can be toggled by :set list!
		vim.cmd [[ set list ]]

		-- Set the current working directory to the path of the file passed to neovim
		local pwd = vim.fn.expand( '%:p:h' )
		vim.api.nvim_set_current_dir( pwd )

		-- If neovim opened a folder instead of a file, remove netrw and open telescope find_files
		if string.sub( vim.fn.expand('%p'), 0, -1 ) == pwd then
			vim.api.nvim_buf_delete( 0, { force = true } )
			require('telescope.builtin').find_files()
		end

	end,
})

-- Deal with yaml's stupid decisions
vim.api.nvim_create_autocmd( 'FileType', {
	pattern = { 'yaml', 'yml' },
	command = 'setlocal expandtab'
})

-- Languages with tabstop=2
vim.api.nvim_create_autocmd( 'FileType', {
	pattern = { 'css', 'htm', 'html', 'templ', 'tmpl', 'yaml', 'yml' },
	command = 'setlocal tabstop=2'
})

-- Open help on the side
vim.api.nvim_create_autocmd( 'FileType', {
	pattern = 'help',
	command = 'wincmd L'
})

-- Lsp Attach
-- vim.api.nvim_create_autocmd( 'LspAttach', {
-- 	callback = function()
-- 	end
-- })

-- Clear the diagnostic warnings, this is generated by the flake before getting here.
PluginsFromNix = PluginsFromNix or {}

-- Get Lazy configured and setup plugins
require('lazy').setup({
	spec = {
		{ 'romgrk/barbar.nvim',
			dir = PluginsFromNix['barbar-nvim'],
			init = function()
				vim.g.barbar_auto_setup = false
			end,
			keys = {
				{ '<C-p>', ':BufferPick<CR>', noremap = true, silent = true },
				{ '<C-n>', ':BufferPin<CR>', noremap = true, silent = true },
				-- Keyd used to remap the following to get around the C-, C-. limitations of neovim
				{ '<Leader>bp', ':BufferPrevious<CR>', noremap = true, silent = true }, -- <C-,>
				{ '<Leader>bn', ':BufferNext<CR>', noremap = true, silent = true }, -- <C-.>
				{ '<Leader>BP', ':BufferMovePrevious<CR>', noremap = true, silent = true }, -- <C-S-,>
				{ '<Leader>BN', ':BufferMoveNext<CR>', noremap = true, silent = true }, -- <C-S-.>
			},
			opts = {
				auto_hide = 1
			},
		},
		{ 'nat-418/boole.nvim',
			dir = PluginsFromNix['boole-nvim'],
			opts = {
				allow_caps_additions = {
					{ 'true', 'false' },
					{ 'yes', 'no' },
				},
				mappings = {
					increment = '<C-a>',
					decrement = '<C-x>',
				},
			},
		},
		{ 'catppuccin/nvim',
			dir = PluginsFromNix['catppuccin-nvim'],
			name = 'catppuccin',
			lazy = false,
			priority = 1000,
			init = function()
				vim.cmd [[colorscheme catppuccin]]
			end,
			opts = {
				flavour = 'frappe',
				background = {
					light = 'latte',
					dark = 'frappe',
				},
				dim_inactive = {
					enabled = true,
					shade = 'dark',
					percentage = 0.35,
				},
				integrations = {
					barbar = true,
					cmp = true,
					flash = true,
					gitsigns = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { 'italic' },
							hints = { 'italic' },
							warnings = { 'italic' },
							information = { 'italic' },
							ok = { 'italic' },
						},
						underlines = {
							errors = { 'underline' },
							hints = { 'underline' },
							warnings = { 'underline' },
							information = { 'underline' },
							ok = { 'underline' },
						},
						inlay_hints = {
							background = true,
						},
					},
					mini = {
						enabled = true,
					},
					noice = true,
					render_markdown = true,
					telescope = {
						enabled = true,
					},
					treesitter = true,
					treesitter_context = true,
					which_key = true,
				},
				term_colors = true,
			},
		},
		{ 'folke/flash.nvim',
			dir = PluginsFromNix['flash-nvim'],
			keys = {
				{ 'S', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash' }
			},
			opts = {},
		},
		{ 'lewis6991/gitsigns.nvim',
			dir = PluginsFromNix['gitsigns-nvim'],
			event = { 'BufReadPre', 'BufNewFile' },
			opts = {
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '⨫' },
				},
				preview_config = {
					border = 'single',
				},
				on_attach = function(bufnr)
					local gitsigns = require('gitsigns')
					vim.keymap.set('n', '[g', function() gitsigns.nav_hunk('prev') end, { buffer = bufnr, desc = 'Jump to previous hunk' })
					vim.keymap.set('n', ']g', function() gitsigns.nav_hunk('next') end, { buffer = bufnr, desc = 'Jump to next hunk' })
					vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
					vim.keymap.set('n', '<leader>gu', gitsigns.undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })
					vim.keymap.set('n', '<leader>gS', gitsigns.stage_buffer, { buffer = bufnr, desc = 'Stage entire buffer' })
					vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
					vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { buffer = bufnr, desc = 'Reset buffer' })
					vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
					vim.keymap.set('n', '<leader>gb', gitsigns.blame_line, { buffer = bufnr, desc = 'Show blame information' })
					vim.keymap.set('n', '<leader>gD', gitsigns.diffthis, { buffer = bufnr, desc = 'Diff buffer' })
					vim.keymap.set('n', '<leader>gT', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle current blame' })
					vim.keymap.set('n', '<leader>gd', gitsigns.toggle_deleted, { buffer = bufnr, desc = 'Toggle deleted' })
				end,
			},
		},
		{ 'folke/lazydev.nvim',
			dir = PluginsFromNix['lazydev-nvim'],
			ft = 'lua',
			opts = {},
		},
		{ 'nvim-lualine/lualine.nvim',
			dir = PluginsFromNix['lualine-nvim'],
			opts = {
				options = {
					show_filename_only = false,
					theme = 'catppuccin',
				},
				sections = {
					lualine_c = {
						{ 'filename', path = 1 },
					},
				},
			},
		},
		{ 'folke/noice.nvim',
			dir = PluginsFromNix['noice-nvim'],
			event = 'VeryLazy',
			opts = {
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			},
		},
		{ 'MunifTanjim/nui.nvim', dir = PluginsFromNix['nui-nvim'], lazy = true },
		{ 'hrsh7th/cmp-buffer', dir = PluginsFromNix['cmp-buffer'], lazy = true },
		{ 'hrsh7th/cmp-nvim-lsp', dir = PluginsFromNix['cmp-nvim-lsp'], lazy = true },
		{ 'hrsh7th/cmp-path', dir = PluginsFromNix['cmp-path'], lazy = true },
		{ 'hrsh7th/nvim-cmp',
			dir = PluginsFromNix['nvim-cmp'],
			opts = {
				completion = {
					completeopt = 'menu,menuone,noinsert',
				},
				mapping = require('cmp').mapping.preset.insert {
					['<C-j>'] = require('cmp').mapping.select_next_item(),
					['<C-k>'] = require('cmp').mapping.select_prev_item(),
					['<C-u>'] = require('cmp').mapping.scroll_docs(-4),
					['<C-d>'] = require('cmp').mapping.scroll_docs(4),
					['<C-Space>'] = require('cmp').mapping.complete(),
					['<CR>'] = require('cmp').mapping.confirm({
						behavior = require('cmp').ConfirmBehavior.Replace,
						select = true
					}),
					['<Tab>'] = require('cmp').mapping(function(fallback)
						if require('cmp').visible() then
							require('cmp').select_next_item()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = require('cmp').mapping(function(fallback)
						if require('cmp').visible() then
							require('cmp').select_prev_item()
						else
							fallback()
						end
					end, { 'i', 's' }),
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'path' },
					{ name = 'buffer' },
				},
			},
		},
		{ 'neovim/nvim-lspconfig',
			dir = PluginsFromNix['nvim-lspconfig'],
			config = function()
				vim.filetype.add({ extension = { templ = "templ" } }) -- a-h/templ Go
				require('lspconfig').cssls.setup { }
				require('lspconfig').gopls.setup { }
				require('lspconfig').html.setup { filetypes = { "html", "templ" } }
				require('lspconfig').htmx.setup { filetypes = { "html", "templ" } }
				require('lspconfig').lua_ls.setup { }
				require('lspconfig').marksman.setup { }
				require('lspconfig').nil_ls.setup { }
				require('lspconfig').nushell.setup { }
				require('lspconfig').taplo.setup { }
				require('lspconfig').templ.setup { }
				require('lspconfig').yamlls.setup { }
				vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, { desc = 'Go to previous diagnostic message' })
				vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, { desc = 'Go to next diagnostic message' })
				vim.g.markdown_fenced_languages = {
					'css',
					'fish',
					'html',
					'go',
					'javascript',
					'json',
					'lua',
					'nix',
					'python',
					'sql',
					'vim',
				}
			end
		},
		{ 'nvim-treesitter-context', dir = PluginsFromNix['nvim-treesitter-context'], lazy = true },
		{ 'nvim-treesitter/nvim-treesitter-textobjects', dir = PluginsFromNix['nvim-treesitter-textobjects'], lazy = true },
		{ 'nvim-treesitter/nvim-treesitter',
			dir = PluginsFromNix['nvim-treesitter'],
			keys = {
				{ ';', require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move, mode = { 'n', 'x', 'o' } },
				{ ',', require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move_opposite, mode = { 'n', 'x', 'o' } },
			},
			opts = {
				auto_install = false,
				ensure_installed = {},
				ignore_install = {},
				highlight = { enable = true },
				sync_install = false,
				modules = {},
				autotag = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
				},
				textobjects = {
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							[']f'] = { query = '@call.outer', desc = 'Next function call start' },
							[']m'] = { query = '@function.outer', desc = 'Next method/function def start' },
							[']c'] = { query = '@class.outer', desc = 'Next class start' },
							[']i'] = { query = '@conditional.outer', desc = 'Next conditional start' },
							[']l'] = { query = '@loop.outer', desc = 'Next loop start' },
							[']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
							[']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
						},
						goto_next_end = {
							[']F'] = { query = '@call.outer', desc = 'Next function call end' },
							[']M'] = { query = '@function.outer', desc = 'Next method/function def end' },
							[']C'] = { query = '@class.outer', desc = 'Next class end' },
							[']I'] = { query = '@conditional.outer', desc = 'Next conditional end' },
							[']L'] = { query = '@loop.outer', desc = 'Next loop end' },
						},
						goto_previous_start = {
							['[f'] = { query = '@call.outer', desc = 'Prev function call start' },
							['[m'] = { query = '@function.outer', desc = 'Prev method/function def start' },
							['[c'] = { query = '@class.outer', desc = 'Prev class start' },
							['[i'] = { query = '@conditional.outer', desc = 'Prev conditional start' },
							['[l'] = { query = '@loop.outer', desc = 'Prev loop start' },
							['[s'] = { query = '@scope', query_group = 'locals', desc = 'Prev scope' },
							['[z'] = { query = '@fold', query_group = 'folds', desc = 'Prev fold' },
						},
						goto_previous_end = {
							['[F'] = { query = '@call.outer', desc = 'Prev function call end' },
							['[M'] = { query = '@function.outer', desc = 'Prev method/function def end' },
							['[C'] = { query = '@class.outer', desc = 'Prev class end' },
							['[I'] = { query = '@conditional.outer', desc = 'Prev conditional end' },
							['[L'] = { query = '@loop.outer', desc = 'Prev loop end' },
						},
					},
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
							['l='] = { query = '@assignment.lhs', desc = 'Select left part of assignment' },
							['r='] = { query = '@assignment.rhs', desc = 'Select right part of assignment' },
							['aa'] = { query = '@parameter.outer', desc = 'Select outer part of parameter/argument' },
							['ia'] = { query = '@parameter.inner', desc = 'Select inner part of parameter/argument' },
							['af'] = { query = '@call.outer', desc = 'Select outer part of method region' },
							['if'] = { query = '@call.inner', desc = 'Select inner part of method region' },
							['am'] = { query = '@function.outer', desc = 'Select outer part of function region' },
							['im'] = { query = '@function.inner', desc = 'Select inner part of function region' },
							['ac'] = { query = '@class.outer', desc = 'Select outer part of class region' },
							['ic'] = { query = '@class.inner', desc = 'Select inner part of class region' },
							['ai'] = { query = '@conditional.outer', desc = 'Select outer part of conditional' },
							['ii'] = { query = '@conditional.inner', desc = 'Select inner part of conditional' },
							['al'] = { query = '@loop.outer', desc = 'Select outer part of loop' },
							['il'] = { query = '@loop.inner', desc = 'Select outer part of loop' },
							['at'] = { query = '@comment.outer', desc = 'Select outer part of comment' },
						},
					},
					swap = {
						enable = true,
						swap_next = { ['<leader>cf'] = '@function.outer', },
						swap_previous = { ['<leader>cF'] = '@function.outer', },
					},
				},
			},
		},
		{ 'nvim-tree/nvim-web-devicons', dir = PluginsFromNix['nvim-web-devicons'], lazy = true },
		{ 'epwalsh/obsidian.nvim',
			dir = PluginsFromNix['obsidian-nvim'],
			cond = function()
				return vim.fn.getcwd() == vim.fn.expand '~' .. '/Notes'
			end,
			opts = {
				completion = { nvim_cmp = true },
				finder = "telescope.nvim",
				mappings = {
					["gf"] = {
						action = function()
							return require('obsidian').util.gf_passthrough()
						end,
						opts = { buffer = true, expr = true, noremap = false },
					},
					["<cr>"] = {
						action = function()
							return require('obsidian').util.smart_action()
						end,
						opts = { buffer = true, expr = true },
					},
				},
				ui = { enable = false },
				workspaces = {
					{ name = "Notes", path = "/home/matt/Notes" },
				},
			},
		},
		{ 'nvim-lua/plenary.nvim', dir = PluginsFromNix['plenary-nvim'], lazy = true },
		{ 'MeanderingProgrammer/render-markdown.nvim',
			dir = PluginsFromNix['render-markdown-nvim'],
			ft = 'markdown',
			opts = {
				file_types = {'markdown'}
			},
		},
		{ 'folke/snacks.nvim',
			dir = PluginsFromNix['snacks-nvim'],
			priority = 1000,
			lazy = false,
			opts = {}
		},
		{ 'sQVe/sort.nvim',
			dir = PluginsFromNix['sort-nvim'],
			keys = {
				{ '<leader>s', ':Sort<CR>', mode = {'n', 'x'}, desc = 'Sort', silent = true },
			},
			opts = {},
		},
		{ 'isak102/telescope-git-file-history.nvim', dir = PluginsFromNix['telescope-git-file-history-nvim'], lazy = true },
		{ 'nvim-telescope/telescope-ui-select.nvim', dir = PluginsFromNix['telescope-ui-select-nvim'], lazy = true },
		{ 'nvim-telescope/telescope.nvim',
			dir = PluginsFromNix['telescope-nvim'],
			keys = {
				{ '<leader>f:', require('telescope.builtin').command_history, desc = 'Command History' },
				{ '<leader>fb', require('telescope.builtin').buffers, desc = 'Find Buffers' },
				{ '<leader>fc', require('telescope.builtin').commands, desc = 'Find Commands' },
				{ '<leader>fd', require('telescope.builtin').diagnostics, desc = 'Find Diagnostics' },
				{ '<leader>ff', require('telescope.builtin').find_files, desc = 'Find Files' },
				{ '<leader>fg', require('telescope.builtin').live_grep, desc = 'Find Grep' },
				{ '<leader>fh', require('telescope.builtin').help_tags, desc = 'Find Help' },
				{ '<leader>fH', require('telescope.builtin').highlights, desc = 'Find Highlights' },
				{ '<leader>fk', require('telescope.builtin').keymaps, desc = 'Find Keymaps' },
				{ '<leader>fm', require('telescope.builtin').marks, desc = 'Find Marks' },
				{ '<leader>fo', require('telescope.builtin').vim_options, desc = 'Find Options' },
				{ '<leader>fr', require('telescope.builtin').oldfiles, desc = 'Recent Files' },
				{ '<leader>fR', require('telescope.builtin').resume, desc = 'Resume' },
				{ '<leader>fG', require('telescope').extensions.git_file_history.git_file_history, desc = 'Git File History' },
			},
			opts = {
				extensions = {
					["ui-select"] = {
						require('telescope.themes').get_dropdown {}
					}
				},
			},
		},
		{ 'rachartier/tiny-inline-diagnostic.nvim',
			dir = PluginsFromNix['tiny-inline-diagnostic-nvim'],
			event = 'VeryLazy',
			priority = 1000,
			init = function()
				vim.diagnostic.config({ virtual_text = false })
			end,
			opts = {}
		},
		{ 'Wansmer/treesj',
			dir = PluginsFromNix['treesj'],
			keys = {
				{ 'J', '<cmd>TSJToggle<cr>', desc = 'Join Toggle' },
			},
			opts = {
				use_default_keymaps = false,
				max_join_length = 150
			},
		},
		{ 'tpope/vim-fugitive', dir = PluginsFromNix['vim-fugitive'], lazy = true },
		{ 'folke/which-key.nvim',
			dir = PluginsFromNix['which-key-nvim'],
			event = "VeryLazy",
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
			opts = {},
		},
	}
})
