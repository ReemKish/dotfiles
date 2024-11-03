return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "arduino" } },
  },
  {
    "neovim/nvim-lspconfig",
    ft = "arduino",
    opts = {
      servers = {
        arduino_language_server = {
          cmd = {
            "arduino-language-server",
            "-cli-config",
            "~.arduino15/arduino-cli.yaml",
            "-cli",
            "~/.local/bin/arduino-cli",
            "-clangd",
            "/usr/bin/clangd",
            "-fqbn",
            "arduino:avr:uno",
          },
        },
      },
    },
  },
}
