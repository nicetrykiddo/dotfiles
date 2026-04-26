local parser_install_dir = vim.fn.stdpath "data" .. "/site"

if not vim.tbl_contains(vim.opt.runtimepath:get(), parser_install_dir) then
  vim.opt.runtimepath:prepend(parser_install_dir)
end

local options = {
  ensure_installed = { "lua", "vim", "vimdoc" },
  sync_install = false,
  auto_install = false,
  parser_install_dir = parser_install_dir,
  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },

  indent = { enable = true },
}

return options
