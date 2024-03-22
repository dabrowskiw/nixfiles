-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.opt.rtp:append (vim.fn.stdpath ('data') .. '/site')

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pylyzer" })
vim.wo.number = true
vim.wo.relativenumber = true


local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "black" }, }
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py" }

local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "flake8", filetypes = { "python" } } }

lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

lvim.builtin.which_key.mappings["M"] = {
  name = "Marp",
  T = {"<cmd>lua require('marp').toggle()<cr>", "Toggle Marp server"},
  S = {"<cmd>lua require('marp').status()<cr>", "Show Marp server status"},
  A = {"<cmd>lua require('marp').start()<cr>", "Start Marp server"},
  X = {"<cmd>lua require('marp').stop()<cr>", "Stop Marp server"},
}

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

lvim.builtin.which_key.mappings["m"] = {
  name = "LilyPond",
  c = {"<cmd>LilyCmp<cr>", "Compile to PDF"},
}

lvim.builtin.dap.active = true
pcall(function()
  require("dap-python").setup("python3")
end)

lvim.plugins = {
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-dap-python",
  "mpas/marp-nvim",
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  {
    "kaarmu/typst.vim",
    ft = 'typst',
    lazy = false
  },
  {
    "martineausimon/nvim-lilypond-suite",
    ft = { "lilypond", "tex", "texinfo" },
    config = function()
      require('nvls').setup()
    end
  },
  {
    "elentok/open-link.nvim",
    init = function()
      local expanders = require("open-link.expanders")
      require("open-link").setup({
        expanders = {
          -- expands "{user}/{repo}" to the github repo URL
          expanders.github,

          -- expands "format-on-save#15" the issue/pr #15 in the specified github project
          -- ("format-on-save" is the shortcut/keyword)
          expanders.github_issue_or_pr("format-on-save", "elentok/format-on-save.nvim"),

          -- expands "MYJIRA-1234" and "myotherjira-1234" to the specified Jira URL
          expanders.jira("https://myjira.atlassian.net/browse/", { "myjira", "myotherjira"})
        },
      })
    end,
    cmd = { "OpenLink", "PasteImage" },
    dependencies = {
      "ojroques/nvim-osc52",
    },
    keys = {
      {
        "ge",
        "<cmd>OpenLink<cr>",
        desc = "Open the link under the cursor"
      },
      {
        "<Leader>ip",
        "<cmd>PasteImage<cr>",
        desc = "Paste image from clipboard",
      },
    }
  }
}
