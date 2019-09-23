" Put your non-Plugin stuff after this line
set showcmd             " Show (partial) command in status line.  
set showmatch           " Show matching brackets.                 
set ignorecase          " Do case insensitive matching            
set smartcase           " Do smart case matching                  
set incsearch           " Incremental search                      
set autowrite           " Automatically save before commands like :next and :make  
set hidden              " Hide buffers when they are abandoned                 
set mouse=v             " Enable mouse usage (all modes)                     
syntax on
set nocompatible                                                           
"set number             "show line numbers                                 
set ruler               " set file stats                                 
set visualbell          "set blink cursor on error instead of beeping   
set encoding=utf-8
" Whitespace
set wrap
set textwidth=79                        
set formatoptions=tcqrn1                                                 
set tabstop=4                     
set shiftwidth=4                             
set softtabstop=4                                       
set expandtab                                               
set noshiftround 
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
execute pathogen#infect()
"set statusline+=%F
set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"
set list
set listchars=tab:\|\ 
let g:indentLine_color_term = 239
