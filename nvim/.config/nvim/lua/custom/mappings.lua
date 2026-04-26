local M = {}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },    
    ["<C-v>"] = { '"+p', "paste from clipboard" },
    ["<C-a>"] = { "ggVG", "select all" },
    ["<C-c>"] = { '"+y', "copy to clipboard" },
    ["<C-x>"] = { '"+x', "cut to clipboard" },
    -- ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle file explorer" },
    -- ["<leader>f"] = { "<cmd> Telescope find_files <CR>", "find files" },
    -- ["<leader>g"] = { "<cmd> Telescope live_grep <CR>", "grep files" },
    -- ["<leader>r"] = { "<cmd> Telescope oldfiles <CR>", "recent files" },
    -- ["<leader>s"] = { "<cmd> Telescope grep_string <CR>", "search string under cursor" },
    -- ["<leader>t"] = { "<cmd> TroubleToggle <CR>", "toggle trouble" },
    -- ["<leader>h"] = { "<cmd> nohlsearch <CR>", "clear highlights" },
    -- ["<leader>m"] = { "<cmd> MarkdownPreviewToggle <CR>", "markdown preview" },
    -- ["<leader>p"] = { "<cmd> PackerSync <CR>", "sync plugins" },
    ["dd"] = { '"_dd', "delete line (no yank)" },
    ["xx"] = { 'dd', "cut line (yank+delete)" },
  },
  i = {
    ["<C-v>"] = { '<Esc>"+pa', "paste from clipboard" },
  },
  v = {
    ["<C-c>"] = { '"+y', "copy to clipboard" },
    ["d"] = { '"_d', "delete without yanking" },
    ["x"] = { 'd', "cut (delete + yank)" },
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Run or continue the debugger"
    },
    ["<leader>ds"] = {
      "<cmd> DapStepInto <CR>",
      "Step into function"
    },
    ["<leader>do"] = {
      "<cmd> DapStepOver <CR>",
      "Step over function"
    },
    ["<leader>du"] = {
      "<cmd> DapStepOut <CR>",
      "Step out of function"
    },
    ["<leader>dl"] = {
      "<cmd> DapRunLast <CR>",
      "Run last debugger session"
    },
    ["<leader>dt"] = {
      "<cmd> DapTerminate <CR>",
      "Terminate debugger session"
    },

  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end,
      "Run Python test"
    },
    ["<leader>dpR"] = {
      function()
        require('dap-python').test_class()
      end,
      "Run Python test class"
    },
    ["<leader>dpb"] = {
      function()
        require('dap-python').debug_selection()
      end,
      "Debug Python selection"
    },
    ["<leader>dpB"] = {
      function()
        require('dap-python').debug_selection(true)
      end,
      "Debug Python selection with console"
    },
  }
}

return M
