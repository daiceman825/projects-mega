syntax enable  
set nocompatible 

autocmd BufRead,BufNewFile,BufEnter * source ~/.vimrc

" COLORS AND HIGHLIGHTS
set t_Co=256            " use 256 colors in Vim!  

colorscheme desert      " set colorscheme
set background=dark     " have a dark background regardless of color scheme


" TABS & INDENTS
filetype indent on      " load specific filetype indentions 
set autoindent          " allow auto indention 
set tabstop=4           " set tab to be 4 visual spaces
set softtabstop=4       " set tab to be 4 spaces in editing mode
set expandtab           " change all tabs to spaces
set shiftwidth=4        " change shift+>> and shift+<< to 4 spaces

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

" turn off search highlight by pressing space
nnoremap <leader><space> :nohlsearch<CR>    

" FOLDING
set foldenable          " enable FOLDING
set foldlevelstart=0    " 0-99 ; 0 = all closed , 99 all open ;
set foldnestmax=5       " maximum of 5 nested folds ; increase as needed
set foldmethod=marker   " set folding to marker. could also be tab
set foldmarker=[[,]]    " set fold markers to double brackets [[ <data> ]]

" open/close folds with SPACE 
nnoremap <space> za     

" COPY + PASTE
" copy using Ctrl + C in Visual Mode  ( vim-gtk with +clipboard required! )
"vnoremap <C-c> "+yy

" Shift lines up and down with Ctrl-Up and Ctrl-Down
nnoremap <C-down>      :m .+1<CR>==
nnoremap <C-up>        :m .-2<CR>==
inoremap <C-down> <Esc>:m .+1<CR>==gi
inoremap <C-up>   <Esc>:m .-2<CR>==gi

" Duplicate Current Line with Ctrl-\ (Backslash)
nnoremap <C-\>      yyp
inoremap <C-\> <ESC>yypi

syntax region excla matchgroup=excla  start=/!!/  end=/$/
syntax region quest matchgroup=quest  start=/??/  end=/$/
syntax region comm1 matchgroup=comm1  start=/#/   end=/$/
syntax region comm2 matchgroup=comm2  start=/##/  end=/$/

highlight excla ctermfg=white ctermbg=red
highlight quest ctermfg=green
highlight comm1 ctermfg=130
highlight comm2 ctermfg=gray


" [[ Highlight IP addresses
" /((25[0-5]|2[0-4][0-9]|[1]?[0-9]?[0-9]|[0]).){3}(25[0-5]|2[0-4][0-9]|[1]?[0-9]?[0-9]|[0])/
syntax match ipaddr /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[1]\?\_[0-9]\?\_[0-9]\|\_[0]\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[1]\?\_[0-9]\?\_[0-9]\|\_[0]\)/

highlight IPformat term=bold cterm=bold ctermfg=196 ctermbg=NONE gui=bold font=NONE guifg=#ff0000 guibg=NONE

highlight link ipaddr IPformat 
"]]  


" [[ Highlight MAC addresses
" /(([0-9]|[a-f]|[A-F]){2}(:)){5}([0-9]|[a-f]|[A-F]){2}/
syntax match macaddr /\(\(\_[0-9]\|\_[a-f]\|\_[A-F]\)\{2\}\(\:\)\)\{5\}\(\_[0-9]\|\_[a-f]\|\_[A-F]\)\{2\}/

highlight MACformat term=bold cterm=bold ctermfg=DarkBlue ctermbg=NONE gui=bold font=NONE guifg=Green guibg=NONE

highlight link macaddr MACformat
"]]


" [[ Highlight TimeStamp - format: YYYY-MM-DD-hh:mm:ss

"/([0-9]){4}(-([0-9]){2}){3}(:([0-9]){2}){2}/

syntax match timestamp /\(\_[0-9]\)\{4\}\(\-\(\_[0-9]\)\{2\}\)\{3\}\(\:\(\_[0-9]\)\{2\}\)\{2\}/

highlight Timeformat term=bold cterm=bold ctermfg=34 ctermbg=NONE gui=bold font=NONE guifg=#008000 guibg=NONE

highlight link timestamp Timeformat
"]]


"[[ Highlight IPv6 Address with Compression
syntax match ip6addr /\<\(\(\_[A-Fa-f0-9]\{1,4\}\:\)\{7\}\(\_[A-Fa-f0-9]\{1,4\}\)\{1\}\)\>/
syntax match ip6addr /\<\(\(\_[A-Fa-f0-9]\{1,4\}\:\)\{1,6\}\(\:\_[A-Fa-f0-9]\{1,4\}\)\{1,6\}\)\>/
syntax match ip6addr /\<\(\(\(\_[A-Fa-f0-9]\{1,4\}\:\)\{1,7\}\|\:\)\:\)\>/
syntax match ip6addr /\<\(\:\(\:\_[A-Fa-f0-9]\{1,4\}\)\{1,7\}\)\>/

highlight IP6format term=bold cterm=bold ctermfg=220 ctermbg=NONE gui=bold font=NONE guifg=#ffd700 guibg=NONE

highlight link ip6addr IP6format
 "]]


" highlight PS outputs - [[
" [[>>  <<]] - between these brackets
syntax region psRegion start=/\[\[>>/ end=/<<\]\]/ keepend 

hi def link psField1 LineNr     " Yellow
hi def link psField2 Type       " Green
hi def link psField3 WarningMsg " Red 
hi def link psField4 Folded     " Gray
hi def link psField5 Question   " Light Green
hi def link psField6 Constant   " Orange
hi def link psField7 Comment    " Blue
hi def link psField8 Folded     " Gray

syn match psField8 /^\(\S\+\s*\)\{2\}/         contained containedin=psField7 " grog dont caare
syn match psField7 /^\(\S\+\s*\)\{3\}/         contained containedin=psField6 " UID
syn match psField6 /^\(\S\+\s*\)\{4\}/         contained containedin=psField5 " PID
syn match psField5 /^\(\S\+\s*\)\{5\}/         contained containedin=psField4 " PPID
syn match psField4 /^\(\S\+\s*\)\{12\}/        contained containedin=psField3 " grog dont caare
syn match psField3 /^\(\S\+\s*\)\{13\}/        contained containedin=psField2 " TTY
syn match psField2 /^\(\S\+\s*\)\{14\}/        contained containedin=psField1 " time 
syn match psField1 /^\(\S\+\s*\)\{14\}\(.*$\)/ contained containedin=psRegion " command running

"]]


" highlight netstat outputs - [[
" [[::  ::]] - between these brackets

syntax region netRegion start=/\[\[::/ end=/::\]\]/ keepend 

hi def link netField1 Constant  " Orange
hi def link netField2 Question  " Light Green
hi def link netField3 Comment   " Blue
hi def link netField4 Folded    " Blue
hi def link netField5 Normal    " White

syn match netField1 /^\(\S\+\s\+\)\{6\}\(.*$\)/ contained containedin=netRegion " PID
syn match netField2 /^\(\S\+\s\+\)\{6\}/        contained containedin=netField1 " Remote Addr
syn match netField3 /^\(\S\+\s\+\)\{5\}/        contained containedin=netField2 " Local  Addr
syn match netField4 /^\(\S\+\s\+\)\{4\}/        contained containedin=netField3 " Send  / Recv
syn match netField5 /^\(\S\+\s\+\)\{2\}/        contained containedin=netField4 " Proto / State

"]]


" [[ HOTKEYS 

" F5 = Timestamp 
:nnoremap <F5> aEpoch <C-R>=system('date -u "+%s"')<CR><C-R>=system('date -u "+%Z %Y-%m-%d-%H:%M:%S"')<CR><ESC>
:inoremap <F5> Epoch <C-R>=system('date -u "+%s"')<CR><C-R>=system('date -u "+%Z %Y-%m-%d-%H:%M:%S"')<CR>

" F1 = Create Target Section Header
:nnoremap <F1> i###########################################################################<CR>$ T# = [[ ip<CR><CR><ESC>
:inoremap <F1> ###########################################################################<CR>$ T# = [[ ip<CR><CR>

" F2 = Create Timestamp Block --WITHOUT SURVEY SECTION 
:nnoremap <F2> iLogin/Vet Start:<CR>Vetting End    :<CR>Disconnect     :<CR><CR><ESC>
:inoremap <F2> Login/Vet Start:<CR>Vetting End    :<CR>Disconnect     :<CR><CR>

" F3 = Create Timestamp Block -- SURVEY SECTION 
:nnoremap <F3> iLogin/Vet Start:<CR>Vetting End    :<CR>Survey Start   :<CR>Survey End     :<CR>Disconnect     :<CR><CR><ESC>
:inoremap <F3> Login/Vet Start:<CR>Vetting End    :<CR>Survey Start   :<CR>Survey End     :<CR>Disconnect     :<CR><CR>

" F4 = Create Target Section Footer
:nnoremap <F4> i<CR>###########################################################################]]<CR><CR><ESC>
:inoremap <F4> <CR>###########################################################################]]<CR><CR>
"]]



