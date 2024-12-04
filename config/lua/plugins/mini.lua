return {

	PluginsFromNix['mini-nvim'],

	config = {
		require('mini.cursorword').setup(),
		require('mini.hipatterns').setup({
			highlighters = {
				hex_color = require('mini.hipatterns').gen_highlighter.hex_color()
			}
		}),
		require('mini.pairs').setup(),
		require('mini.splitjoin').setup(),
	}

}
