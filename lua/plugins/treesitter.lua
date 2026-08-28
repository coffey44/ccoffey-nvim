return  -- Treesitter package
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      require("nvim-treesitter").install({
        "lua",
        "javascript",
        "typescript",
        "html",
        "java",
        "json",
        "dockerfile",
        "xml",
        "python",
      })

      -- Enable Tree-sitter highlighting for supported filetypes.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Optional: Tree-sitter indentation.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          vim.bo.indentexpr =
          "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  }
