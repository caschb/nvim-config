local function map(mode, lhs, rhs, opts)
   -- set default value if not specify
   if opts.noremap == nil then
      opts.noremap = true
   end
   if opts.silent == nil then
      opts.silent = true
   end

   vim.keymap.set(mode, lhs, rhs, opts)
end

glopts = vim.g

glopts.mapleader = " "
glopts.maplocalleader = " "

map("n", "<Leader>w", ":write<CR>", {})

map({ "n", "v" }, "<Leader>y", '"+y', {})
map({ "n" }, "<Leader>Y", '"+y$', {})

map({ "n", "v" }, "<Leader>p", '"+p', {})
map({ "n", "v" }, "<Leader>P", '"+P', {})


