local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find symbol" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find old files" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Grep string" })
vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Find git commits" })
vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Git status" })


local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

local vimgrep_arguments = { (telescopeConfig.values.vimgrep_arguments) }

table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

local actions = require("telescope.actions")

telescope.setup({
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
})
