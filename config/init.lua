-- Base Neovim Config
require 'options'
require 'keymaps'
require 'autocmd'

listPlugins = function()
	for key, value in pairs(PluginsFromNix) do
		print( key .. '  |  ' .. value .. '\n' )
	end
end

-- Get Lazy configured and setup plugins
require('lazy').setup({
	spec = {
		{ 'barbar.nvim',
			dir = PluginsFromNix['barbar-nvim'],
			init = function()
				vim.g.barbar_auto_setup = false
			end,
			keys = {
				{ '<C-p>', ':BufferPick<CR>', noremap = true, silent = true },
				{ '<C-n>', ':BufferPin<CR>', noremap = true, silent = true },
				-- Keyd used to get around the C-, C-. C-< C-> limitations of neovim
				{ '<Leader>bp', ':BufferPrevious<CR>', noremap = true, silent = true },
				{ '<Leader>bn', ':BufferNext<CR>', noremap = true, silent = true },
				{ '<Leader>BP', ':BufferMovePrevious<CR>', noremap = true, silent = true },
				{ '<Leader>BN', ':BufferMoveNext<CR>', noremap = true, silent = true },
			},
			opts = {
				auto_hide = 1
			},
		},
		{ 'boole.nvim',
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
		{ 'catppuccin.nvim',
			dir = PluginsFromNix['catppuccin-nvim'],
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
		{ 'flash.nvim',
			dir = PluginsFromNix['flash-nvim'],
			keys = {
				{ 'S', function() require('flash').jump() end, mode = { 'n', 'x', 'o' }, desc = 'Flash' }
			},
			opts = {},
		},
		{ 'gitsigns.nvim',
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
					vim.keymap.set('n', '[g', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Jump to previous hunk' })
					vim.keymap.set('n', ']g', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Jump to next hunk' })
					vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
					vim.keymap.set('n', '<leader>gu', require('gitsigns').undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })
					vim.keymap.set('n', '<leader>gS', require('gitsigns').stage_buffer, { buffer = bufnr, desc = 'Stage entire buffer' })
					vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
					vim.keymap.set('n', '<leader>gR', require('gitsigns').reset_buffer, { buffer = bufnr, desc = 'Reset buffer' })
					vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
					vim.keymap.set('n', '<leader>gb', require('gitsigns').blame_line, { buffer = bufnr, desc = 'Show blame information' })
					vim.keymap.set('n', '<leader>gD', require('gitsigns').diffthis, { buffer = bufnr, desc = 'Diff buffer' })
					vim.keymap.set('n', '<leader>gT', require('gitsigns').toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle current blame' })
					vim.keymap.set('n', '<leader>gd', require('gitsigns').toggle_deleted, { buffer = bufnr, desc = 'Toggle deleted' })
				end,
			},
		},
		{ 'lazydev.nvim', dir = PluginsFromNix['lazydev-nvim'], lazy = true },
		{ 'lualine.nvim',
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
		{ 'noice.nvim', dir = PluginsFromNix['noice-nvim'], event = 'VeryLazy' },
		{ 'nui.nvim', dir = PluginsFromNix['nui-nvim'], lazy = true },
		{ 'cmp-buffer', dir = PluginsFromNix['cmp-buffer'], lazy = true },
		{ 'cmp-nvim-lsp', dir = PluginsFromNix['cmp-nvim-lsp'], lazy = true },
		{ 'cmp-path', dir = PluginsFromNix['cmp-path'], lazy = true },
		{ 'nvim-cmp',
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
		{ 'nvim-lspconfig',
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
		{ 'nvim-treesitter-context', dir = PluginsFromNix['nvim-treesitter-textobjects'], lazy = true },
		{ 'nvim-treesitter',
			dir = PluginsFromNix['nvim-treesitter'],
			keys = {
				{ ';', require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move, mode = { 'n', 'x', 'o' } },
				{ ',', require('nvim-treesitter.textobjects.repeatable_move').repeat_last_move_opposite, mode = { 'n', 'x', 'o' } },
				{ 'f', require('nvim-treesitter.textobjects.repeatable_move').builtin_f, mode = { 'n', 'x', 'o' } },
				{ 'F', require('nvim-treesitter.textobjects.repeatable_move').builtin_F, mode = { 'n', 'x', 'o' } },
				{ 't', require('nvim-treesitter.textobjects.repeatable_move').builtin_t, mode = { 'n', 'x', 'o' } },
				{ 'T', require('nvim-treesitter.textobjects.repeatable_move').builtin_T, mode = { 'n', 'x', 'o' } },
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
		{ 'nvim-web-devicons', dir = PluginsFromNix['nvim-web-devicons'], lazy = true },
		{ 'obsidian.nvim',
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
				ui = {
					enable = false,
					checkboxes = {
					[" "] = { hl_group = "ObsidianTodo" },
					["x"] = { hl_group = "ObsidianDone" },
					},
				},
				workspaces = {
					{ name = "Notes", path = "/home/matt/Notes" },
				},
			},
		},
		{ 'plenary.nvim', dir = PluginsFromNix['plenary-nvim'], lazy = true },
		{ 'render-markdown.nvim',
			dir = PluginsFromNix['render-markdown-nvim'],
			opts = {
				file_types = {'markdown'}
			},
		},
		{ 'snacks.nvim',
			dir = PluginsFromNix['snacks-nvim'],
			priority = 1000,
			lazy = false,
			opts = {}
		},
		{ 'sort.nvim',
			dir = PluginsFromNix['sort-nvim'],
			keys = {
				{ '<leader>s', ':Sort<CR>', mode = {'n', 'x'}, desc = 'Sort', silent = true },
			},
			opts = {},
		},
		{ 'telescope-git-file-history.nvim', dir = PluginsFromNix['telescope-git-file-history-nvim'], lazy = true },
		{ 'telescope-ui-select.nvim', dir = PluginsFromNix['telescope-ui-select-nvim'], lazy = true },
		{ 'telescope-nvim',
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
		{ 'tiny-inline-diagnostic.nvim', dir = PluginsFromNix['tiny-inline-diagnostic-nvim'], lazy = true },
		{ 'vim-fugitive', dir = PluginsFromNix['vim-fugitive'], lazy = true },
		{ 'which-key.nvim', dir = PluginsFromNix['which-key-nvim'], lazy = true },
	}
})
