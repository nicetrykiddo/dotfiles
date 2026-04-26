local dap = require("dap")

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "js-debug-adapter",
  }
}

for _, language in ipairs { "typescript", "javascript" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
    },
  }
end

dap.adapters["codelldb"] = {
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}

for _, language in ipairs { "c", "cpp", "rust" } do
  dap.configurations[language] = {
    {
      type = "codelldb",
      request = "launch",
      name = "Launch executable",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end

dap.adapters["delve"] = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug file",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

if vim.fn.executable "netcoredbg" == 1 then
  dap.adapters["coreclr"] = {
    type = "executable",
    command = "netcoredbg",
    args = { "--interpreter=vscode" },
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "Launch DLL",
      request = "launch",
      program = function()
        return vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
  }
end
