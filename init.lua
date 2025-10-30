-- Tabs (tabulation)
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.softtabstop=0
vim.o.expandtab=false
-- Tabs (workspaces)
vim.api.nvim_set_keymap("n", "<F6>",":tabp<CR>",{})
vim.api.nvim_set_keymap("n", "<F7>",":tabn<CR>",{})
-- The classics
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move text up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move text down
vim.keymap.set("n", "sex", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Replace all instances of selected word
-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlights text when yanking",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Plugins or whatever
