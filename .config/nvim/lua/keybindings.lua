local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

nmap("<leader>n", "<cmd>NERDTreeFocus<CR>")
nmap("<leader>p", "<cmd>NERDTreeToggle<CR>")
nmap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nmap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nmap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
nmap("<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
nmap("<leader>fs", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
nmap("<leader>ft", "<cmd>lua require('telescope.builtin').treesitter()<cr>")
