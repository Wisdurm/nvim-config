-- ************************************
-- *  Actual vim/neovim config stuff  *
-- ************************************
-- Color
vim.cmd('colorscheme slate')
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
Plug 'nvim-treesitter/nvim-treesitter' -- Syntax highlighting
-- End plugin
vim.call('plug#end')
-- ************************************
-- *          Plugins config          *
-- ************************************
--
-- *************
-- * nvim-tree *
-- *************
-- disable newrw because nvim-tree said so :DDDD
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.keymap.set("n", "tre", ":NvimTreeToggle<CR>") -- Move text up
-- Default setup for now
require("nvim-tree").setup()
-- *************
-- * ultisnips *
-- *************
vim.g.UltiSnipsExpandTrigger = "go" -- Type "go" to complete snippet
-- *******************
-- * nvim-treesitter *
-- *******************
-- Folding or something lol idk :shrug:
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "cpp", "php", "html", "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
