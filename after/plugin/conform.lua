require("conform").setup({
  formatters_by_ft = {
    python = { "isort", "black" },
    markdown = { "markdownlint" },
    cpp = { "clang-format" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
