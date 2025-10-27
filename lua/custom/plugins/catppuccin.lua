return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Laad dit thema eerst
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato', -- latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
          },
          telescope = true,
          which_key = true,
          cmp = true,
          gitsigns = true,
        },
      }

      -- Stel Catppuccin als je kleurenpalet in
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
