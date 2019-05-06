syntax on
set nocompatible
set ruler
nnoremap <C-\> :exe 'Gtlist ' . expand('<cword>')<CR>
" ClangFormat
noremap <C-K> :ClangFormat<CR>
inoremap <C-K> <C-O>:ClangFormat<CR>
" show outline window
"nnoremap ,g :GoogleOutlineWindow<CR>
set colorcolumn=81
nmap <CR> o<Esc>
set showmatch
set incsearch
nnoremap ; :
nnoremap j gj
nnoremap k gk
inoremap <expr> { AddPair('{', '}')
"inoremap <expr> ( AddPair('(', ')')
"inoremap <expr> [ AddPair('[', ']')
inoremap <CR> <Esc>:call CRCurlBracket()<CR>a<CR>

function! AddPair(open, close)
  let l:line = getline(".")
  " let l:next_char = l:line[col(".")]
  let l:prev_char = l:line[col(".")-1]
  if l:prev_char == ' ' || col(".") == col("$") || l:prev_char == ')' || l:prev_char == ']' || l:prev_char == '}'
    return a:open . a:close . repeat("\<left>", len(a:close))
  endif

  return a:open
endf

function! CRCurlBracket()
  let l:line = getline(".")
  let l:prev_char = l:line[col(".")-1]
  let l:next_char = l:line[col(".")]

  if l:next_char == "}" && l:prev_char == "{"
    execute "normal! a\<cr>"
    execute "normal! k$"
  end
endfunction

function! RemovePair()
  let l:line = getline(".")
  let l:prev_char = l:line[col(".")-1]
  let l:next_char = l:line[col(".")]

  if l:next_char == "}" && l:prev_char == "{"
    execute "normal! x"
  end
  if l:next_char == "]" && l:prev_char == "["
    execute "normal! x"
  end
  if l:next_char == ")" && l:prev_char == "("
    execute "normal! x"
  end
endfunction
function! BackToInsertMode()
  if col(".") == col("$")-1
    execute "normal! a"
  else
    execute "normal! i"
  endif
endfunction
inoremap <BS> <ESC>:call RemovePair()<CR>x:call BackToInsertMode()<CR>a
"inoremap <BS> <ESC>:call RemovePair()<CR>a<BS>
" function! RemoveNextDoubleChar(char)
"   let l:line = getline(".")
"   let l:next_char = l:line[col(".")]
"   if a:char == l:next_char
"     execute "normal! l"
"   else
"     execute "normal! a" . a:char . ""
"   end
" endfunction

" inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
" inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
" inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" Ctrl-P mapping
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
set hidden
set clipboard=unnamed
