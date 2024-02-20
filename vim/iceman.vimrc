syntax enable  
set nocompatible 

" Source the vimrc everytime you open a new file
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
set shiftwidth=4        " when shifting with Shift+>> or Shift+<< move 4 spaces 

" LINES
set number              " show line numbers
set cursorline          " highlight current line
set mouse+=a            " do not select line numbers with mouse when copying

" VISUAL EASE
set wildmenu            " allow command autocompletion in menu
set lazyredraw          " only redraw the screen when we need to
set showmatch           " highlight matching [{()}]

" SEARCHING (?)
set ignorecase          " ignore case when searching 
set incsearch           " search as characters are entered
set hlsearch            " highlight search matches

" turn off search highlight with backslash (\) + Space
nnoremap <leader><space> :nohlsearch<CR>    

" FOLDING
set foldenable          " enable FOLDING
set foldlevelstart=0    " 0-99 ; 0 = all closed , 99 all open ;
set foldnestmax=5       " maximum of 5 nested folds ; increase as needed
set foldmethod=marker   " set folding to marker. could also be tab
set foldmarker=[[,]]    " set fold markers to double brackets [[ <data> ]]

" open/close folds with SPACE in normal mode
nnoremap <space> za     

" COPY + PASTE
" copy using Ctrl + Y in Visual Mode  ( vim-gtk with +clipboard required! )
vnoremap <C-y> "+yy

" Shift lines up and down with Ctrl-Up and Ctrl-Down
nnoremap <C-down> :m .+1<CR>==
nnoremap <C-up> :m .-2<CR>==
inoremap <C-down> <Esc>:m .+1<CR>==gi
inoremap <C-up> <Esc>:m .-2<CR>==gi

" Duplicate Current Line with Ctrl-\ (Backslash)
nnoremap <C-\> yyp
inoremap <C-\> <ESC>yypi " YIPPEE!!


" Highlight comment markers : !!, ??, #, and ##
"syntax region excla matchgroup=excla     start=/!!/  end=/$/
"highlight excla ctermfg=white ctermbg=red

syntax region quest matchgroup=quest      start=/??/  end=/$/
highlight quest ctermfg=green

syntax region comm1 matchgroup=comm1      start=/#/   end=/$/
highlight comm1 ctermfg=130

syntax region comm2 matchgroup=comm2       start=/##/  end=/$/
highlight comm2 ctermfg=gray

" Warning
syntax region xWarning start=/!!*/ end=/$/ 
highlight link xWarning ErrorMsg

" // Comment
syntax region xWhackComment start=/^\/\/ */ end=/$/
"syntax region xBashComment start=/^\#/ end=/$/
syntax region xQuoteComment start=/\"/ end=/$/

highlight link xQuoteComment Comment
"highlight link xBashComment Comment
highlight link xWhackComment Comment


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


" [[ HOTKEYS 

" F5 = Timestamp 
:nnoremap <F5> aEpoch <C-R>=system('date -u "+%s"')<CR><C-R>=system('date -u "+%Z %Y-%m-%d-%H:%M:%S"')<CR><ESC>
:inoremap <F5> Epoch <C-R>=system('date -u "+%s"')<CR><C-R>=system('date -u "+%Z %Y-%m-%d-%H:%M:%S"')<CR>

" F1 = Create Target Section Header
:nnoremap <F1> i############################################################<CR>$ T# = [[ ip<CR><CR><ESC>
:inoremap <F1> ############################################################<CR>$ T# = [[ ip<CR><CR>

" F2 = Create Timestamp Block 1
:nnoremap <F2> iLogin/Vet Start:<CR>Vetting End    :<CR>Disconnect     :<CR><CR><ESC>
:inoremap <F2> Login/Vet Start:<CR>Vetting End    :<CR>Disconnect     :<CR><CR>

" F3 = Create Timestamp Block 2 
:nnoremap <F3> iLogin/Vet Start:<CR>Vetting End    :<CR>Survey Start   :<CR>Survey End     :<CR>Disconnect     :<CR><CR><ESC>
:inoremap <F3> Login/Vet Start:<CR>Vetting End    :<CR>Survey Start   :<CR>Survey End     :<CR>Disconnect     :<CR><CR>

" F4 = Create Target Section Footer
:nnoremap <F4> i<CR>############################################################]]<CR><CR><ESC>
:inoremap <F4> <CR>############################################################]]<CR><CR>

" F7 = Insert SSH Forward
:nnoremap <F7> i<CR>ssh -S $socket -O forward -
:inoremap <F7> <CR>ssh -S $socket -O forward -

" F8 = Insert SSH Command
:nnoremap <F8> i<CR>ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null <ESC>
:inoremap <F8> <CR>ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null 

"]]


"======================================
" HOTKEYS:
"
" F5 - Timestamp (Epoch & UTC)
" F1 - Target Header		F4 - Target Footer
" F2 - Timestamp Block 	F3 - Timestamp Block w/ Survey
" F7 - SSH Forward command	F8 - SSH Command
"
" Comments : !!, ??, #, ##, //, "
"
