syntax enable            " enable syntax processing

" TABS & INDENTS
filetype indent on      " load specific filetype indentions 
set autoindent          " allow auto indention 
set tabstop=4           " set tab to be 4 visual spaces
set softtabstop=4       " set tab to be 4 spaces in editing mode
set expandtab           " change all tabs to spaces
set shiftwidth=4        " (?)

" LINES
set number              " show line numbers
set cursorline          " highlight current line
set mouse+=a            " do not select line numbers when copying

" VISUAL EASE
set wildmenu            " allow command autocompletion in menu
set lazyredraw          " only redraw the screen when we need to
set showmatch           " highlight matching [{()}]

" SEARCHING (?)
set ignorecase          " ignore case when searching 
set incsearch           " search as characters are entered
set hlsearch            " highlight search matches
nnoremap <leader><space> :nohlsearch<CR>    " turn off search highlight by pressing space

" FOLDING
set foldenable          " enable FOLDING
set foldlevelstart=0    " 0-99 ; 0 = all closed , 99 all open ;
set foldnestmax=5       " maximum of 5 nested folds ; increase as needed
set foldmethod=marker   " set folding to marker. could also be tab
set foldmarker=[[,]]    " set fold markers to double brackets [[ <data> ]]

" open/close folds with SPACE 
nnoremap <space> za     


" COLORS AND HIGHLIGHTS
set t_Co=256            " use 256 colors in Vim!  

colorscheme desert256   " set colorscheme
set background=dark     " have a dark background regardless of color scheme



" [[ Highlight IP addresses
syntax match ipaddr /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[1]\?\_[0-9]\?\_[0-9]\|\_[0]\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[1]\?\_[0-9]\?\_[0-9]\|\_[0]\)/

highlight IPformat term=bold cterm=bold ctermfg=196 ctermbg=NONE gui=bold font=NONE guifg=#ff0000 guibg=NONE

highlight link ipaddr IPformat 
"]]

" [[ Highlight MAC addresses
syntax match macaddr /\(\(\_[0-9]\|\_[a-f]\|\_[A-F]\)\{2\}\(\:\)\)\{5\}\(\_[0-9]\|\_[a-f]\|\_[A-F]\)\{2\}/

highlight MACformat term=bold cterm=bold ctermfg=DarkBlue ctermbg=NONE gui=bold font=NONE guifg=Green guibg=NONE

highlight link macaddr MACformat
"]]

" [[ Highlight TimeStamp - format: YYYY-MM-DD-hh:mm:ss
syntax match timestamp /\(\_[0-9]\)\{4\}\(\-\(\_[0-9]\)\{2\}\)\{3\}\(\:\(\_[0-9]\)\{2\}\)\{2\}/

highlight Timeformat term=bold cterm=bold ctermfg=34 ctermbg=NONE gui=bold font=NONE guifg=#008000 guibg=NONE

highlight link timestamp Timeformat
"]]

" [[ Highlight IPv6 Address with Compression
syntax match ip6addr /\<\(\(\_[A-Fa-f0-9]\{1,4\}\:\)\{7\}\(\_[A-Fa-f0-9]\{1,4\}\)\{1\}\)\>/

syntax match ip6addr /\<\(\(\_[A-Fa-f0-9]\{1,4\}\:\)\{0,7\}\(\:\_[A-Fa-f0-9]\{1,4\}\)\{0,7\}\)\>/

syntax match ip6addr /\<\(\(\(\_[A-Fa-f0-9]\{1,4\}\:\)\{1,7\}\|\:\)\:\)\>/

syntax match ip6addr /\<\(\:\(\:\_[A-Fa-f0-9]\{1,4\}\)\{1,7\}\)\>/

highlight IP6format term=bold cterm=bold ctermfg=220 ctermbg=NONE gui=bold font=NONE guifg=#ffd700 guibg=NONE

highlight link ip6addr IP6format
 "]]

" [[ Highlight Comments and Warnings

" Warning
syntax region xWarning start=/!!*/ end=/$/ 
highlight link xWarning ErrorMsg

" // Comment
syntax region xWhackComment start=/^\/\/ */ end=/$/
syntax region xBashComment start=/^\#/ end=/$/
syntax region xQuoteComment start=/\"/ end=/$/

highlight link xQuoteComment Comment
highlight link xBashComment Comment
highlight link xWhackComment Comment

  "]]

" COPY + PASTE

" copy using Ctrl + C in Visual Mode
vnoremap <C-c> "*yy
vnoremap <C-y> "+yy

" [[ Duplicate Lines

" duplicate current line for editing
nnoremap  yyp
inoremap  <esc>yypi

" ]] 

" [[  HOTKEYS 

" F5 = Timestamp 
:nnoremap <F5> a<C-R>=strftime("%Y-%m-%d-%H:%M:%S")<CR><ESC>
:inoremap <F5> <C-R>=strftime("%Y-%m-%d-%H:%M:%S")<CR>

" F1 = Create Target Section Header
:nnoremap <F1> i###########################################################################<CR>$ T# = [[ ip<CR><CR><ESC>
:inoremap <F1> ###########################################################################<CR>$ T# = [[ ip<CR><CR>

" F2 = Create Timestamp Block -- WITHOUT SURVEY SECTION 
:nnoremap <F2> iLogin/Vet Start:<CR>Vetting End    :<CR>Disconnect     :<CR><CR><ESC>
:inoremap <F2> Login/Vet Start:<CR>Vetting End    :<CR>Disconnect     :<CR><CR>

" F3 = Create Timestamp Block -- SURVEY SECTION 
:nnoremap <F3> iLogin/Vet Start:<CR>Vetting End    :<CR>Survey Start   :<CR>Survey End     :<CR>Disconnect     :<CR><CR><ESC>
:inoremap <F3> Login/Vet Start:<CR>Vetting End    :<CR>Survey Start   :<CR>Survey End     :<CR>Disconnect     :<CR><CR>

" F4 = Create Target Section Footer
:nnore map <F4> i<CR>###########################################################################]]<CR><CR><ESC>
:inor emap <F4> <CR>###########################################################################]]<CR><CR>

" F7 = Insert SSH Forward
:nnoremap <F7> i<CR>ssh -S $socket -O forward -
:inoremap <F7> <CR>ssh -S $socket -O forward -

" F8 = Insert SSH Command
:nnoremap <F8> i<CR>ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null <ESC>
:inoremap <F8> <CR>ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null 

" ]]






