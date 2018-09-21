source $VIMRUNTIME/vimrc_example.vim

" Apperance
set nu
set cursorline
set tabstop=4
set shiftwidth=4
set bg=dark
set guifont=Lucida_Console:h13
color perun  " Same as :colorscheme evening
hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE

" maximize the initial vim window under Windows
au GUIEnter * simalt ~x

" Make vim paste from system's clipboard
set clipboard=unnamed

" Fix del
set backspace=indent,eol,start

" Fix command line pasting
inoremap <C-R>+ <C-R><C-R>+

" Automatic Indentation
filetype indent on

" For init
" building help tags
helptags $VIM\vimfiles\doc\

" For ctags
let Tlist_Ctags_Cmd = 'C:\ctags58\ctags.exe'
set tags=tags;
set autochdir

" Open and close the srcexpl.vim separately 
" nmap <F9>   :SrcExplToggle<CR> 
" // Do not let the Source Explorer update the tags file when opening          " 
" let g:SrcExpl_isUpdateTags = 0

" Open and close the taglist.vim separately 
nmap <F10>  :TlistToggle<CR> 
" Fast up tag hightlight update time in Taglist
set ut=300

" Open and close the NERD_tree.vim separately 
nmap <F11>  :NERDTreeToggle<CR> 
" Always open nerdtree on the right side
let g:NERDTreeWinPos = "right"

" Key mapping
let mapleader = ","
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>ts :tab sp<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

"Toggle paste mode on and off:
map <leader>pp :setlocal paste!<cr>

"Go back to previous split window"
map <leader>mm <C-w><C-p>

inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i

" Insert the current date and time (useful for timestamps):
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" move to another split window

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Open ack.vim for fast search
map <leader>g :Ack! --type=cc<space>
map <leader><leader>g :AckWindow!<space>
map <leader>v viw


" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
vnoremap <silent> <leader>g :<C-u>call VisualSelection('gv', '')<CR>
vnoremap <silent> <leader><leader>g :<C-u>call VisualSelection('gvw', '')<CR>
vnoremap <silent> <leader>r :<C-u>call VisualSelection('replace', '')<CR>


function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 


function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack! --type=cc \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . "/". l:pattern . "/")
    elseif a:direction == 'gvw'
        call CmdLine("AckWindow! \"" . l:pattern . "\" " )
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" fold setting
"set foldenable              
"set foldmarker=#if,#endif
"set foldmethod=marker      
"set foldcolumn=0          
"setlocal foldlevel=1        
"set foldnestmax=3
"set foldlevelstart=99
"

" toggle open/close fold
" nnoremap <silent><leader><space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set foldenable
set foldmethod=manual
set foldnestmax=3


" replace c+[ with g+[
nnoremap <c-]> g<c-]>

" set up backup and swap files folder
set dir=$VIM\.swap
set backupdir=$VIM\.backup
set undodir=$VIM\.undo

" toggle quick fix window
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>
