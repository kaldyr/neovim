require('catppuccin').setup({
  flavour = 'frappe',
  background = {
    light = 'latte',
    dark = 'frappe',
  },
  dim_inactive = {
    enabled = true,
    shade = 'dark',
    percentage = 0.15,
  },
  integrations = {
    fidget = true,
    flash = true,
    gitsigns = true,
    illuminate = true,
    native_lsp = {
      enabled = true,
    },
    noice = true,
    notify = true,
    nvimtree = true,
    rainbow_delimiters = true,
    telescope = {
      enabled = true,
    },
    treesitter = true,
    treesitter_context = true,
    ufo = true,
    which_key = true,
  },
})

vim.cmd [[colorscheme catppuccin]]
