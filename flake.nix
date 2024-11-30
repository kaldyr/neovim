{

	inputs = {

		# Nixpkgs for neovim, treesitter with all grammars, lsps, and other runtime helpers
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

		# Plugins from git
		plugin_barbar-nvim = { url = "github:romgrk/barbar.nvim"; flake = false; };
		plugin_boole-nvim = { url = "github:nat-418/boole.nvim"; flake = false; };
		plugin_catppuccin-nvim = { url = "github:catppuccin/nvim"; flake = false; };
		plugin_cmp-buffer = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
		plugin_cmp-cmdline = { url = "github:hrsh7th/cmp-cmdline"; flake = false; };
		plugin_cmp-luasnip = { url = "github:saadparwaiz1/cmp_luasnip"; flake = false; };
		plugin_cmp-nvim-lsp = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
		plugin_cmp-path = { url = "github:hrsh7th/cmp-path"; flake = false; };
		plugin_flake-nvim = { url = "github:folke/flash.nvim"; flake = false; };
		plugin_gitsigns-nvim = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
		plugin_indent-blankline-nvim = { url = "github:lukas-reineke/indent-blankline.nvim"; flake = false; };
		plugin_lualine-nvim = { url = "github:nvim-lualine/lualine.nvim"; flake = false; };
		plugin_luasnip = { url = "github:L3MON4D3/LuaSnip"; flake = false; };
		plugin_mini-nvim = { url = "github:echasnovski/mini.nvim"; flake = false; };
		plugin_neodev-nvim = { url = "github:folke/neodev.nvim"; flake = false; };
		plugin_noice-nvim = { url = "github:folke/noice.nvim"; flake = false; };
		plugin_nui-nvim = { url = "github:MunifTanjim/nui.nvim"; flake = false; };
		plugin_nvim-cmp = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
		plugin_nvim-lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
		plugin_nvim-treesitter-context = { url = "github:nvim-treesitter/nvim-treesitter-context"; flake = false; };
		plugin_nvim-web-devicons = { url = "github:nvim-tree/nvim-web-devicons"; flake = false; };
		plugin_obsidian-nvim = { url = "github:epwalsh/obsidian.nvim"; flake = false; };
		plugin_plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
		plugin_render-markdown-nvim = { url = "github:MeanderingProgrammer/render-markdown.nvim"; flake = false; };
		plugin_sort-nvim = { url = "github:sQVe/sort.nvim"; flake = false; };
		plugin_telescope-git-file-history-nvim = { url = "github:isak102/telescope-git-file-history.nvim"; flake = false; };
		plugin_telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
		plugin_telescope-ui-select-nvim = { url = "github:nvim-telescope/telescope-ui-select.nvim"; flake = false; };
		plugin_which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };

	};

	outputs = { nixpkgs, ... }@inputs: let

		system = "x86_64-linux";

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
			overlays = [ ( final: prev: {
				neovimPlugins = builtins.listToAttrs (
					map ( plugin: {
						name = pluginName plugin;
						value = buildPlugin plugin;
					} ) pluginsFromInputs
				);
			} ) ];
		};

	in {

		packages.${system}.default = pkgs.neovim.override {

			configure = {

				customRC = /* bash */ ''
					set runtimepath+=${./config}
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

	};

}
