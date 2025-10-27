return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        open_mapping = false, -- we maken onze eigen mapping
        direction = 'float',
        persist_size = true,
        start_in_insert = true,
        shading_factor = 2,
        insert_mappings = false,
        terminal_mappings = false,
      }

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map('n', '<leader>tt', '<cmd>ToggleTerm<CR>', opts)
      map('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', opts)
      map('n', '<leader>th', '<cmd>ToggleTerm size=15 direction=horizontal<CR>', opts)
      map('n', '<leader>tv', '<cmd>ToggleTerm size=80 direction=vertical<CR>', opts)
      map('n', '<C-1>', '<cmd>ToggleTerm 1<CR>', opts)
      map('n', '<C-2>', '<cmd>ToggleTerm 2<CR>', opts)

      function _G.set_toggleterm_keymaps()
        local t_opts = { buffer = 0 }
        map('t', '<esc>', [[<C-\><C-n>]], t_opts)
        map('t', 'jk', [[<C-\><C-n>]], t_opts)
        map('t', '<C-h>', [[<C-\><C-n><C-w>h]], t_opts)
        map('t', '<C-j>', [[<C-\><C-n><C-w>j]], t_opts)
        map('t', '<C-k>', [[<C-\><C-n><C-w>k]], t_opts)
        map('t', '<C-l>', [[<C-\><C-n><C-w>l]], t_opts)
      end

      vim.cmd [[
        autocmd! TermOpen term://*toggleterm#* lua _G.set_toggleterm_keymaps()
      ]]

      function _G._tt_mode()
        local m = vim.fn.mode()
        if m:find 't' then
          return 'TERMINAL'
        end
        if m:find 'i' then
          return 'INSERT'
        end
        if m:find 'v' or m:find 'V' or m == '\22' then
          return 'VISUAL'
        end
        return 'NORMAL'
      end

      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*toggleterm#*',
        callback = function()
          vim.wo[vim.api.nvim_get_current_win()].winbar = '  Terminal %=%{v:lua._tt_mode()}'
        end,
      })
    end,
  },
}
