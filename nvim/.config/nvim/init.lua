function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- vim.cmd('source ~/.config/nvim/old_config.vim')

local indent = 2
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignore:append('*/tmp/*,*.so,*.swp,*.zip')
vim.opt.cursorline = true

vim.opt.background = 'light'
vim.cmd('syntax on')
vim.cmd(':hi CursorLine cterm=NONE ctermbg=lightgrey')

require('packer').startup(function(use)
  use 'preservim/nerdtree'
  use 'ctrlpvim/ctrlp.vim'
  use 'mileszs/ack.vim'
end)

map('n', '<F5>', ':NERDTreeToggle<CR>')
map('i', '<F5>', '<ESC>:NERDTreeToggle<CR>')
map('n', '<c-e>', ':b#<CR>')

map('', '<C-o>', ':tabprev<CR>')
map('', '<C-p>', ':tabnext<CR>')
map('', '<C-t>', ':tabnew<CR>')
map('', '<C-d>', ':tabclose<CR>')

vim.g.ctrlp_working_path_mode = 'w'
vim.g.ctrlp_map = '<c-f>'
vim.g.ctrlp_cmd = 'CtrlPMixed'
vim.g.ctrlp_user_command = 'rg %s --files --color=never --glob=""'
vim.g.ackprg = 'rg --vimgrep'

vim.cmd.cnoreabbrev({ "<buffer>", "rg", "Ack", })
vim.cmd.cnoreabbrev({ "<buffer>", "rgs", "AckFromSearch", })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})


