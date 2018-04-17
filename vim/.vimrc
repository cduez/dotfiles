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

set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.

set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).

set formatoptions=c,q,r,t " This is a sequence of letters which describes how
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

set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.

set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.

set mouse=a         " Enable the use of the mouse.


filetype plugin indent on

syntax on


:set pastetoggle=<F6>
:map <F2> :BufExplorer<CR>
:map <F3> :BufExplorerHorizontalSplit<CR>
:map <F4> :BufExplorerVerticalSplit<CR>
:imap <F5> <ESC>:NERDTreeToggle<CR>
:map <F5> :NERDTreeToggle<CR>

nmap <silent> <c-n> :bn<CR>
nmap <silent> <c-p> :bp<CR>
nmap <silent> <c-e> :b#<CR>

"find keycode with cat >/dev/null, ^[ is <esc>
"map <esc>Oc <C-Right>
"map <esc>Od <C-Left>
"map <esc>Oa <C-Up>
"map <esc>Ob <C-Down>

map <C-Up> {
map <C-Down> }

noremap <M-Down> <C-W>j
noremap <M-Up> <C-W>k
noremap <M-Right> <C-W>l
noremap <M-Left> <C-W>h

nnoremap <C-o> :tabprev<CR>
nnoremap <C-p> :tabnext<CR>

nnoremap <C-t> :tabnew<CR>
nnoremap <C-d> :tabclose<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
nnoremap <Leader>wn :match ExtraWhitespace /\s\+$/<CR>
nnoremap <Leader>wf :match<CR>
:autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

autocmd BufWritePre * :%s/\s\+$//e
autocmd User Rails/**/*.js set sw=4

match ExtraWhitespace /\s\+$/

let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'

set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

set cursorline

"autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
"autocmd FileType haskell setlocal tabstop=8 expandtab softtabstop=4 shiftwidth=4 smarttab shiftround nojoinspaces
