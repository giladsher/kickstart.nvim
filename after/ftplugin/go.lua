local treesitter = require 'nvim-treesitter'

treesitter.install { 'go' }

vim.treesitter.start()
