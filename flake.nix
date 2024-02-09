{

  description = "Custom Neovim";

  inputs = {
    # Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # Flake
    flake-util.url = "github:numtide/flake-utils";
    # Neovim
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, neovim, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem (system:
  let

		# Extra executables
    runtimePackages = with pkgs; [
      lua-language-server
      marksman
      nil
    ];

		# Plugins from nixpkgs
    plugins = with pkgs.vimPlugins; [
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

		# Get the neovim package from the neovim flake instead of nixpkgs
		flakeInputOverlay = prev: final: {
			neovim = neovim.packages.${prev.system}.neovim;
		};

		# Configure neovim
    myNeovimOverlay = prev: final:
		let

			neovimRuntime = pkgs.symlinkJoin {
				name = "neovimRuntime";
				paths = runtimePackages;
				postBuild = ''
					for f in $out/lib/node_modules/.bin/*; do
						path = "$readlink --canonicalize-missing "$f")"
						ln -s "$path" "$out/bin/$(basename $f)"
					done
				'';
			};

			myNeovimUnwrapped = prev.wrapNeovim prev.neovim {
				configure = {
					customRC = ''
						set runtimepath+=${./config}
						source ${./config/init.lua}
					'';
					packages.all.start = plugins;
				};
			};

		in 
		{
			myNeovim = prev.writeShellApplication {
        name = "nvim";
        runtimeInputs = [ neovimRuntime ];
        text = ''
          ${myNeovimUnwrapped}/bin/nvim "$@"
        '';
      };
    };

    pkgs = import nixpkgs {
      system = system;
      overlays = [
				flakeInputOverlay
        myNeovimOverlay
      ];
    };

  in
  {
    packages = rec {
      neovim = pkgs.myNeovim;
      default = neovim;
    };

    apps = rec {
      neovim = flake-utils.lib.mkApp { drv = self.packages.${system}.neovim; };
      default = neovim;
    };
  });

}
