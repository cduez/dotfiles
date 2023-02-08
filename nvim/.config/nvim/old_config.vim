"nmap <silent> <c-n> :bn<CR>
"nmap <silent> <c-p> :bp<CR>
"nmap <silent> <c-e> :b#<CR>

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

"map <C-Up> {
"map <C-Down> }

"map <M-Up> <C-W><C-K>
"map <M-Down> <C-W><C-J>
"map <M-Left> <C-W><C-H>
"map <M-Right> <C-W><C-L>
"
"map <M-S-Up> <C-W>K
"map <M-S-Down> <C-W>J
"map <M-S-Left> <C-W>H
"map <M-S-Right> <C-W>L

"nnoremap <C-o> :tabprev<CR>
"nnoremap <C-p> :tabnext<CR>
"
"nnoremap <C-t> :tabnew<CR>
"nnoremap <C-d> :tabclose<CR>

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

"autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=2
"autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
"autocmd BufRead,BufNewFile *.vue set filetype=html

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"let g:NERDTreeGlyphReadOnly = "RO"
"let g:NERDTreeDirArrows = 1
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
"let g:NERDTreeNodeDelimiter = '\x07'
