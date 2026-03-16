local treesitter = require 'nvim-treesitter'

treesitter.install { 'jsx' }

vim.treesitter.start()
