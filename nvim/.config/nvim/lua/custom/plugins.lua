local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",
    opts = {},
    keys = {
      {"<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "x"}, desc = "Add cursor and move down"},
      {"<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "x"}, desc = "Add cursor and move up"},
      {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move up"},
      {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move down"},
      {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}, desc = "Add or remove cursor"},
      {"<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = {"n", "x"}, desc = "Add cursors to cword"},
      {"<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = {"n", "x"}, desc = "Add cursors to cword in previous area"},
      {"<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Add cursor and jump to next cword"},
      {"<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Jump to next cword"},
      {"<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = {"n", "x"}, desc = "Lock virtual cursors"},
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require "custom.configs.dap"
      require("core.utils").load_mappings("dap")
    end
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.none-ls"
    end,
    dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "js-debug-adapter",
        "prettierd",
        "black",
        "debugpy",
        "mypy",
        "ruff",
        "pyright",
        "typescript-language-server",
        "tailwindcss-language-server",
        "clangd",
        "codelldb",
        "bash-language-server",
        "shellcheck",
        "shfmt",
        "powershell-editor-services",
        "gopls",
        "goimports",
        "golangci-lint",
        "delve",
        "rust-analyzer",
        "yaml-language-server",
        "yamllint",
        "yamlfmt",
        "json-lsp",
        "html-lsp",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "sqls",
        "sqruff",
        "intelephense",
        "asm-lsp",
        "asmfmt",
        "omnisharp",
        "netcoredbg",
        "phpcs",
        "phpcbf",
        "hadolint",
      }
    }
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
     require "custom.configs.lspconfig"
    end,
  },

  { "nvim-neotest/nvim-nio" },

  {
    "windwp/nvim-ts-autotag",
    ft = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    opts = function()
      local opts = require "plugins.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "css",
        "html",
        "json",
        "jsonc",
        "yaml",
        "dockerfile",
        "sql",
        "php",
        "powershell",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "rust",
        "gitignore",
        "git_config",
        "toml",
        "markdown",
        "markdown_inline",
        "diff",
        "query",
        "regex",
        "rasi",
        "ssh_config",
        "tmux",
        "hyprlang",
        "c_sharp",
        "c",
        "cpp",
        "asm",
      }
      return opts
    end,
  },

}

return plugins
