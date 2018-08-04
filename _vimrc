source $VIMRUNTIME/vimrc_example.vim

" Apperance
set nu
set cursorline
set tabstop=4
set shiftwidth=4
set bg=dark
set guifont=Lucida_Console:h13
color evening  " Same as :colorscheme evening
hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE
hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE


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

