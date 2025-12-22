-- ************************************
-- *  Actual vim/neovim config stuff  *
-- ************************************
-- Line numbers
vim.o.number = true
-- Univeral mapping
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Color
vim.cmd('colorscheme slate')
vim.cmd('hi Comment guifg=#44a832')
-- Scroll thing
vim.opt.scrolloff = 8
-- Faster movement
vim.keymap.set("n", "<C-J>", "10j")
vim.keymap.set("n", "<C-K>", "10k")
-- Folds
vim.o.foldlevel=2
-- Tabs (tabulation)
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.softtabstop=0
vim.o.expandtab=false
-- Hightlinting
vim.keymap.set("n", "<leader>n", ":noh<CR>") -- Clear highlight
-- Rename symbol (ycm)
vim.keymap.set("n", "<leader>rn", ":YcmCompleter RefactorRename ")
-- Tabs (workspaces)
vim.keymap.set("n", "<C-H>",":tabp<CR>") -- CTRL-H to left tab
vim.keymap.set("n", "<C-L>",":tabn<CR>") -- CTRL-L to right tab
vim.keymap.set("n", "mth",":tabm -1<CR>") -- CTRL-L to move tab left
vim.keymap.set("n", "mtl",":tabm +1<CR>") -- CTRL-L to move tab right
vim.keymap.set("n", "tt", ":tabnew|:terminal<CR>") -- Opens terminal tab
vim.keymap.set("n", "<leader>m", ":tabm ") -- Opens terminal tab
-- Quick tab switching
vim.keymap.set("n", "<leader>1", "1gt")
vim.keymap.set("n", "<leader>2", "2gt")
vim.keymap.set("n", "<leader>3", "3gt")
vim.keymap.set("n", "<leader>4", "4gt")
vim.keymap.set("n", "<leader>5", "5gt")
vim.keymap.set("n", "<leader>6", "6gt")
vim.keymap.set("n", "<leader>7", "7gt")
vim.keymap.set("n", "<leader>8", "8gt")
vim.keymap.set("n", "<leader>9", "9gt")
--for some reason :tab ter doesn't work on my laptop
-- Exit terminal mode
vim.keymap.set('t', '<Esc>', "<C-\\><C-n><C-w>h",{silent = true}) -- Esc to escape terminal mode
-- The classics
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move text up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move text down
vim.keymap.set("n", "sex", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Replace all instances of selected word
-- Custom stuff
vim.keymap.set("n", "<leader>sex", ':%s/<C-R>0//g<Left><Left>') -- Replace yanked text
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
Plug 'tpope/vim-commentary' -- Code commenting
Plug 'nvim-lualine/lualine.nvim' -- Status bar 
Plug 'nvim-tree/nvim-web-devicons' -- Status bar icons
Plug 'jbyuki/instant.nvim' -- Multiplayer (doesn't work)
Plug 'xiyaowong/transparent.nvim' -- Transparent background
Plug 'sakhnik/nvim-gdb' -- Gdb integration
-- Telescope
Plug 'nvim-telescope/telescope.nvim' -- find files
-- Battery plugins and dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'justinhj/battery.nvim'
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
vim.opt.termguicolors = true
require("nvim-tree").setup({
  git = {
        enable = true,
    },
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
        show = {
            git = true,
            },
        },
  },
  filters = {
    dotfiles = false,
  },
})
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
-- *******************
-- *     battery     *
-- *******************
local battery = require("battery")
battery.setup({
    update_rate_seconds = 30,           -- Number of seconds between checking battery status
    show_status_when_no_battery = true, -- Don't show any icon or text when no battery found (desktop for example)
    show_plugged_icon = true,           -- If true show a cable icon alongside the battery icon when plugged in
    show_unplugged_icon = true,         -- When true show a diconnected cable icon when not plugged in
    show_percent = true,                -- Whether or not to show the percent charge remaining in digits
    vertical_icons = true,              -- When true icons are vertical, otherwise shows horizontal battery icon
    multiple_battery_selection = 1,     -- Which battery to choose when multiple found. "max" or "maximum", "min" or "minimum" or a number to pick the nth battery found (currently linux acpi only)
})
-- Lualine function
local nvimbattery = {
  function()
    return require("battery").get_status_line()
  end,
  --color = { fg = colors.violet, bg = colors.bg },
}
-- *******************
-- *      lualine    *
-- *******************
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'ayu_dark', -- Cant see shit with the auto colorscheme
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode', nvimbattery},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
-- *******************
-- *   multiplayer   *
-- *******************
vim.g.instant_username = "wisdurm"
-- *******************
-- *    telescope    *
-- *******************
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
