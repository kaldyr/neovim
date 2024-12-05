{

	inputs = {

		# Nixpkgs for neovim, treesitter with all grammars, lsps, and other runtime helpers
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
		flake-utils.url = "github:numtide/flake-utils";

		# Plugins from git
		plugin_barbar-nvim = { url = "github:romgrk/barbar.nvim"; flake = false; };
		plugin_boole-nvim = { url = "github:nat-418/boole.nvim"; flake = false; };
		plugin_catppuccin-nvim = { url = "github:catppuccin/nvim"; flake = false; };
		plugin_cmp-buffer = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
		plugin_cmp-nvim-lsp = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
		plugin_cmp-path = { url = "github:hrsh7th/cmp-path"; flake = false; };
		plugin_flash-nvim = { url = "github:folke/flash.nvim"; flake = false; };
		plugin_gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
		plugin_lazy-nvim = { url = "github:folke/lazy.nvim"; flake = false; };
		plugin_lazydev-nvim = { url = "github:folke/lazydev.nvim"; flake = false; };
		plugin_lualine-nvim = { url = "github:nvim-lualine/lualine.nvim"; flake = false; };
		# plugin_mini-nvim = { url = "github:echasnovski/mini.nvim"; flake = false; };
		# plugin_noice-nvim = { url = "github:folke/noice.nvim"; flake = false; };
		# plugin_nui-nvim = { url = "github:MunifTanjim/nui.nvim"; flake = false; };
		plugin_nvim-cmp = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
		plugin_nvim-lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
		plugin_nvim-treesitter-context = { url = "github:nvim-treesitter/nvim-treesitter-context"; flake = false; };
		plugin_nvim-treesitter-textobjects = { url = "github:nvim-treesitter/nvim-treesitter-textobjects"; flake = false; };
		plugin_nvim-web-devicons = { url = "github:nvim-tree/nvim-web-devicons"; flake = false; };
		plugin_obsidian-nvim = { url = "github:epwalsh/obsidian.nvim"; flake = false; };
		plugin_plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
		plugin_render-markdown-nvim = { url = "github:MeanderingProgrammer/render-markdown.nvim"; flake = false; };
		plugin_snacks-nvim = { url = "github:folke/snacks.nvim"; flake = false; };
		plugin_sort-nvim = { url = "github:sQVe/sort.nvim"; flake = false; };
		plugin_telescope-git-file-history-nvim = { url = "github:isak102/telescope-git-file-history.nvim"; flake = false; };
		plugin_telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
		plugin_telescope-ui-select-nvim = { url = "github:nvim-telescope/telescope-ui-select.nvim"; flake = false; };
		plugin_tiny-inline-diagnostic-nvim = { url = "github:rachartier/tiny-inline-diagnostic.nvim"; flake = false; };
		plugin_vim-fugitive = { url = "github:tpope/vim-fugitive"; flake = false; };
		plugin_which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };

	};

	outputs = { self, nixpkgs, flake-utils, ... }@inputs:
	flake-utils.lib.eachDefaultSystem (system:
	let

		pluginsFromInputs = builtins.filter
			(s: (builtins.match "plugin_.*" s) != null)
			(builtins.attrNames inputs);

		pluginName = input: builtins.substring
			(builtins.stringLength "plugin_")
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
			overlays = [ ( final: prev: {
				neovimPlugins = builtins.listToAttrs (
					builtins.map ( plugin: {
						name = pluginName plugin;
						value = buildPlugin plugin;
					} ) pluginsFromInputs
				);
			} ) ];
		};

		pluginPathsLua = builtins.concatStringsSep "\n" (
			pkgs.lib.attrsets.mapAttrsToList ( name: outPath:
				"PluginsFromNix['${name}'] = '${outPath}'")
			pkgs.neovimPlugins
		);

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

	in rec {

		devShells.develop = packages.neovim;
		devShells.default = pkgs.mkShell {
			packages = [ packages.neovim ] ++ extraPackages;
		};

		packages.default = packages.neovim;
		packages.neovim = pkgs.neovim.override {

			configure = {

				customRC = /* vimscript */ ''
set runtimepath+=${./config}
lua <<EOF
PluginsFromNix = {}
PluginsFromNix['nvim-treesitter'] = '${pkgs.vimPlugins.nvim-treesitter.withAllGrammars}'
${pluginPathsLua}
EOF
source ${./config/init.lua}
				'';
				
				packages.all.start = with pkgs.vimPlugins; [
					nvim-treesitter.withAllGrammars
				] ++ (builtins.attrValues pkgs.neovimPlugins);

			};

			withNodeJs = false;
			withPython3 = false;
			withRuby = false;

		};

	});

}
