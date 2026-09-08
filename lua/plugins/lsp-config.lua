return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { 'lua_ls', "ts_ls", "pyright", "csharp_ls"},
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })
      vim.lsp.config("csharp_ls", {
        capabilities = capabilities,
      })
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        before_init = function(_, config)
          local venv_path = os.getenv("VIRTUAL_ENV")
          if venv_path then
            config.settings.python.pythonPath = venv_path .. "/bin/python"
          elseif config.root_dir and vim.fn.executable(config.root_dir .. "/.venv/bin/python") == 1 then
            config.settings.python.pythonPath = config.root_dir .. "/.venv/bin/python"
          end
        end,
        settings = {
          python = {
            venvPath = ".",
            venv = ".venv",
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("csharp_ls")
      vim.lsp.enable("pyright")
      vim.lsp.codelens.enable(true)

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    end,
  },
}
