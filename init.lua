
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


local opts = {}

require("vimoptions")
require("lazy").setup("plugins")

-- Error Lens
vim.diagnostic.config({
  virtual_text = {
    spacing = 4,         -- Distance from the end of the code line
    prefix = '●',        -- Symbol to display before the error message
    severity = nil,      -- Show all severities (Error, Warn, Info, Hint)
  },
  signs = true,          -- Keep sign column indicators
  update_in_insert = false, -- Don't update diagnostics while typing
  underline = true,      -- Underline the error text
})
