function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

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
vim.opt.cursorline = false

vim.opt.background = 'light'
vim.cmd('syntax on')
-- vim.cmd(':hi CursorLine cterm=NONE ctermbg=lightgrey')

require('packer').startup(function(use)
  use 'preservim/nerdtree'
  use 'ctrlpvim/ctrlp.vim'
  use 'mileszs/ack.vim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig'
  use({
    'olimorris/onedarkpro.nvim',
    config = function()
      --require("onedark").setup()
      vim.cmd('colorscheme onelight')
    end
  })
  use 'ziglang/zig.vim'
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

vim.api.nvim_create_autocmd({ "FileType go" }, {
  command = "setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab",
})

vim.opt.runtimepath:append("/home/cduez/.config/nvim/parsers")
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby", "lua" },
  sync_install = false,
  auto_install = true,
  parser_install_dir = "/home/cduez/.config/nvim/parsers",

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- require'lspconfig'.solargraph.setup{}
-- require'lspconfig'.zls.setup{
--   on_attach = on_attach,
--   flags = lsp_flags,
--}
