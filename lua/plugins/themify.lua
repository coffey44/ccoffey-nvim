return {
  'lmantw/themify.nvim',
  lazy = false,
  priority = 999,

  config = function()
    require('themify').setup({
      -- Your list of colorschemes.

      'folke/tokyonight.nvim',
      'rebelot/kanagawa.nvim',
      'navarasu/onedark.nvim',
      'scottmckendry/cyberdream.nvim',
      {
        'catppuccin/nvim',
        name = 'catppuccin',
      },
      'savq/melange-nvim',
      {
        'rose-pine/neovim',
        name = 'rose-pine',
      },
      'sainnhe/everforest',

      -- Built-in colorschemes are also supported.
      'default',
    })
  end,
}
