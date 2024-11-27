-- Neovim Config
require 'options'
require 'keymaps'
require 'autocmd'

-- Colorscheme
require( 'mini.base16' ).setup({ palette = {
    base00 = "#303446",
    base01 = "#292c3c",
    base02 = "#414559",
    base03 = "#51576d",
    base04 = "#626880",
    base05 = "#c6d0f5",
    base06 = "#f2d5cf",
    base07 = "#babbf1",
    base08 = "#e78284",
    base09 = "#ef9f76",
    base0A = "#e5c890",
    base0B = "#a6d189",
    base0C = "#81c8be",
    base0D = "#8caaee",
    base0F = "#eebebe",
    base0E = "#ca9ee6",
} })

-- Plugins
require( 'mini.ai' ).setup()
require( 'mini.bracketed' ).setup()
require( 'mini.clue' ).setup()
require( 'mini.comment' ).setup()
require( 'mini.completion' ).setup()
require( 'mini.doc' ).setup()
require( 'mini.fuzzy' ).setup()
require( 'mini.git' ).setup()
require( 'mini.hipatterns' ).setup()
require( 'mini.icons' ).setup()
require( 'mini.indentscope' ).setup()
require( 'mini.jump' ).setup()
require( 'mini.jump2d' ).setup()
require( 'mini.move' ).setup()
require( 'mini.notify' ).setup()
require( 'mini.operators' ).setup()
require( 'mini.pairs' ).setup()
require( 'mini.pick' ).setup()
require( 'mini.splitjoin' ).setup()
require( 'mini.statusline' ).setup()
require( 'mini.surround' ).setup()
require( 'mini.tabline' ).setup()
