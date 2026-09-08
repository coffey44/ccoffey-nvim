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
        "tsx",
        "css",
        "jsx",
        "c_sharp"
      })

      -- Enable Tree-sitter highlighting for supported filetypes.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(details)
          local bufnr = details.buf
          local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)

          -- Enable nvim-treesitter indentation only if an indents query exists for this language
          if lang and vim.treesitter.query.get(lang, "indents") then
            vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  }
