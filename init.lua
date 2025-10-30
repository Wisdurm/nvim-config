-- Tabs (tabulation) --
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.softtabstop=0
vim.o.noexpandtab=true
-- Tabs (workspaces) --
vim.api.nvim_set_keymap("n", "<F6>",":tabp<CR>",{})
vim.api.nvim_set_keymap("n", "<F7>",":tabn<CR>",{})
