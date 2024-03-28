return({
  'stevearc/conform.nvim',
  dependencies = { "mason.nvim" },
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "v" },
      desc = "Format injected langs",
    },
  },
  opts = {},
})
