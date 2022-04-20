return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use {
    "jeffkreeftmeijer/vim-dim",
    config = function() vim.cmd("colorscheme dim") end
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-refactor",
    run = ":TSUpdate",
  }
  use {
    "othree/html5.vim",
    ft = "html"
  }
end)
