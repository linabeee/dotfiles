local function noremap(key, cmd, silent)
  silent = silent or false
  return vim.keymap.set("", key, cmd, { noremap = true, silent = silent })
end

local function nnoremap(key, cmd)
  return vim.keymap.set("n", key, cmd, { noremap = true })
end

local function cnoremap(key, cmd)
  return vim.keymap.set("c", key, cmd, { noremap = true })
end

local o = vim.o

o.hlsearch = false
o.splitright = true
o.splitbelow = true
o.linebreak = true
o.signcolumn = "no"
o.mouse = "a"
o.writebackup = false
o.updatetime = 300
o.swapfile = false
o.shada = ""
o.laststatus = 1

noremap("j", "gj")
noremap("k", "gk")
noremap("<F1>", "")
nnoremap("q", "")

local ag = vim.api.nvim_create_augroup("ag", { clear = true })
local function hook_type(types, cmd)
  vim.api.nvim_create_autocmd("FileType", {
    group = ag,
    pattern = types,
    callback = cmd,
  })
end
local function make_offset_callback(offset)
  return function(...)
    local l = vim.bo
    l.shiftwidth = 4
    l.softtabstop = 4
    l.expandtab = true
  end
end
hook_type({ "python", "java" }, make_offset_callback(4))
hook_type({ "lua", "javascript", "sh" }, make_offset_callback(2))

vim.cmd.colorscheme("dim")
