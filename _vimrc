source $VIMRUNTIME/vimrc_example.vim

" Apperance
set nu
set cursorline
set tabstop=4
set shiftwidth=4
set bg=dark
set guifont=Lucida_Console:h13
color pink-moon  " Same as :colorscheme pink-moon
hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE

" Make vim paste from system's clipboard
set clipboard=unnamed

" Fix del
set backspace=indent,eol,start

" Automatic Indentation
filetype indent on

" For ctags
let Tlist_Ctags_Cmd = 'C:\ctags58\ctags.exe'
set tags=tags;
set autochdir

" Open and close all the three plugins on the same time 
nmap <F8>   :TrinityToggleAll<CR> 

" Open and close the srcexpl.vim separately 
nmap <F9>   :TrinityToggleSourceExplorer<CR> 

" Open and close the taglist.vim separately 
nmap <F10>  :TrinityToggleTagList<CR> 

" Open and close the NERD_tree.vim separately 
nmap <F11>  :TrinityToggleNERDTree<CR> 

" Key mapping
let mapleader = ","
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
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

