return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

    local augroup = vim.api.nvim_create_augroup('Gilad_Fugitive', {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd('BufWinEnter', {
      group = augroup,
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set('n', '<leader>gp', function()
          vim.cmd.Git 'pull'
        end, opts)

        -- rebase always
        vim.keymap.set('n', '<leader>gpsh', function()
          vim.cmd.Git { 'push' }
        end, opts)
      end,
    })

    vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>')
    vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>')
  end,
}
