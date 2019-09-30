set tabstop=2       " Number of spaces that a <Tab> in the file counts for.

set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
set smartindent

set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.

set showmode
set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.

set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set ignorecase      " Ignore case in search patterns.

set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.

"set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.

"set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------ ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode.
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)

set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.

set mouse=a         " Enable the use of the mouse.


filetype plugin indent on

syntax on

:set pastetoggle=<F6>
:imap <F5> <ESC>:NERDTreeToggle<CR>
:map <F5> :NERDTreeToggle<CR>

nmap <silent> <c-n> :bn<CR>
nmap <silent> <c-p> :bp<CR>
nmap <silent> <c-e> :b#<CR>

"set termencoding=latin1
"find keycode with cat >/dev/null, ^[ is <esc>
"or in insert mode ctrl+v then type
"or sed -n l
"map <esc>Oc <C-Right>
"map <esc>Od <C-Left>
"map <esc>Oa <C-Up>
"map <esc>Ob <C-Down>

"map <esc>[c <C-S-Right>
"map <esc>[d <C-S-Left>
"map <esc>[a <C-S-Up>
"map <esc>[b <C-S-Down>
"

map <C-Up> {
map <C-Down> }

map <M-Up> <C-W><C-K>
map <M-Down> <C-W><C-J>
map <M-Left> <C-W><C-H>
map <M-Right> <C-W><C-L>

map <M-S-Up> <C-W>K
map <M-S-Down> <C-W>J
map <M-S-Left> <C-W>H
map <M-S-Right> <C-W>L

nnoremap <C-o> :tabprev<CR>
nnoremap <C-p> :tabnext<CR>

nnoremap <C-t> :tabnew<CR>
nnoremap <C-d> :tabclose<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
nnoremap <Leader>wn :match ExtraWhitespace /\s\+$/<CR>
nnoremap <Leader>wf :match<CR>
:autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

"autocmd BufWritePre * :%s/\s\+$//e
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

au BufNewFile,BufRead *.jst setlocal ft=html

match ExtraWhitespace /\s\+$/

let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlPMixed'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

set cursorline
:hi CursorLine cterm=NONE ctermbg=darkgrey

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif


"autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=2
autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd BufRead,BufNewFile *.vue setfiletype html

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

cnoreabbrev rg Ack
cnoreabbrev rgs AckFromSearch

"autocmd User Rails/**/*.js set sw=4
"autocmd FileType haskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 smarttab shiftround nojoinspaces
"
let g:NERDTreeGlyphReadOnly = "RO"
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeNodeDelimiter = '\x07'
