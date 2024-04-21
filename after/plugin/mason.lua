require("mason").setup()
require("mason-lspconfig").setup(
  {
    automatic_installation = true
  })


local opts = { noremap = true, silent = true }
local keymap = vim.keymap
local lsp = vim.lsp
local diag = vim.diagnostic
keymap.set('n', '<leader>e', diag.open_float, opts)
keymap.set('n', '[d', diag.goto_prev, opts)
keymap.set('n', ']d', diag.goto_next, opts)
keymap.set('n', '<leader>q', diag.setloclist, opts)

local custom_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local wk = require("which-key")
  print("Hi!")
  wk.register({
    ['gD'] = { lsp.buf.declaration, "Go to declaration" },
    ['gd'] = { lsp.buf.definition, "Go to definition" },
    ['K'] = { lsp.buf.hover, "Hover" },
    ['gi'] = { lsp.buf.implementation, "Go to implementation" },
    ['gr'] = { lsp.buf.references, "Go to references" },
    ['<C-k>'] = { lsp.buf.signature_help, "Help" },
    ['<leader>wa'] = { lsp.buf.add_workspace_folder, "Add workspace folder" },
    ['<leader>wr'] = { lsp.buf.remove_workspace_folder, "Remove workspace folder" },
    ['<leader>wl'] = { function()
      print(vim.inspect(lsp.buf.list_workspace_folders()))
    end, "List workspace folder" },
    ['<leader>D'] = { lsp.buf.type_definition, "Go to type definition" },
    ['<leader>rn'] = { lsp.buf.rename, "Rename symbol" },
    ['<leader>ca'] = { lsp.buf.code_action, "Code action" },
    ['<leader>f'] = { lsp.buf.formatting, "Format" },
  }, bufopts)
end

local lspconfig = require("lspconfig")
vim.g.coq_settings = { auto_start = "shut-up" }
local coq = require("coq")
lspconfig.lua_ls.setup {
  coq.lsp_ensure_capabilities({ on_attach = custom_attach }),
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}
vim.cmd('COQnow')
lspconfig.clangd.setup { on_attach = custom_attach }
lspconfig.cmake.setup { on_attach = custom_attach }
lspconfig.pylsp.setup { on_attach = custom_attach }
lspconfig.texlab.setup { on_attach = custom_attach }
lspconfig.elixirls.setup { on_attach = custom_attach }
lspconfig.rust_analyzer.setup { on_attach = custom_attach }
