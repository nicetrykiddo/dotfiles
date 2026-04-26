local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local has_dotnet = vim.fn.executable "dotnet" == 1
local has_php = vim.fn.executable "php" == 1
local extras = {
  rustfmt = require "none-ls.formatting.rustfmt",
  yamllint = require "none-ls.diagnostics.yamllint",
}

local opts = {
  debug = false,
  sources = {
    formatting.prettierd.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "jsonc",
        "markdown",
        "markdown.mdx",
        "graphql",
        "handlebars",
        "svelte",
        "astro",
        "htmlangular",
      },
    }),
    formatting.black,
    formatting.shfmt,
    formatting.goimports,
    extras.rustfmt,
    formatting.yamlfmt,
    formatting.sqruff,
    formatting.asmfmt,
    diagnostics.mypy.with({
      extra_args = function()
        local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
        return { "--python-executable", virtual .. "/bin/python3" }
      end,
    }),
    diagnostics.golangci_lint,
    diagnostics.hadolint,
    diagnostics.sqruff,
    extras.yamllint,
  },
  on_attach = function(client, bufnr)
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(current_client)
              return current_client.name == client.name
            end,
          })
        end,
      })
    end
  end,
}

if has_php then
  table.insert(opts.sources, formatting.phpcbf)
  table.insert(opts.sources, diagnostics.phpcs)
end

if has_dotnet and vim.fn.executable "csharpier" == 1 then
  table.insert(opts.sources, formatting.csharpier)
end

return opts
