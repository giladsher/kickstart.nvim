local treesitter = require 'nvim-treesitter'

treesitter.install { 'javascript' }

vim.treesitter.start()
