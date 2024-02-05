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
    # Plugins from Github
    #plugin_obsidian-nvim = { url = "github:epwalsh/obsidian.nvim"; flake = false; };
  };

  outputs = { self, nixpkgs, neovim, flake-utils, ... }@inputs:
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
      comment-nvim
      flash-nvim
      gitsigns-nvim
      indent-blankline-nvim
      lualine-nvim
      neodev-nvim
      neoscroll-nvim
      noice-nvim
      nvim-cmp
      nvim-colorizer-lua
      nvim-lspconfig
      nvim-tree-lua
      (nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars))
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-ts-autotag
      nvim-ufo
			obsidian-nvim
      rainbow-delimiters-nvim
      telescope-nvim
      telescope-frecency-nvim
      telescope-fzf-native-nvim
      telescope-symbols-nvim
      telescope-ui-select-nvim
      vim-fugitive
      vim-illuminate
      which-key-nvim
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      fidget-nvim
      friendly-snippets
      luasnip
      nui-nvim
      nvim-web-devicons
      plenary-nvim
      promise-async
    ];

		# Get the neovim package from the neovim flake instead of nixpkgs
		flakeInputOverlay = prev: final: {
			neovim = neovim.packages.${prev.system}.neovim;
		};

		# # Take all the inputs that begin with "plugin_", build them, and add in
  #   githubPluginOverlay = prev: final:
  #   let
  #     inherit (prev.vimUtils) buildVimPlugin;
  #     plugins = builtins.filter
  #       (s: (builtins.match "plugin_.*" s) != null)
  #       (builtins.attrNames inputs);
  #     plugName = input:
  #       builtins.substring
  #         (builtins.stringLength "plugin_")
  #         (builtins.stringLength input)
  #         input;
  #     buildPlug = name: buildVimPlugin {
  #       pname = plugName name;
  #       version = "master";
  #       src = builtins.getAttr name inputs;
  #     };
  #   in
  #   {
  #     pluginsFromGithub = builtins.listToAttrs (map
  #       (plugin: {
  #         name = plugName plugin;
  #         value = buildPlug plugin;
  #       })
  #       plugins);
  #   };

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
        # githubPluginOverlay
        myNeovimOverlay
      ];
    };

  in
  {
    packages = rec {
      nvim = pkgs.myNeovim;
      default = nvim;
    };

    apps = rec {
      nvim = flake-utils.lib.mkApp { drv = self.packages.${system}.nvim; };
      default = nvim;
    };
  });

}
