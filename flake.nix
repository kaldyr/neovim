{

	inputs = {

		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
		flake-utils.url = "github:numtide/flake-utils";

		# Plugins from git
		# "plugin:PLUGIN-NAME" = { url = "github:OWNER/REPO"; flake = false; };
		"plugin:barbar-nvim" = { url = "github:romgrk/barbar.nvim"; flake = false; };
		"plugin:boole-nvim" = { url = "github:nat-418/boole.nvim"; flake = false; };
		"plugin:catppuccin-nvim" = { url = "github:catppuccin/nvim"; flake = false; };
		"plugin:cmp-nvim-lsp" = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
		"plugin:cmp-path" = { url = "github:hrsh7th/cmp-path"; flake = false; };
		"plugin:flash-nvim" = { url = "github:folke/flash.nvim"; flake = false; };
		"plugin:gitsigns-nvim" = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
		"plugin:lazy-nvim" = { url = "github:folke/lazy.nvim"; flake = false; };
		"plugin:lazydev-nvim" = { url = "github:folke/lazydev.nvim"; flake = false; };
		"plugin:lualine-nvim" = { url = "github:nvim-lualine/lualine.nvim"; flake = false; };
		"plugin:mini-nvim" = { url = "github:echasnovski/mini.nvim"; flake = false; };
		"plugin:noice-nvim" = { url = "github:folke/noice.nvim"; flake = false; };
		"plugin:nui-nvim" = { url = "github:MunifTanjim/nui.nvim"; flake = false; };
		"plugin:nvim-cmp" = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
		"plugin:nvim-lspconfig" = { url = "github:neovim/nvim-lspconfig"; flake = false; };
		"plugin:nvim-treesitter-context" = { url = "github:nvim-treesitter/nvim-treesitter-context"; flake = false; };
		"plugin:nvim-treesitter-textobjects" = { url = "github:nvim-treesitter/nvim-treesitter-textobjects"; flake = false; };
		"plugin:nvim-web-devicons" = { url = "github:nvim-tree/nvim-web-devicons"; flake = false; };
		"plugin:obsidian-nvim" = { url = "github:epwalsh/obsidian.nvim"; flake = false; };
		"plugin:plenary-nvim" = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
		"plugin:render-markdown-nvim" = { url = "github:MeanderingProgrammer/render-markdown.nvim"; flake = false; };
		"plugin:sort-nvim" = { url = "github:sQVe/sort.nvim"; flake = false; };
		"plugin:telescope-git-file-history-nvim" = { url = "github:isak102/telescope-git-file-history.nvim"; flake = false; };
		"plugin:telescope-nvim" = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
		"plugin:telescope-ui-select-nvim" = { url = "github:nvim-telescope/telescope-ui-select.nvim"; flake = false; };
		"plugin:tiny-inline-diagnostic-nvim" = { url = "github:rachartier/tiny-inline-diagnostic.nvim"; flake = false; };
		"plugin:vim-fugitive" = { url = "github:tpope/vim-fugitive"; flake = false; };
		"plugin:which-key-nvim" = { url = "github:folke/which-key.nvim"; flake = false; };

	};

	outputs = { self, nixpkgs, flake-utils, ... }@inputs:
	flake-utils.lib.eachDefaultSystem (system:
	let

		# Plugins from nixpkgs
		nixpkgPlugins = with pkgs.vimPlugins; [
			nvim-treesitter.withAllGrammars
		];

		# Extra stuff needed by neovim when running from flake
		extraPackages = with pkgs; [
			# System utilities
			fd
			fzf
			git
			ripgrep
			# Language servers
			gopls
			htmx-lsp
			lua-language-server
			marksman
			taplo
			nil
			yaml-language-server
			vscode-langservers-extracted
			# Extras
			python312Packages.pylatexenc
		];

		pluginsFromInputs = builtins.filter
			(s: (builtins.match "plugin:.*" s) != null)
			(builtins.attrNames inputs);

		pluginName = input: builtins.substring
			(builtins.stringLength "plugin:")
			(builtins.stringLength input)
			input;

		buildPlugin = name: pkgs.vimUtils.buildVimPlugin {
			pname = pluginName name;
			version = "master";
			src = builtins.getAttr name inputs;
		};

		pkgs = import nixpkgs {
			system = system;
			config.allowBroken = true;
			overlays = [
				( final: prev: {
					neovimPlugins = builtins.listToAttrs (
						builtins.map ( plugin: {
							name = pluginName plugin;
							value = buildPlugin plugin;
						} ) pluginsFromInputs
					);
				} )
			];
		};

		grammarsPath = pkgs.symlinkJoin {
			name = "nvim-treesitter-grammars";
			paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
		};

		runtimePaths = pkgs.lib.strings.concatStrings (
			[
				"${./config},"
				"${grammarsPath},"
				"${pkgs.neovimPlugins.lazy-nvim},"
			]
			++
			pkgs.lib.lists.forEach nixpkgPlugins
				( plugin: "${plugin},")
			++
			pkgs.lib.attrsets.mapAttrsToList
				( name: outPath: 
					if name != "lazy-nvim" then
						"${outPath},"
					else "" )
				pkgs.neovimPlugins
			++
			[ "${pkgs.neovim}/share/nvim/runtime" ]
		);

		pluginPathsLua = builtins.concatStringsSep "\n" (
			( [ "PluginsFromNix['parsers'] = '${grammarsPath}/parser'" ] )
			++
			( pkgs.lib.lists.forEach nixpkgPlugins
				( plugin:
					"PluginsFromNix['${plugin.pname}'] = '${plugin}'"
				)
			)
			++
			( pkgs.lib.attrsets.mapAttrsToList
				( name: outPath:
					"PluginsFromNix['${name}'] = '${outPath}'"
				) pkgs.neovimPlugins
			)
		);

	in rec {

		devShells.develop = packages.default;
		devShells.default = pkgs.mkShell {
			packages = [ packages.default ] ++ extraPackages;
		};

		packages.default = pkgs.neovim.override {

			configure = {

				customRC = /* vim */ ''
set runtimepath=${runtimePaths}
lua <<EOF
vim.opt.rtp:append( vim.fn.stdpath('data') )
PluginsFromNix = {}
${pluginPathsLua}
EOF
source ${./config/init.lua}
				'';
				
				packages.all.start = [ pkgs.neovimPlugins.lazy-nvim ];

			};

			withNodeJs = false;
			withPython3 = false;
			withRuby = false;

		};

	});

}
