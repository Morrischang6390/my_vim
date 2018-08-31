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
nmap <F9>   :SrcExplToggle<CR> 
" // Do not let the Source Explorer update the tags file when opening          " 
let g:SrcExpl_isUpdateTags = 0

" Open and close the taglist.vim separately 
nmap <F10>  :TlistToggle<CR> 

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
map <leader>g :Ack!<space>


" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
vnoremap <silent> <leader>g :<C-u>call VisualSelection('gv', '')<CR>

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 


function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack! \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
