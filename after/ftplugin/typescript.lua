local treesitter = require 'nvim-treesitter'

treesitter.install { 'typescript' }

vim.treesitter.start()
