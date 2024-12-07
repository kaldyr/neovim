{

    inputs = {

        # Nixpkgs for neovim and the the plugins in the nix store
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        # Plugins from git
        # plugin_PLUGINNAME = { url = "github:user/repo"; flake = false; };
        plugin_telescope-git-file-history-nvim = { url = "github:isak102/telescope-git-file-history.nvim"; flake = false; };

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
                    noice-nvim
                    nui-nvim
                    nvim-cmp
                    nvim-colorizer-lua
                    nvim-lspconfig
                    nvim-treesitter-context
                    nvim-treesitter-textobjects
                    nvim-treesitter.withAllGrammars
                    nvim-ts-autotag
                    nvim-web-devicons
                    obsidian-nvim
                    plenary-nvim
                    promise-async
                    rainbow-delimiters-nvim
                    sort-nvim
                    telescope-fzf-native-nvim
                    telescope-nvim
                    telescope-ui-select-nvim
                    vim-illuminate
                    vim-fugitive
                    which-key-nvim
                ] ++ (builtins.attrValues pkgs.neovimPlugins);

            };

            withNodeJs = false;
            withPython3 = false;
            withRuby = false;

        };

    };

}
