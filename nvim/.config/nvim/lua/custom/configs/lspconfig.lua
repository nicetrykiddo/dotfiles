local config = require("plugins.configs.lspconfig")
local on_attach = config.on_attach
local on_init = config.on_init
local capabilities = config.capabilities
local merge = vim.tbl_deep_extend

local function mason_package_path(name)
  return vim.fn.stdpath "data" .. "/mason/packages/" .. name
end

local has_pwsh = vim.fn.executable "pwsh" == 1 or vim.fn.executable "powershell" == 1
local has_dotnet = vim.fn.executable "dotnet" == 1

local function root_dir_with_fallback(markers)
  return function(bufnr, on_dir)
    local path = vim.api.nvim_buf_get_name(bufnr)

    if path == "" then
      on_dir(nil)
      return
    end

    on_dir(vim.fs.root(path, markers) or vim.fs.dirname(path))
  end
end

local shared = {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

local servers = {
  lua_ls = {},
  pyright = {
    root_dir = root_dir_with_fallback {
      "pyrightconfig.json",
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      ".git",
    },
  },
  ruff = {
    root_dir = root_dir_with_fallback {
      "pyproject.toml",
      "ruff.toml",
      ".ruff.toml",
      ".git",
    },
  },
  tailwindcss = {},
  eslint = {},
  cssls = {},
  bashls = {
    root_dir = root_dir_with_fallback {
      ".git",
    },
  },
  gopls = {
    root_dir = root_dir_with_fallback {
      "go.work",
      "go.mod",
      ".git",
    },
  },
  rust_analyzer = {},
  yamlls = {},
  jsonls = {},
  html = {},
  dockerls = {},
  docker_compose_language_service = {},
  sqls = {
    root_dir = root_dir_with_fallback {
      ".sqls.yml",
      "sqls.yml",
      "config.yml",
      ".git",
    },
  },
  intelephense = {
    root_dir = root_dir_with_fallback {
      "composer.json",
      ".git",
    },
  },
  asm_lsp = {
    root_dir = root_dir_with_fallback {
      ".asm-lsp.toml",
      ".git",
    },
  },
}

if has_pwsh then
  servers.powershell_es = {
    bundle_path = mason_package_path "powershell-editor-services",
    shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
    root_dir = root_dir_with_fallback {
      "PSScriptAnalyzerSettings.psd1",
      ".git",
    },
  }
end

if has_dotnet and vim.fn.executable "OmniSharp" == 1 then
  servers.omnisharp = {
    cmd = { "OmniSharp" },
  }
end

for name, opts in pairs(servers) do
  vim.lsp.config(name, merge("force", shared, opts))
end

local function organize_imports()
  vim.lsp.buf.execute_command({
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  })
end

vim.api.nvim_create_user_command("OrganizeImports", organize_imports, {
  desc = "Organize Imports (ts_ls)",
})

vim.lsp.config("ts_ls", {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
})

vim.lsp.config("clangd", {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
  },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
})

local enabled = {
  "lua_ls",
  "pyright",
  "ruff",
  "tailwindcss",
  "eslint",
  "cssls",
  "bashls",
  "gopls",
  "rust_analyzer",
  "yamlls",
  "jsonls",
  "html",
  "dockerls",
  "docker_compose_language_service",
  "sqls",
  "intelephense",
  "asm_lsp",
  "ts_ls",
  "clangd",
}

if has_pwsh then
  table.insert(enabled, "powershell_es")
end

if has_dotnet and vim.fn.executable "OmniSharp" == 1 then
  table.insert(enabled, "omnisharp")
end

vim.lsp.enable(enabled)
