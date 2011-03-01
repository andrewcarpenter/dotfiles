set nocompatible

set number
set ruler
syntax on
color vibrantink

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set expandtab

" handle wrapping
set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0


" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2

inoremap jj <ESC>

" set the screen title to the current filename
if $TERM=='screen'
   exe "set title titlestring=vi:%f"
   exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
endif
