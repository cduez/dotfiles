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
vim.opt.cursorline = true

vim.opt.background = 'light'
vim.cmd('syntax on')
vim.cmd(':hi CursorLine cterm=NONE ctermbg=lightgrey')

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'preservim/nerdtree'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig'
  use({
    --"loctvl842/monokai-pro.nvim",
    "sainnhe/sonokai",
    config = function()
      require("sonokai").setup()
   --   vim.cmd('colorscheme onelight')
    end
  })
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  -- use 'sainnhe/edge'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)

vim.cmd.colorscheme "sonokai"
vim.cmd("hi Normal guibg=#272822")

map('n', '<F5>', ':NERDTreeToggle<CR>')
map('i', '<F5>', '<ESC>:NERDTreeToggle<CR>')
map('n', '<c-e>', ':b#<CR>')
map('n', '<c-j>', ':bprev<CR>')
map('n', '<c-k>', ':bnext<CR>')

map('', '<C-o>', ':tabprev<CR>')
map('', '<C-p>', ':tabnext<CR>')
map('', '<C-t>', ':tabnew<CR>')
map('', '<C-d>', ':tabclose<CR>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-f>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<c-h>', builtin.resume, { desc = 'Telescope find files' })
vim.keymap.set('n', '<c-g>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<c-h>', builtin.grep_string, { desc = 'Telescope grep string' })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- vim.api.nvim_create_autocmd({ "FileType go" }, {
--  command = "setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab",
--})

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

local cmp = require'cmp'
cmp.setup{
  snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
       { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
}

vim.lsp.enable('ruby_lsp')
vim.lsp.enable('zls')
vim.lsp.enable('gopls')
vim.lsp.enable('ts_ls')
