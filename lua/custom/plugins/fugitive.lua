---@module 'lazy'
---@type LazySpec
return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>gd', '<cmd>Gvdiffsplit!<cr>', desc = '[G]it [D]iff 3-way merge/conflicts' },
    { '<leader>gu', '<cmd>Gvdiffsplit @<cr>', desc = '[G]it Diff [U]nstaged vs index/staged' },
    { '<leader>gh', '<cmd>Gvdiffsplit HEAD<cr>', desc = '[G]it Diff vs [H]EAD' },
    { '<leader>gs', '<cmd>Git<cr>', desc = '[G]it [S]tatus' },
  },
  config = function()
    local set = vim.keymap.set
    set('n', 'gdh', '<cmd>diffget //2<cr>', {
      desc = '[G]it [D]iff [H]ead : take current branch / ours / left pane',
    })
    set('n', 'gdl', '<cmd>diffget //3<cr>', {
      desc = '[G]it [D]iff [L]eft/other : take incoming branch / theirs / right pane',
    })

    -- Optional helpers (also very common)
    set('n', 'gdp', '<cmd>diffput 1<cr>', {
      desc = '[G]it [D]iff [P]ut : push hunk to left pane (ours/current)',
    })
    set('n', 'gdo', '<cmd>diffput 3<cr>', {
      desc = '[G]it [D]iff [O]ther : push hunk to right pane (theirs/incoming)',
    })

    -- Two-way diff fallbacks (non-3way splits)
    set('n', 'do', '<cmd>diffget<cr>', {
      desc = '[G]it [D]iff [O]ther : get hunk from other window',
    })
    set('n', 'dp', '<cmd>diffput<cr>', {
      desc = '[G]it [D]iff [P]ut : put hunk to other window',
    })
    local augroup = vim.api.nvim_create_augroup('Gilad_Fugitive', {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd('BufWinEnter', {
      group = augroup,
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then return end

        local bufnr = vim.api.nvim_get_current_buf()
        local shared_opts = { buffer = bufnr, remap = false }
        set('n', '<leader>gp', function() vim.cmd.Git 'pull' end, Merge(shared_opts, { desc = '[G]it [P]ull' }))

        -- rebase always
        set('n', '<leader>gpsh', function() vim.cmd.Git { 'push' } end, Merge(shared_opts, { desc = '[G]it [P]u[sh]' }))
      end,
    })

    set('n', 'gu', '<cmd>diffget //2<CR>')
    set('n', 'gh', '<cmd>diffget //3<CR>')
  end,
}
