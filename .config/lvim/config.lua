lvim.log.level = "warn"
lvim.format_on_save = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
lvim.transparent_window = true
lvim.colorscheme = "tokyonight-night"
lvim.builtin.bufferline.options.indicator_icon = nil
lvim.builtin.bufferline.options.indicator = { style = "icon", icon = "▎" }
lvim.colorscheme = "onedarker"
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-f>"] = "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>"
lvim.keys.normal_mode["<leader>ft"] = "<cmd>lua require('telescope.builtin').treesitter()<cr>"
lvim.keys.normal_mode["<leader>nm"] = "<cmd>lua vim.lsp.buf.definition()<cr>"
lvim.keys.normal_mode["<leader>m"] = "<cmd>lua require('rust-tools').runnables.runnables()<cr>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "haskell",
  "elixir",
  "yaml",
  "comment",
  "latex",
  "fish"
}

lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.lualine.style = "lvim"


-- Make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "haskell-language-server",
  "pylint",
  "markdownlint",
  "firefox-debug-adapter",
  "rust-analyzer",
  "black",
  "chrome-debug-adapter",
  "clangd",
  "codelldb",
  "elixir-ls",
  "eslint_d",
  "flake8",
  "isort",
  "json-lsp",
  "lua-language-server",
  "mypy",
  "prettierd",
  "pyright",
  "stylua",
  "tailwindcss-language-server",
  "taplo",
  "texlab",
  "typescript-language-server",
  "vim-language-server",
  "yaml-language-server"
}


-- Additional Plugins
lvim.plugins = {
  { "simrat39/rust-tools.nvim" },
  { "xuhdev/vim-latex-live-preview" },
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  },
}

local rt = require("rust-tools")

rt.setup({
  tools = { -- rust-tools options
    autoSetHints = true,
    executor = require("rust-tools/executors").termopen,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
      }
    },
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<C-a>", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

require("lvim.lsp.null-ls.formatters").setup({
  {
    command = "prettierd",
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "css",
      "scss",
      "less",
      "html",
      "vue",
      "json",
      "jsonc",
      "graphql",
      "yaml"
    }
  },
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
})

local null_linters = require("lvim.lsp.null-ls.linters")

local util = require('lspconfig/util')

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(path.join(workspace, 'Pipfile'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('PIPENV_PIPFILE=' .. match .. ' pipenv --venv'))
    return path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

require 'lspconfig'.pyright.setup {
  on_attach = function()
    require 'lsp_signature'.on_attach {
      hint_enable = false,
    }
  end,
  on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end
}



null_linters.setup({
  { command = "flake8", filetypes = { "python" } },
  {
    command = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue", "svelte" }
  },
})

vim.api.nvim_create_autocmd("CursorHold", {
  -- buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("BufEnter,BufNewFile", {
  pattern = { ".aliasrc", ".pathrc", ".zshrc" },
  command = "setfiletype bash"
})
