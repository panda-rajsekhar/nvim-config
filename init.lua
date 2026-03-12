-- ===========================================================================
-- NEOVIM BASIC CONFIGURATION
-- ============================================================================
-- This configuration sets up fundamental Neovim options for a better
-- editing experience. Each section is commented for clarity.

-- ----------------------------------------------------------------------------
-- Leader Key Configuration
-- ----------------------------------------------------------------------------
-- Set the leader key to space for easier access to custom mappings
-- Must be set before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ----------------------------------------------------------------------------
-- General Options
-- ----------------------------------------------------------------------------
local opt = vim.opt

-- Line numbers
opt.number = true          -- Show absolute line numbers


-- Tabs and indentation
opt.tabstop = 4           -- Number of spaces a tab counts for
opt.shiftwidth = 4        -- Number of spaces for auto-indent
opt.expandtab = true      -- Convert tabs to spaces
opt.autoindent = true     -- Copy indent from current line when starting new line
opt.smartindent = true    -- Smart auto-indenting for C-like programs

-- Search settings
opt.ignorecase = true     -- Ignore case in search patterns
opt.smartcase = true      -- Override ignorecase if pattern has uppercase
opt.hlsearch = true       -- Highlight all search matches
opt.incsearch = true      -- Show matches as you type

-- Visual settings
opt.termguicolors = true  -- Enable 24-bit RGB colors in the terminal
opt.signcolumn = "yes"    -- Always show the sign column (for git signs, diagnostics)
opt.cursorline = true     -- Highlight the current line
opt.scrolloff = 8         -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 8     -- Keep 8 columns visible left/right of cursor
opt.wrap = false          -- Don't wrap long lines


-- Window splitting
opt.splitright = true     -- Open vertical splits to the right
opt.splitbelow = true     -- Open horizontal splits below

-- File handling
opt.swapfile = false      -- Don't create swap files
opt.backup = false        -- Don't create backup files
opt.undofile = true       -- Enable persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undodir"  -- Set undo directory

-- Clipboard
opt.clipboard = "unnamedplus"  -- Use system clipboard

-- Performance
opt.updatetime = 250      -- Faster completion and diagnostics
opt.timeoutlen = 300      -- Time to wait for mapped sequence to complete

-- Appearance
opt.showmode = false      -- Don't show mode (shown in statusline)
opt.pumheight = 10        -- Maximum number of items in popup menu
opt.cmdheight = 1         -- Height of command line

-- Mouse support
opt.mouse = "a"           -- Enable mouse in all modes

-- ----------------------------------------------------------------------------
-- Basic Keymaps
-- ----------------------------------------------------------------------------
local keymap = vim.keymap.set

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Better line movement in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep search terms centered
keymap("n", "n", "nzzzv", { desc = "Next search result centered" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Clear search highlighting
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better paste (don't overwrite register)
keymap("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- Quick save and quit
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Buffer navigation
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })


-- ============================================================================
-- PLUGIN MANAGER: lazy.nvim
-- ============================================================================
-- Bootstrap lazy.nvim - automatically install if not present

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is installed, if not, clone it
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",  -- Use latest stable release
        lazypath,
    })
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and configure plugins


-- ============================================================================
-- PLUGINS CONFIGURATION
-- ============================================================================

require("lazy").setup({
    -- ------------------------------------------------------------------------
    -- Colorscheme: Tokyo Night
    -- ------------------------------------------------------------------------
    {
        "folke/tokyonight.nvim",
        lazy = false,       -- Load immediately (not lazy)
        priority = 1000,    -- Load before other plugins
        config = function()
            require("tokyonight").setup({
                style = "night",        -- Options: storm, moon, night, day
                transparent = false,    -- Disable transparent background
                terminal_colors = true, -- Configure terminal colors
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                },
            })
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- ------------------------------------------------------------------------
    -- Telescope: Fuzzy Finder
    -- ------------------------------------------------------------------------
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- Required dependency
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",        -- Build the C extension for better performance
            },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    -- Default mappings inside Telescope
                    mappings = {
                        i = {  -- Insert mode mappings
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        },
                    },
                    -- Ignore patterns
                    file_ignore_patterns = {
                        "node_modules",
                        ".git/",
                        "dist/",
                        "build/",
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,  -- Show hidden files
                    },
                },
            })

            -- Load fzf extension for better sorting
            telescope.load_extension("fzf")

            -- Telescope keymaps
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
            vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Git commits" })
            vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Git status" })
        end,
    },

    -- ------------------------------------------------------------------------
-- Treesitter: Syntax Highlighting and Code Understanding
-- ------------------------------------------------------------------------
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-treesitter.config").setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "javascript",
                "typescript",
                "python",
                "rust",
                "go",
                "c",
                "cpp",
                "json",
                "yaml",
                "toml",
                "html",
                "css",
                "markdown",
                "markdown_inline",
                "bash",
                "dockerfile",
            },

            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true,
            },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                },
            },
        })
    end,
},





   

    -- Continue with more plugins...
})


