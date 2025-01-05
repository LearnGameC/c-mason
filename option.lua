local opt = vim.opt -- for conciseness
vim.opt.laststatus = 3 --[[ -- window status line: 0: never 1: only if there are at least two windows 2: always 3: always and ONLY the last window ]]
vim.opt.ruler = true --[[ -- Show the line and column number of the cursor position ]]
-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wildmenu = true

vim.opt.wildoptions = "pum"
vim.opt.wildmode = "longest:full,full"

local option1 = {
  autoread = true,               -- required to keep multiple buffers and open multiple buffers
  autowrite = true,              -- required to keep multiple buffers and open multiple buffers
  backup = false,                -- creates a backup file
  backspace = "start,eol,indent", -- allow backspace on indent, end of line or insert mode start position
  conceallevel = 0,              -- so that `` is visible in markdown files
  fileencoding = "utf-8",        -- the encoding written to a file
  hidden = true,                 -- required to keep multiple buffers and open multiple buffers
  mouse = "a",                   -- allow the mouse to be used in neovim

  -- popu
  -- pumheight = 40, -- pop up menu height
  -- winblend = 0, -- Enables pseudo-transparency for a floating window
  -- pumblend = 0, -- tpseudo-transparency for the |popup-menu|

  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  smarttab = true,  -- make smarttab smarter again
  -- windows
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  -- list = true,
  -- title = true,

}
local option2 = {
  -- timeout =false, -- time to wait for a mapped sequence to complete (in milliseconds)
  -- timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 100,   -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  --[[ tabs & indentation ]]
  autoindent = true,  -- convert tabs to spaces
  expandtab = true,   -- convert tabs to spaces
  shiftwidth = 2,     -- the number of spaces inserted for each indentation
  tabstop = 2,        -- insert 2 spaces for a tab
  smartindent = true, -- make indenting smarter again
  linebreak = true,
  showbreak = string.rep(" ", 3),

  -- cursor
  -- mousemoveevent = true, -- mouse move events
  cursorline = true,    -- highlight the current line
  numberwidth = 1,      -- Minimal number of columns to use for the line number
  number = true,        -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  signcolumn = "yes",   -- always show the sign column, otherwise it would shift the text each time
  -- Movement
  scrolloff = 5,        -- Minimal number of screen lines to keep above and below the cursor
  -- whichwrap = vim.o.whichwrap .. "<,>,h,l",

}
local option3 = {
  -- fold
  foldmethod = "expr",  -- Gấp dựa trên Tree-sitter (được triển khai trong chính Neovim, xem :h vim.treesitter.foldexpr()). Để bật nó cho cửa sổ hiện tại, hãy đặt
  foldexpr = "nvim_treesitter#foldexpr()",
  foldenable = false,   -- all folds are open
  -- foldcolumn = "1", --'0' is not bad, Folds level will be closed
  foldlevel = 99,       -- Folds level will be closed
  foldlevelstart = 99,
  -- foldminlines = 0, -- number lines fold close

  -- Editing
  modelines = 1,
  breakindent = true, -- continue visually indented
  showmatch = true,
  swapfile = true,   -- creates a swapfile
  -- undodir = fn.stdpath("data") .. "/undodir", -- List of directory names for undo files
  undofile = true,   -- enable persistent undo
  wrap = false,      -- display lines as one long line
  inccommand = "split",
  diffopt = {
    "internal",
    "filler",
    "closeoff",
    "hiddenoff",
    "algorithm:minimal",
  },

  clipboard = "unnamedplus", -- use system clipboard as default register
  syntax = "on", --[[ enable syntax highlighting ]]
  autowriteall = true, --[[ autosave ]]
  spell = false,

  -- Shada
  shada = "!,'1000,f1,<1000,s100,:1000,/1000,h",
  sidescrolloff = 8,   -- minimal number of screen columns
  termguicolors = true, -- Enables 24-bit RGB color in the TUI
  fillchars = {
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vert = "┃",
    vertleft = "┨",
    vertright = "┣",
    verthoriz = "╋",
    eob = " ",
    fold = "·",
    foldopen = "",
    foldsep = "│",
    foldclose = "",
    lastline = " ",
  }, -- make EndOfBuffer invisible
  cmdheight = 0,
  -- shell = vim.fn.executable "pwsh" and "pwsh" or "powershell",
  -- shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
  -- shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
  -- shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
  -- shellquote = "",
  -- shellxquote = "",
}
-- vim.opt.spelllang:append "cjk" -- disable spellchecking for asian characters (VIM algorithm does not support it)
-- vim.opt.shortmess:append "c" -- don't show redundant messages from ins-completion-menu
-- vim.opt.shortmess:append "I" -- don't show the default intro message
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.winbar = "%=%m %f"

-- vim.opt.listchars:append "eol:↴"

opt.formatoptions = "jn" -- tcqj automatic formatting See |fo-table| for possible values
vim.opt.iskeyword:append("-")
-- tabs & indentation
-- opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
-- opt.shiftwidth = 2 -- 2 spaces for indent width
-- opt.expandtab = true -- expand tab to spaces
-- opt.autoindent = true -- copy indent from current line when starting new one
-- opt.cindent = true -- copy indent from current line when starting new one

-- if vim.b.win_separator then
-- 	options = vim.list_extend(options, {
-- 		"fillchars+=horiz:\\━",
-- 		"fillchars+=horizup:\\┻",
-- 		"fillchars+=horizdown:\\┳",
-- 		"fillchars+=vert:\\┃",
-- 		"fillchars+=vertleft:\\┫",
-- 		"fillchars+=vertright:\\┣",
-- 		"fillchars+=verthoriz:\\╋",
-- 	})
-- else
-- 	options = vim.list_extend(options, {
-- 		"fillchars+=horiz:\\ ",
-- 		"fillchars+=horizup:\\ ",
-- 		"fillchars+=horizdown:\\ ",
-- 		"fillchars+=vert:\\ ",
-- 		"fillchars+=vertleft:\\ ",
-- 		"fillchars+=vertright:\\ ",
-- 		"fillchars+=verthoriz:\\ ",
-- 	})
-- end

for name, value in pairs(option1) do
  vim.opt[name] = value
end
for name, value in pairs(option2) do
  vim.opt[name] = value
end
for name, value in pairs(option3) do
  vim.opt[name] = value
end

-- for i, option in pairs(options) do
-- 	vim.cmd("set " .. option)
-- end
