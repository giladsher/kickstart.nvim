---@module 'lazy'
---@type LazySpec
return {
  'jake-stewart/multicursor.nvim',
  branch = '1.0',
  config = function()
    local mc = require 'multicursor-nvim'
    mc.setup()
    local set = vim.keymap.set
    -- Add or skip adding a new cursor by matching word/selection
    set({ 'n', 'x' }, '<C-n>', function() mc.matchAddCursor(1) end, { desc = 'Add cursor in next matching word/selection' })
    set({ 'n', 'x' }, '<C-s>', function() mc.matchSkipCursor(1) end, { desc = 'Skip cursor to next matching word/selection' })

    -- Add and remove cursors with control + left click.
    set('n', '<c-leftmouse>', mc.handleMouse)
    set('n', '<c-leftdrag>', mc.handleMouseDrag)
    set('n', '<c-leftrelease>', mc.handleMouseRelease)

    -- Disable and enable cursors.
    set({ 'n', 'x' }, '<c-q>', mc.toggleCursor)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
      layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)

      -- Delete the main cursor.
      layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor)

      -- Enable and clear cursors using escape/ctrl+c.
      for _, entry in ipairs {
        { { 'n' }, '<esc>' },
        { { 'n' }, '<C-c>' },
      } do
        local modes, key = unpack(entry)
        layerSet(modes, key, function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end
    end)
  end,
}
