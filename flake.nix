{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-util.url = "github:numtide/flake-utils";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, neovim, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem (system:
  let

		neovimWrapped = pkgs.wrapNeovim pkgs.neovim {
			configure = {
				customRC = ''
					set runtimepath+=${./config}
					source ${./config/init.lua}
				'';
				packages.all.start = with pkgs.vimPlugins; [
					catppuccin-nvim
					cmp-buffer
					cmp-cmdline
					cmp-nvim-lsp
					cmp-path
					cmp_luasnip
					comment-nvim
					fidget-nvim
					flash-nvim
					friendly-snippets
					gitsigns-nvim
					indent-blankline-nvim
					lualine-nvim
					luasnip
					neodev-nvim
					neoscroll-nvim
					noice-nvim
					nui-nvim
					nvim-cmp
					nvim-colorizer-lua
					nvim-lspconfig
					nvim-tree-lua
					(nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars))
					nvim-treesitter-context
					nvim-treesitter-textobjects
					nvim-ts-autotag
					nvim-ufo
					nvim-web-devicons
					obsidian-nvim
					plenary-nvim
					promise-async
					rainbow-delimiters-nvim
					sort-nvim
					telescope-frecency-nvim
					telescope-fzf-native-nvim
					telescope-nvim
					telescope-symbols-nvim
					telescope-ui-select-nvim
					vim-fugitive
					vim-illuminate
					which-key-nvim
				];
			};
		};

    pkgs = import nixpkgs {
      system = system;
      overlays = [ (final: prev: { neovim = neovim.packages.${prev.system}.neovim; }) ];
    };

  in
  {
    packages = rec {
      nvim = pkgs.writeShellApplication {
        name = "neovim";
        text = ''
          ${neovimWrapped}/bin/nvim "$@"
        '';
      };
      default = nvim;
    };

    apps = rec {
      nvim = flake-utils.lib.mkApp { drv = self.packages.${system}.nvim; };
      default = nvim;
    };
  });

}
