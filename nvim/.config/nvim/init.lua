-- Set <Leader> key to ,
vim.g.mapleader = " "

-- Some basic options
vim.cmd("syntax off")

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

    -- Remove status and tab line
    laststatus = 0,
    showtabline = 0,
    -- Show commands in the status bar
    showcmd = true,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

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

vim.cmd([[
" Map <Leader>e to <C-\><C-n>
tnoremap <Leader>e <C-\><C-n>
" Map <Leader>t to open a terminal in a new tab in normal mode
nnoremap <silent> <Leader>t :tabedit term://bash<CR>
" Insert the date at curser position
nnoremap <Leader>n i<C-R>=strftime("%Y-%m-%d (%s)")<CR><Esc><CR>
]])

-- Color options
-- Set `~` and line numbers to white
vim.api.nvim_set_hl(0, "NonText", { ctermfg = "White" })
vim.api.nvim_set_hl(0, "LineNr", { ctermfg = "White" })

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
file_autocmd("*.cl", "set filetype=c")

-- Set spell for markdown files and git commit messafes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "markdown" },
    command = "set spell",
})

-- Disable number for terminal
vim.api.nvim_create_autocmd("TermOpen", {
    command = "setlocal nonumber",
})

vim.cmd([[
" This function will toggle between two color schemes. The first is a simple
" black and white one and the other is NeoSolarized for programming.
" If color scheme name is 'default' switch to NeoSolarized, else switch to
" black and white.
function ToggleColorScheme()
    let color_scheme = get(g:, 'colors_name', 'default')
    if color_scheme == 'default'
        syntax on
        set termguicolors
        set background=dark
        colorscheme NeoSolarized
        set cursorline
    else
        syntax off
        set notermguicolors
        set nocursorline
        colorscheme default
        highlight NonText ctermfg=White
        highlight LineNr ctermfg=White
    endif
endfunction
" Bind `ToggleColorScheme()` function to <Leader>s
nnoremap <silent> <Leader>s :call ToggleColorScheme()<CR>
]])
