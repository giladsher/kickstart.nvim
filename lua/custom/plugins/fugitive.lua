---@param t1 table
---@param t2 table
---@return table
function merge(t1, t2)
  for k, v in pairs(t2) do
    if (type(v) == 'table') and (type(t1[k] or false) == 'table') then
      merge(t1[k], t2[k])
    else
      t1[k] = v
    end
  end
  return t1
end

return {
  'tpope/vim-fugitive',
  config = function()
    local set = vim.keymap.set
    set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it' })

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
        local shared_opts = { buffer = bufnr, remap = false }
        set('n', '<leader>gp', function()
          vim.cmd.Git 'pull'
        end, merge(shared_opts, { desc = '[G]it [P]ull' }))

        -- rebase always
        set('n', '<leader>gpsh', function()
          vim.cmd.Git { 'push' }
        end, merge(shared_opts, { desc = '[G]it [P]u[sh]' }))
      end,
    })

    set('n', 'gu', '<cmd>diffget //2<CR>')
    set('n', 'gh', '<cmd>diffget //3<CR>')
  end,
}
