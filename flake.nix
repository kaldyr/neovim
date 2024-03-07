{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, neovim, ... }: let

    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ (final: prev: { neovim = neovim.packages.x86_64-linux.neovim; }) ];
    };

  in {

    packages.x86_64-linux.default = pkgs.wrapNeovim pkgs.neovim {
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
          nvim-treesitter.withAllGrammars
          nvim-treesitter-context
          nvim-treesitter-textobjects
          nvim-ts-autotag
          nvim-ufo
          nvim-web-devicons
          obsidian-nvim
          oil-nvim
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

  };

}
