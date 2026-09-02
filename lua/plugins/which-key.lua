return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>bb", "<cmd>BufferOrderByBufferNumber<cr>", desc = "Sort By Buffer Number" },
      { "<leader>bc", "<cmd>BufferClose<cr>", desc = "Close Buffer" },
      { "<leader>bd", "<cmd>BufferOrderByDirectory<cr>", desc = "Sort By Directory" },
      { "<leader>bh", "<cmd>BufferPrevious<cr>", desc = "Previous Buffer" },
      { "<leader>bj", "<cmd>BufferMovePrevious<cr>", desc = "Move Buffer Left" },
      { "<leader>bk", "<cmd>BufferMoveNext<cr>", desc = "Move Buffer Right" },
      { "<leader>bl", "<cmd>BufferNext<cr>", desc = "Next Buffer" },
      { "<leader>bn", "<cmd>BufferOrderByName<cr>", desc = "Sort By Name" },
      { "<leader>bp", "<cmd>BufferPin<cr>", desc = "Pin Buffer" },
      { "<leader>br", "<cmd>BufferRestore<cr>", desc = "Restore Buffer" },
      { "<leader>bs", "<cmd>BufferPick<cr>", desc = "Pick Buffer" },
      { "<leader>bD", "<cmd>BufferPickDelete<cr>", desc = "Pick Buffer To Delete" },
      { "<leader>bw", "<cmd>BufferOrderByWindowNumber<cr>", desc = "Sort By Window Number" },

      { "<leader>c", group = "Code" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename Symbol" },

      { "<leader>d", group = "Diagnostics" },
      { "<leader>dd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "<leader>dq", vim.diagnostic.setloclist, desc = "Diagnostics List" },

      { "<leader>f", group = "Find" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },

      { "<leader>g", group = "Git" },
      { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Buffer" },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
      { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff This" },
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
      { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },

      { "<leader>m", group = "Mason" },
      { "<leader>ml", "<cmd>MasonLog<cr>", desc = "Mason Log" },
      { "<leader>mm", "<cmd>Mason<cr>", desc = "Open Mason" },

      { "<leader>n", "<cmd>Neotree filesystem reveal left<cr>", desc = "Reveal Filesystem" },
      { "<leader>N", "<cmd>Neotree close left<cr>", desc = "Close Filesystem" },

      { "<leader>t", group = "Toggle" },
      { "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Git Blame" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
      { "<leader>tn", "<cmd>ToggleTermNewFloat<cr>", desc = "New Float Terminal" },
      { "<leader>ts", "<cmd>TermSelect<cr>", desc = "Select Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<cr>", desc = "Vertical Terminal" },
      { "<leader>tV", "<cmd>ToggleTermNewVertical<cr>", desc = "New Vertical Terminal" },
      { "<leader>tw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "Git Word Diff" },
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
