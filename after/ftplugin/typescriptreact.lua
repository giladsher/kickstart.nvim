local treesitter = require 'nvim-treesitter'

treesitter.install { 'tsx' }

vim.treesitter.start()
