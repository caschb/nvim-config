require("mason").setup()
require("mason-lspconfig").setup(
  {
    automatic_installation = true
  })


local opts = { noremap=true, silent=true }
local keymap = vim.keymap
local lsp = vim.lsp
local diag = vim.diagnostic
keymap.set('n', '<leader>e', diag.open_float, opts)
keymap.set('n', '[d', diag.goto_prev, opts)
keymap.set('n', ']d', diag.goto_next, opts)
keymap.set('n', '<leader>q', diag.setloclist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap.set('n', 'gD', lsp.buf.declaration, bufopts)
  keymap.set('n', 'gd', lsp.buf.definition, bufopts)
  keymap.set('n', 'K', lsp.buf.hover, bufopts)
  keymap.set('n', 'gi', lsp.buf.implementation, bufopts)
  keymap.set('n', '<C-k>', lsp.buf.signature_help, bufopts)
  keymap.set('n', '<leader>wa', lsp.buf.add_workspace_folder, bufopts)
  keymap.set('n', '<leader>wr', lsp.buf.remove_workspace_folder, bufopts)
  keymap.set('n', '<leader>wl', function()
    print(vim.inspect(lsp.buf.list_workspace_folders()))
  end, bufopts)
  keymap.set('n', '<leader>D', lsp.buf.type_definition, bufopts)
  keymap.set('n', '<leader>rn', lsp.buf.rename, bufopts)
  keymap.set('n', '<leader>ca', lsp.buf.code_action, bufopts)
  keymap.set('n', 'gr', lsp.buf.references, bufopts)
  keymap.set('n', '<leader>f', lsp.buf.formatting, bufopts)
end

local lspconfig = require("lspconfig")
local coq = require("coq")
lspconfig.lua_ls.setup{
  coq.lsp_ensure_capabilities({ on_attach = on_attach }),
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
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
lspconfig.clangd.setup( coq.lsp_ensure_capabilities({ on_attach = on_attach }))
lspconfig.cmake.setup{ coq.lsp_ensure_capabilities({ on_attach = on_attach })}
lspconfig.pylsp.setup{ coq.lsp_ensure_capabilities({ on_attach = on_attach })}
