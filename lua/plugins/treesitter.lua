return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "bibtex", "c", "cmake", "cuda", "cpp", "elixir", "fortran", "rust", "lua", "python", "javascript", "html", "sxhkdrc" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
