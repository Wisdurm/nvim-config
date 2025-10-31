-- ************************************
-- *  Actual vim/neovim config stuff  *
-- ************************************
-- Tabs (tabulation)
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.softtabstop=0
vim.o.expandtab=false
-- Tabs (workspaces)
vim.keymap.set("n", "<C-H>",":tabp<CR>") -- CTRL-H to left tab
vim.keymap.set("n", "<C-L>",":tabn<CR>") -- CTRL-L to right tab
vim.keymap.set("n", "mth",":tabm -1<CR>") -- CTRL-L to move tab left
vim.keymap.set("n", "mtl",":tabm +1<CR>") -- CTRL-L to move tab right
-- Exit terminal mode
vim.keymap.set('t', '<Esc>', "<C-\\><C-n><C-w>h",{silent = true}) -- Esc to escape terminal mode
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
-- ************************************
-- * Plugins or whatever ( vim-plug ) *
-- ************************************
local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- Plugins
Plug 'nvim-tree/nvim-tree.lua' -- File tree
Plug 'ycm-core/YouCompleteMe' -- Code completion ( requires a bunch of extra setup hggghhnn..."
Plug 'SirVer/ultisnips' -- Code snippets (engine)
Plug 'honza/vim-snippets' -- Code snippets (code snippets)
-- End plugin
vim.call('plug#end')
-- ************************************
-- *          Plugins config          *
-- ************************************

-- *************
-- * nvim-tree *
-- *************
-- disable newrw because nvim-tree said so :DDDD
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Default setup for now
require("nvim-tree").setup()
-- *************
-- * ultisnips *
-- *************
vim.g.UltiSnipsExpandTrigger = "go"
