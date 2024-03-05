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

    pkgs = import nixpkgs {
      system = system;
      overlays = [ (final: prev: { neovim = neovim.packages.${prev.system}.neovim; }) ];
    };

    neovimWrapped = pkgs.wrapNeovim pkgs.neovim {
      configure = {
        customRC = ''
          set runtimepath+=${./config}
          source ${./config/init.lua}
        '';
        packages.all.start = with pkgs.vimPlugins; [
          boole-nvim
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
          nvim-treesitter.withAllGrammars
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

    runtimeDeps = pkgs.symlinkJoin {
      name = "runtimeDeps";
      paths = with pkgs; [
        lua-language-server
        marksman
        nil
        ripgrep
      ];
      postBuild = ''
        for f in $out/lib/node_modules/.bin/*; do
          path="$(readlink --canonicalize-missing "$f")"
          ln -s "$path" "$out/bin/$(basename $f)"
        done
      '';
    };

  in
  {

    apps = rec {
      nvim = flake-utils.lib.mkApp { drv = self.packages.${system}.nvim; };
      default = nvim;
    };

    packages = rec {
      nvim = pkgs.writeShellApplication {
        name = "nvim";
        runtimeInputs = [ runtimeDeps ];
        text = ''
          ${neovimWrapped}/bin/nvim "$@"
        '';
      };
      default = nvim;
    };

  });

}
