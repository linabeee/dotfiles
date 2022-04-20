function noremap(key, cmd, silent)
  silent = silent or false
  return vim.api.nvim_set_keymap("", key, cmd, { noremap = true, silent = silent })
end

require "plugins"

local o = vim.o

o.hlsearch = false
o.splitright = true
o.splitbelow = true
o.linebreak = true
o.signcolumn = "no"
o.mouse = "a"
o.writebackup = false
o.updatetime = 300
o.expandtab = true
o.softtabstop = 2
o.shiftwidth = 2
o.laststatus = 1
o.wildmode = "longest:full,full"
o.wildoptions = ""

noremap("j", "gj")
noremap("k", "gk")
noremap("<F1>", "<Nop>")
noremap("q", "<Nop>")

vim.g.html_indent_script1 = "inc"
vim.g.html_indent_style1 = "inc"

require("nvim-treesitter.configs").setup {
  ensure_installed = { "html", "javascript", "css", "lua" },
  highlight = {
    enable = true,
  },
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "<F2>",
      },
    },
  },
}
