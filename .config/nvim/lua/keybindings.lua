local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

nmap("<C-n>", "<cmd>NERDTree<CR>")
nmap("<leader>n", "<cmd>NERDTreeFocus<CR>")
nmap("<C-t>", "<cmd>NERDTreeToggle<CR>")
nmap("<C-m>", "<cmd>CratesUp<CR>")
nmap("<C-l>", "<cmd>FZF<CR>")
