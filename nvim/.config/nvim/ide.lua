-- Plugins
require('plugins')

vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  local bind = vim.keymap.set

  bind('n', 'K', '<C-u>', opts)
  bind('n', 'H', vim.lsp.buf.hover, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = false,
  severity_sort = false,
  float = true,
})

-- Set <Leader> key to ,
vim.g.mapleader = " "

-- Some basic options

local options = {
    number = true,
    guicursor = "",
    scrolloff = 1,
    sidescroll = 1,
    sidescrolloff = 3,
    fileencoding = "utf-8",

    -- Convert tabs to four spaces
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smarttab = true,
    autoindent = true,

    -- Remove tab line
    showtabline = 0,
    -- Show commands in the status bar
    showcmd = true,

    -- For the color scheme
    termguicolors = true,
    background = "dark",
    cursorline = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd("colorscheme NeoSolarized")

-- Map keys
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map jj to <Esc> in insert mode
map("i", "jj", "<Esc>")
-- Map r to redo command in normal mode
map("n", "r", "<C-r>")

-- Map `J` and `K` keys to move faster
map("n", "J", "<C-d>")
map("n", "K", "<C-u>")

-- Remap `j` and `k` to `gj` and `gk`
map("n", "j", "gj")
map("n", "k", "gk")

-- Keybindings to show LSP diagnostic messages
map("n", "<Leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "<Leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<Leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")

vim.cmd([[
" Map <Leader>e to <C-\><C-n>
tnoremap <Leader>e <C-\><C-n>
" Map <Leader>t to open a terminal in a new tab in normal mode
nnoremap <silent> <Leader>t :tabedit term://bash<CR>
" Insert the date at curser position
nnoremap <Leader>n i<C-R>=strftime("%Y-%m-%d (%s)")<CR><Esc>
]])

-- Auto commands

-- Helper function to set commands for file patterns
local function file_autocmd(file_type, cmd)
    vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
          pattern = { file_type },
          command = cmd,
    })
end

file_autocmd("*.go", "set noexpandtab")
file_autocmd("*.txt", "set wrap")
file_autocmd("*.diary", "set wrap spell")
file_autocmd("*.html", "set tabstop=2 softtabstop=2 shiftwidth=2")
file_autocmd("*.js", "set tabstop=2 softtabstop=2 shiftwidth=2")

-- Set spell for markdown files and git commit messafes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "markdown" },
    command = "set spell",
})

-- Disable number for terminal
vim.api.nvim_create_autocmd("TermOpen", {
    command = "setlocal nonumber",
})

-- Setup cmp
local cmp = require('cmp')

cmp.setup({
  completion = {
    autocomplete = false
  },
  mapping = {
    -- Invoke completion menu manually using Ctrl + Space
    ['<C-Space>'] = cmp.mapping.complete(),
    -- Use Enter to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),
  }
})

-- `clangd` is already installed in `$PATH`
require("lspconfig").clangd.setup{ cmd = {"clangd"}; ... }
