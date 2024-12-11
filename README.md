# Custom Neovim Flake

## Description

This is a custom flake containing a pre-configured neovim  
It also outputs a shell containing dependencies when I want to run on other computers.  
It works with plugins from pkgs.vimPlugins and plugins pulled directly from github.  
It manages all plugins, lsps, and grammars.  
It uses lazy.nvim only to configure and load plugins.  
Any neovim configured with lazy.nvim can be adapted easily.  

### Plugin management

Plugins can be installed either directly from github or from nixpkgs.  

#### Installation
If you want a plugin from nixpkgs, add it to the nixpkgPlugins list at the top of the outputs:
```nix
	# Plugins from nixpkgs
	nixpkgPlugins = with pkgs.vimPlugins; [
		nvim-treesitter.withAllGrammars
		PLUGIN_NAME
		...
	];
```

If you install a plugin from github, add it is an input to the flake with the following format:
```nix
	"plugin:PLUGIN-NAME" = { url = "github:OWNER/REPO"; flake = false; };
```

The flake will automatically do the following:
- Create a global key/value table in lua named PluginsFromNix
- Reset neovim's runtime path
- Arrange the new runtime path in the correct order to load treesitter grammars.

It is important to configure lazy with this:
```lua
require('lazy').setup({
	performance = {
		rtp = {
			reset = false,
```
Treesitter grammars from nixpkgs will not correctly load if lazy.nvim controls the runtime path.

#### Configuring

The PluginsFromNix lua table allows you to tell lazy the nix store path the plugin is installed to.  
Configure plugins just like you would with lazy.nvim, but add the following line:
```lua
	dir = PluginsFromNix['PLUGIN_NAME'];
```
Where PLUGIN_NAME is the same name you gave it in the flake.nix inputs or pkgs.vimPlugins.PLUGIN_NAME.  

Example:
flake.nix:
```nix
{
	inputs = {
		...
        "plugin:which-key-nvim" = { url = "github:folke/which-key.nvim"; flake = false; };
		...
	}
	...
```
lazy plugin table:
```lua
{
	'folke/which-key.nvim',
	dir = PluginsFromNix['which-key-nvim'],
	event = 'VeryLazy',
	keys = {
		{
			'<leader>?',
			function()
				require('which-key').show({ global = false })
			end,
			desc = 'Buffer Local Keymaps (which-key)',
		},
	},
	opts = {},
}
```

#### Updating

The flake.lock file locks plugins separately from your system (unless you have nixpkgs follow system)  
You can update your system freely without worrying about a volatile neovim plugin breaking your editor next time you open it.  
This flake will act as your package manager.  

To update plugins, use ```nix flake update```.  

To run without installing:
```
nix shell github:kaldyr/neovim -- -c nvim
```
To include in a nix config:
- Add as input in flake.nix
- Install the package with:
```
inputs.neovim.packages.${pkgs.system}.default
```
- Or add as an overlay with:
```
overlays.modifications = final: prev: {
	...
	neovim = inputs.neovim.packages.${prev.system}.default;
	...
};

...

"system" = nixpkgs.lib.nixosSystem {
	...
	modules = [
		...
		{ nixpkgs.overlays = with overlays; [ modifications ]; }
		...
	];
	...
};
```

Example usage: [https://github.com/kaldyr/nixos]
In this example I have this flake's nixpkgs follow my system.  
I only have neovim itself and treesitter grammars from nixpkgs and I don't care if they get updated with my system.  
If you want to load other plugins from nixpkgs I'd recommend NOT having the flake follow your nixpkgs to version lock them.  
