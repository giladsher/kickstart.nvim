local treesitter = require 'nvim-treesitter'

treesitter.install { 'json' }

vim.treesitter.start()
