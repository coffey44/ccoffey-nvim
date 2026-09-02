return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local function flatten_onefetch_fields(fields)
      local result = {}

      for _, entry in ipairs(fields or {}) do
        local key, value = next(entry)
        if key then
          result[key] = value
        end
      end

      return result
    end

    local function repo_info_lines()
      local cwd = vim.fn.getcwd()
      local result = vim.system({
        "onefetch",
        "--no-color-palette",
        "--no-bots",
        "-o",
        "json",
        cwd,
      }, { text = true }):wait()

      if result.code ~= 0 or not result.stdout or result.stdout == "" then
        return {
          "Repo info unavailable",
          cwd,
        }
      end

      local ok, parsed = pcall(vim.json.decode, result.stdout)
      if not ok then
        return {
          "Repo info unavailable",
          cwd,
        }
      end

      local fields = flatten_onefetch_fields(parsed.infoFields)
      local project = fields.ProjectInfo or {}
      local head = (fields.HeadInfo or {}).headRefs or {}
      local pending = fields.PendingInfo or {}
      local loc = fields.LocInfo or {}
      local size = fields.SizeInfo or {}
      local updated = fields.LastChangeInfo or {}
      local url = fields.UrlInfo or {}

      local refs = head.refs and table.concat(head.refs, ", ") or head.shortCommitId or "N/A"
      local dirty = string.format(
        "+%d ~%d -%d",
        pending.added or 0,
        pending.modified or 0,
        pending.deleted or 0
      )

      return {
        string.format("Repo: %s", project.repoName or vim.fs.basename(cwd)),
        string.format("Head: %s", refs),
        string.format("Dirty: %s", dirty),
        string.format("LOC: %s", loc.linesOfCode or "N/A"),
        string.format("Size: %s / %s files", size.repoSize or "N/A", size.fileCount or "N/A"),
        string.format("Updated: %s", updated.lastChange or "N/A"),
        string.format("URL: %s", url.repoUrl or "N/A"),
      }
    end

    local art = {
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⠊⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⡰⠈⠀⠀⠠⠂⠂⠀⠀⢀⣀⠀⠀⠀⢀⣀⣴⢟⠛⠉]],
      [[⠀⠀⠀⠀⠀⠀⠀⣾⣧⡠⣂⣤⣬⣲⣶⢷⣾⣛⠙⠳⠀⣤⣿⡿⠃⠂⠀⠀]],
      [[⣀⣀⣀⣀⣀⣀⡀⠛⢿⣷⠟⡋⣩⠻⣗⠀⠻⣝⢻⡌⠀⣍⡥⠊⠀⠀⠀⠀]],
      [[⠈⠑⢝⡻⠿⣿⣿⣿⣾⡟⠘⢋⡉⠞⠒⠒⠋⠈⢲⣿⣿⡛⠁⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠈⠑⠢⠍⠙⣿⣿⣄⡀⣠⣎⡀⠤⢤⣢⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⠀⠙⠙⣿⣿⣿⣿⣿⣿⣛⣿⣿⣿⡅⠀⠀⠀⠀⠀⠀⠀]],
      [[⠀⠀⠀⠀⠀⠀⠀⢀⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⢿⣫⢤⢙⢦⠰⣄⡀⠀⠀]],
      [[⠀⠀⠀⠀⠀⢠⣼⣿⣿⣿⣳⢻⣿⣿⣿⣿⣷⠾⠿⠋⠖⠄⠀⠙⠎⢷⡀⠀]],
      [[⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣯⡁⢿⣿⣿⣶⣶⣶⠶⠞⢉⣇⡀⠀⣀⣼⣷⠀]],
      [[⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣧⡾⢉⡛⠿⠢⢌⢀⣾⣿⣿⣿⣿⣿⣿⠀]],
      [[⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡦⡦⢮⠀⢰⡙⡛⠿⣿⣿⣿⠂]],
      [[⠀⠀⠀⠸⣿⠻⣿⣿⣿⣿⣿⣿⣿⣿⠯⢥⠾⠛⠢⣴⡿⡻⣞⢦⡀⠉⠉⠀]],
      [[⠀⠀⠀⠀⠀⠁⠈⠉⠉⠉⠉⠉⠁⠀⠀⠀⠉⠉⠉⠀⠀⠈⠈⠈⠉⠁⠀⠀]],
    }

    local quote = {
      [[Do or do not.]],
      [[There is no try.]],
    }

    local function pad_right(text, width)
      local padding = math.max(0, width - vim.fn.strdisplaywidth(text))
      return text .. string.rep(" ", padding)
    end

    local function quote_and_art()
      local quote_width = 0
      local art_width = 0

      for _, line in ipairs(quote) do
        quote_width = math.max(quote_width, vim.fn.strdisplaywidth(line))
      end

      for _, line in ipairs(art) do
        art_width = math.max(art_width, vim.fn.strdisplaywidth(line))
      end

      local total = math.max(#quote, #art)
      local lines = {}
      for i = 1, total do
        local left = quote[i] or ""
        local right = art[i] or ""
        lines[i] = pad_right(left, quote_width) .. "    " .. pad_right(right, art_width)
      end

      return lines
    end

    local function prompt_find_file()
      vim.ui.input({ prompt = "Search files: " }, function(input)
        if input == nil then
          return
        end

        vim.schedule(function()
          require("telescope.builtin").find_files({ default_text = input })
        end)
      end)
    end

    pcall(vim.api.nvim_del_user_command, "AlphaDashboardFindFile")
    vim.api.nvim_create_user_command("AlphaDashboardFindFile", prompt_find_file, {
      desc = "Search files from the dashboard",
    })

    dashboard.section.header.val = quote_and_art
    dashboard.section.header.opts.hl = "Keyword"

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Search files", "<cmd>AlphaDashboardFindFile<cr>"),
      dashboard.button("e", "  New file", "<cmd>ene<cr>"),
      dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("c", "  Config", "<cmd>e ~/.config/nvim/init.lua<cr>"),
      dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<cr>"),
      dashboard.button("q", "󰗼  Exit", "<cmd>qa<cr>"),
    }
    dashboard.section.buttons.opts.spacing = 1

    local repo_info = {
      type = "text",
      val = repo_info_lines,
      opts = {
        hl = "Comment",
        position = "center",
      },
    }

    dashboard.config.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header,
      { type = "padding", val = 1 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      repo_info,
    }

    dashboard.config.opts.margin = 5
    dashboard.config.opts.setup = function()
      local group = vim.api.nvim_create_augroup("AlphaDashboardRefresh", { clear = true })

      vim.api.nvim_create_autocmd("DirChanged", {
        group = group,
        callback = function()
          require("alpha").redraw()
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        group = group,
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          local opts = { buffer = buf, silent = true, nowait = true }

          vim.keymap.set("n", "f", "<cmd>AlphaDashboardFindFile<cr>", opts)
          vim.keymap.set("n", "e", "<cmd>ene<cr>", opts)
          vim.keymap.set("n", "r", "<cmd>Telescope oldfiles<cr>", opts)
          vim.keymap.set("n", "c", "<cmd>e ~/.config/nvim/init.lua<cr>", opts)
          vim.keymap.set("n", "l", "<cmd>Lazy<cr>", opts)
          vim.keymap.set("n", "q", "<cmd>qa<cr>", opts)
        end,
      })
    end

    alpha.setup(dashboard.config)
  end,
}
