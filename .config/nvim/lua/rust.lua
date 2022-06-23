require('rust-tools').setup({
  tools = { -- rust-tools options
    autoSetHints = true,
    executor = require("rust-tools/executors").termopen,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    -- on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
      }
    }
  },
})
