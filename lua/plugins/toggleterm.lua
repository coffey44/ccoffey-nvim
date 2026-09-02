return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    hide_numbers = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    close_on_exit = false,
    direction = "float",
    float_opts = {
      border = "curved",
      width = function()
        return math.floor(vim.o.columns * 0.9)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.85)
      end,
      winblend = 0,
    },
    size = function(term)
      if term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.4)
      end

      return 20
    end,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local terminal = require("toggleterm.terminal")

    local function new_terminal(direction)
      local term = terminal.Terminal:new({ direction = direction })
      term:open(nil, direction)
      return term
    end

    vim.api.nvim_create_user_command("ToggleTermNewFloat", function()
      new_terminal("float")
    end, { desc = "Create a new floating terminal" })

    vim.api.nvim_create_user_command("ToggleTermNewVertical", function()
      new_terminal("vertical")
    end, { desc = "Create a new vertical terminal" })

    local function set_terminal_keymaps()
      local keymap_opts = { buffer = 0, silent = true }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], keymap_opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], keymap_opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], keymap_opts)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = set_terminal_keymaps,
    })
  end,
}
