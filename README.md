# Custom Neovim Flake

This is a custom configuration for neovim.

The flake.nix will act as your package manager.  
The flake.lock will keep plugins locked to a specific version.
To update plugins, use ```nix flake update```.  
Install LSPs separately from nixpkgs.  
All configuration is done though stanard lua in the ./config folder.  
Do not use any plugin managers, or mason.  
If a plugin is not in nixpkgs, simply add an input to the git repo with the following format:
```
plugin_NAME = { url = "github:OWNER/REPO"; flake = false; };
```
Example:
```
plugin_obsidian-nvim = { url = "github:epwalsh/obsidian.nvim"; flake = false; };
```

To run without installing:
```
nix run github:kaldyr/neovim -- [arguments]
```
To include in a nix config:
- Add as input in flake.nix
- Add the following to environment.systemPackages or home.packages:
```
inputs.neovim.packages.${pkgs.system}.default
```

Example usage: [https://github.com/kaldyr/nixos/blob/main/home/programs/neovim.nix]
