{

    inputs = {

        # Nixpkgs for the the plugins in the nix store
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        # Plugins from github
        plugin_boole-nvim = { url = "github:nat-418/boole.nvim"; flake = false; };
        plugin_grapple-nvim = { url = "github:cbochs/grapple.nvim"; flake = false; };

    };

    outputs = { nixpkgs, ... }@inputs: let

        system = "x86_64-linux";

        githubPlugins = builtins.filter
            (s: (builtins.match "plugin_.*" s) != null)
            (builtins.attrNames inputs);

        pluginName = input:
            builtins.substring
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
            overlays = [
                ( final: prev: {
                    vimPlugins = prev.vimPlugins // builtins.listToAttrs ( map
                        ( plugin: {
                            name = pluginName plugin;
                            value = buildPlugin plugin;
                        } )
                        githubPlugins );
                } )
            ];
        };

    in {

        packages.${system}.default = pkgs.neovim.override {

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
                    grapple-nvim
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
