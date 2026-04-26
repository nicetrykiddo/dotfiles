-- Keep stowed dotfiles on the same filetype paths as their live config targets.
vim.filetype.add {
  filename = {
    ["compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["Containerfile"] = "dockerfile",
  },
  pattern = {
    [".*/%.config/i3/config"] = "i3config",
    [".*/%.config/kitty/kitty%.conf"] = "kitty",
    [".*/%.config/rofi/.*%.rasi"] = "rasi",
    [".*/%.etc/udev/rules%.d/.*%.rules"] = "udevrules",
    [".*/Dockerfile%..*"] = "dockerfile",
  },
}
