{

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... }: let
    
    system = "x86_64-linux";
    pkgs = import nixpkgs { system = system; };

  in {

    packages.x86_64-linux.default = pkgs.neovim.override {

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

      withNodeJs = false;
      withPython3 = false;
      withRuby = false;

    };

  };

}
