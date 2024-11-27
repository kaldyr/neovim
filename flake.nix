{

    inputs = {

        # Nixpkgs for neovim and the the plugins in the nix store
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        # Plugins from git
        # plugin_PLUGINNAME = { url = "github:user/repo"; flake = false; };
        plugin_mini-nvim = { url = "github:echasnovski/mini.nvim"; flake = false; };

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
                    nvim-treesitter.withAllGrammars
                ] ++ (builtins.attrValues pkgs.neovimPlugins);

            };

            withNodeJs = false;
            withPython3 = false;
            withRuby = false;

        };

    };

}
