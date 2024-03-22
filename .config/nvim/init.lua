-- Install Lazy.vim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	'stephpy/vim-yaml',
	'hashivim/vim-terraform',
	'yorinasub17/vim-terragrunt',
	'martinda/Jenkinsfile-vim-syntax',
	'nvim-treesitter/nvim-treesitter',
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	'github/copilot.vim',
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		},
	}
})

-- Enable syntax highlighting
vim.cmd('syntax on')
vim.cmd('syntax sync fromstart')
vim.cmd('syntax sync minlines=1000')

-- Enable relative line numbers
vim.opt.rnu = true

-- Set clipboard to use unnamedplus
vim.opt.clipboard = 'unnamedplus'

-- Set indent settings
vim.opt.expandtab = true
vim.opt.ai = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Highlight search results
vim.opt.hlsearch = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set backspace behavior
vim.opt.backspace = 'indent,eol,start'

-- Set list characters
vim.opt.list = true
vim.opt.listchars:append({ nbsp = '¬', tab = '»·', trail = '·', extends = '>', precedes = '<' })

-- Set showbreak character
vim.opt.showbreak = '↳'

-- Enable line wrapping
vim.opt.wrap = true

-- Enable mouse support
vim.opt.mouse = 'a'

-- Set file type specific settings
vim.cmd('autocmd BufNewFile,BufRead *.yml.j2,*.yaml.j2 set syntax=yaml')
vim.cmd('autocmd BufNewFile,BufRead *.tf.j2,*.tfvars.j2,*.hcl.j2 set syntax=terraform')

-- Set encoding
vim.opt.encoding = 'utf-8'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd('colorscheme dunno')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')

-- Disable statusline
vim.opt.laststatus = 0

-- Set completion options
-- vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.wildmode = "longest,list,full"
vim.opt.wildmenu = true

-- ALE configuration
vim.g.ale_sign_column_alwayus = 1

