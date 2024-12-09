return {
	{ 'romgrk/barbar.nvim',
		dir = PluginsFromNix['barbar-nvim'],
		lazy = false,
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
				{ 'yes',  'no' },
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
			vim.cmd [[ colorscheme catppuccin-frappe ]]
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
				border = 'rounded',
				style = 'minimal',
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
		dependencies = {
			{ 'MunifTanjim/nui.nvim', dir = PluginsFromNix['nui-nvim'] },
		},
		event = 'VeryLazy',
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
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
	{ 'hrsh7th/nvim-cmp',
		dir = PluginsFromNix['nvim-cmp'],
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp', dir = PluginsFromNix['cmp-nvim-lsp'], lazy = true },
			{ 'hrsh7th/cmp-path', dir = PluginsFromNix['cmp-path'], lazy = true },
		},
		lazy = false,
		config = function()
			require('cmp').setup({
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
				},
			})
		end,
	},
	{ 'neovim/nvim-lspconfig',
		dir = PluginsFromNix['nvim-lspconfig'],
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'folke/lazydev.nvim', dir = PluginsFromNix['lazydev-nvim'], ft = 'lua', opts = {} },
		},
		config = function()
			local on_attach = function(_, bufnr)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Goto Definition' })
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto Declaration' })
				vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Goto Implementation' })
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Goto References' })
				vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Goto Type Definition' })
				vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documenation' })
				vim.keymap.set('n', '<leader>cs', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documenation' })
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
				vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Code Rename' })
				vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, { buffer = bufnr, desc = 'Document Symbols' })
				vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = 'Workspace Add Folder' })
				vim.keymap.set('n', '<leader>wl', vim.lsp.buf.list_workspace_folders, { buffer = bufnr, desc = 'Workspace List Folders' })
				vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = 'Workspace Remove Folder' })
				vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, { buffer = bufnr, desc = 'Workspace Symbols' })
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

			vim.filetype.add({ extension = { templ = 'templ' } }) -- a-h/templ Go
			require('lspconfig').cssls.setup { on_attach = on_attach, capabilities = capabilities }
			require('lspconfig').gopls.setup { on_attach = on_attach, capabilities = capabilities }
			require('lspconfig').html.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { 'html', 'templ' } }
			require('lspconfig').htmx.setup { on_attach = on_attach, capabilities = capabilities, filetypes = { 'html', 'templ' } }
			require('lspconfig').lua_ls.setup { on_attach = on_attach, capabilities = capabilities }
			require('lspconfig').marksman.setup { on_attach = on_attach, capabilities = capabilities }
			require('lspconfig').nil_ls.setup { on_attach = on_attach, capabilities = capabilities }
			require('lspconfig').nushell.setup { on_attach = on_attach, capabilities = capabilities }
			require('lspconfig').taplo.setup { on_attach = on_attach, capabilities = capabilities }
			require('lspconfig').templ.setup { on_attach = on_attach, capabilities = capabilities }
			require('lspconfig').yamlls.setup { on_attach = on_attach, capabilities = capabilities }
			vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, { desc = 'Go to previous diagnostic message' })
			vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, { desc = 'Go to next diagnostic message' })
			vim.g.markdown_fenced_languages = {'css', 'fish', 'html', 'go', 'javascript', 'json', 'lua', 'nix', 'python', 'sql', 'vim'}
		end
	},
	{ 'nvim-treesitter/nvim-treesitter',
		dir = PluginsFromNix['nvim-treesitter'],
		main = 'nvim-treesitter.configs',
		dependencies = {
			{ 'nvim-treesitter-context', dir = PluginsFromNix['nvim-treesitter-context'], opts = {line_numbers = false} },
			{ 'nvim-treesitter-textobjects', dir = PluginsFromNix['nvim-treesitter-textobjects'] },
		},
		opts = {
			auto_install = false,
			parser_install_dir = PluginsFromNix['parsers'],
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<C-space>',
					node_incremental = '<C-space>',
					scope_incremental = false,
					node_decremental = '<BS>',
				},
			},
			textobjects = {
				move = {
					enable = true,
					goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
					goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
					goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
					goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
				},
			},
		},
	},
	{ 'nvim-tree/nvim-web-devicons', dir = PluginsFromNix['nvim-web-devicons'], lazy = true },
	{ 'epwalsh/obsidian.nvim',
		dir = PluginsFromNix['obsidian-nvim'],
		event = {
			"BufReadPre " .. vim.fn.expand '~' .. '/Notes/*.md',
			"BufNewFile " .. vim.fn.expand '~' .. '/Notes/*.md',
		},
		opts = {
			completion = { nvim_cmp = true },
			finder = 'telescope.nvim',
			mappings = {
				['gf'] = {
					action = function()
						return require('obsidian').util.gf_passthrough()
					end,
					opts = { buffer = true, expr = true, noremap = false },
				},
				['<cr>'] = {
					action = function()
						return require('obsidian').util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
			},
			ui = {
				enable = false,
				checkboxes = {
					[' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
					['x'] = { char = '', hl_group = 'ObsidianDone' },
				},
			},
			workspaces = {
				{ name = 'Notes', path = vim.fn.expand '~' .. '/Notes' },
			},
		},
	},
	{ 'MeanderingProgrammer/render-markdown.nvim',
		dir = PluginsFromNix['render-markdown-nvim'],
		ft = 'markdown',
		opts = {
			file_types = { 'markdown' }
		},
	},
	{ 'sQVe/sort.nvim',
		dir = PluginsFromNix['sort-nvim'],
		keys = {
			{ '<leader>s', ':Sort<CR>', mode = { 'n', 'x' }, desc = 'Sort', silent = true },
		},
		opts = {},
	},
	{ 'nvim-telescope/telescope.nvim',
		dir = PluginsFromNix['telescope-nvim'],
		dependencies = {
			{ 'nvim-lua/plenary.nvim', dir = PluginsFromNix['plenary-nvim'] },
			{ 'isak102/telescope-git-file-history.nvim', dir = PluginsFromNix['telescope-git-file-history-nvim'] },
			{ 'nvim-telescope/telescope-ui-select.nvim', dir = PluginsFromNix['telescope-ui-select-nvim'] },
			{ 'tpope/vim-fugitive', dir = PluginsFromNix['vim-fugitive'] },
		},
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
				['ui-select'] = {
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
			{ '<leader>J', '<cmd>TSJToggle<CR>', desc = 'Join Toggle' },
		},
		opts = {
			use_default_keymaps = false,
			max_join_length = 999
		},
	},
	{ 'folke/which-key.nvim',
		dir = PluginsFromNix['which-key-nvim'],
		event = 'VeryLazy',
		keys = {
			{
				'<leader>?',
				function()
					require('which-key').show({ global = false })
				end,
				desc = 'Buffer Local Keymaps (which-key)',
			},
		},
		opts = {},
	},
}
