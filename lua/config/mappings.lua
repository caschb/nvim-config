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

map("n", "<Leader>w", ":write<CR>", { desc = "Save all" })

map({ "n", "v" }, "<Leader>y", '"+y', { desc = "Yank line to system clipboard" })
map({ "n" }, "<Leader>Y", '"+y$', { desc = "Yank to line end to system cliboard" })

map({ "n", "v" }, "<Leader>p", '"+p', { desc = "Paste from system clipboard to next line" })
map({ "n", "v" }, "<Leader>P", '"+P', { desc = "Paste from system clipboard to previous line" })

