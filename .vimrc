" Pathogen is a VIM plugin management script. It allows you to just unzip
" your script files into the .vim/bundle directory, and magically picks up
" everything to get things to work.
call pathogen#infect()

" Make any changes to .vimrc trigger the .vimrc reload
:au! BufWritePost $MYVIMRC source $MYVIMRC

" Syntax coloring and colorscheme
syntax enable
filetype plugin indent on
" The following makes the background color transparent for the solarized 
" color scheme
let g:solarized_termtrans=1
set background=dark

" Make backspace work like most other apps
set backspace=2 

" Point to my own cscope rather than use an default (outdated) one
set csprg=/home/ihamer/bin/cscope

" Use spaces instead of tabs. Use 2 spaces per tab.
set expandtab
set smarttab
set shiftwidth=2 
set softtabstop=2

"RequestedCuVec Some basic settings from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
nnoremap <leader>a :Ack 

" Tab related: Ctrl switches to next, previos tab. Alt moves current tab
" to next, previos position
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Map ; to be the same as :
" This saves pushing shift all the time to enter :
nnoremap ; :
vnoremap ; :

" map ,t to open in new tab
nmap ,t <Esc>:tabnew 

" map ctrl-s to save the file
nmap <C-s> <Esc>:w<CR> 

nnoremap <C-Left> :tabprevious<CR>
" Besides typing ESC to get into normal mode, you can use jk as well.
inoremap jk <ESC>
nmap <C-s> <C-s>
imap <C-s> <ESC><C-s>

" Add syntax coloring for some files
au BufNewFile,BufRead *.dj set filetype=ruby
au BufNewFile,BufRead *.dv set filetype=javascript
au BufNewFile,BufRead *.blk set filetype=c
au BufNewFile,BufRead *.luax set filetype=lua
au BufNewFile,BufRead *.log set filetype=cpp

" Nerd tree is a plugin. Look into .vim/. It is a visual file system browser
nmap <C-d> :NERDTreeToggle<CR>
imap <C-d> <Esc>:NERDTreeToggle<CR>

" Open tree in the dir of current file
nmap <C-f> :NERDTreeFind<CR>

" Map Control Up to open the definition of the tag under cursor
nmap <ESC>[1;5A :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
imap <ESC>[1;5A <Esc>:tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Map Control Down to go back
nmap <ESC>[1;5B <C-t> 
imap <ESC>[1;5B <Esc><C-t>

" Make Ctrl-v paste from the clipboard. This is commented out since the ctrl-v
" override is made in .Xresources.
" nmap <C-v> "+p
" imap <C-v> <Esc>"+pi

" Shortcuts for next/previous tab
nmap <C-p> :tabnext<CR>
imap <C-p> <Esc>:tabnext<CR>

" Open previous tab
let g:lasttab = 1
nmap - :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Enable status line and add some information about the file. Good start:
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" Define colors first
hi User1 ctermbg=black ctermfg=red   guibg=black  guifg=red
hi User2 ctermbg=green ctermfg=white  guibg=red   guifg=blue
hi User3 ctermbg=green ctermfg=black guibg=blue  guifg=green

" This function is mainly for debugging purposes. Based on your settings, it
" will return a string to indicate whether your perforce is set up.
function! GetP4Status ()
  if exists("g:hasp4")
    if exists("g:p4user")
      return g:p4user
    else
      return "NO p4user"
    endif
  else
    return "NO P4"
  endif
  return ""
endfunction

" The status line for the editor. 
set laststatus=2
set statusline=   
set statusline+=%t\              " Tail of the filename
set statusline+=%y             " File type
set statusline+=%r             " Read-only status
set statusline+=[%{strlen(&fenc)?&fenc:'none'},%{&ff}]
set statusline+=[P4:%{GetP4Status()}]  " Perforce status 
set statusline+=%=             " Right Align 
set statusline+=%m             " Modified flag
set statusline+=%1*\ %l\          " Cursor line number
set statusline+=%0*\ %P           " Cursor position within file

" Highlight all search results.
" Press Space to turn off highlighting and clear any message already displayed.
set hlsearch
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Some fixes for Command-T plugin
" Allow cancel by escape
let g:CommandTBackspaceMap=['<BS>']
let g:CommandTCancelMap=['<ESC>','<C-c>']
let g:CommandTMatchWindowReverse=1
let g:CommandTMaxHeight=20
let g:CommandTMaxFiles=50000
nmap ,f <Esc>:CommandTFlush<CR>

" It hides buffers instead of closing them. This means that you can have unwritten changes to a file 
" and open a new file using :e, without being forced to write or undo your changes first. Also, undo 
" buffers and marks are preserved while the buffer is open. 
set hidden


" set files to ignore when doing expansion. Plugins such as command-T and
" Ctrl-P use this to never suggest opening such files as well
set wildignore=import/**
set wildignore+=tmp/**
set wildignore+=out/**
set wildignore+=logs/**
set wildignore+=*.swp
set wildignore+=**/pcie-kaveri/**
set wildignore+=src/meta/firmware/**
set wildignore+=**/amur/**
set wildignore+=**/lm32_verilated/**

" Disable swap file creation
set noswapfile

" Shows all options in the status line for autocomplete of file and command names  
set wildchar=<Tab> wildmenu wildmode=full

" Macros
"

" Add silent prefix for commands that show 'press enter to continue...'
command! -nargs=1 Silent
\ | execute ':silent '.<q-args>
\ | execute ':redraw!'


" Error format for GCC. [^w] is a quick hack to avoid warnings
"set errorformat=%f:%l:\ %m,%-G%.%#
" Ignore certain messages from the list of errors
"set errorformat^=%-G%f:%l:\ warning:\ overriding\ commands\ for\ target%.%#
"set errorformat^=%-G%f:%l:\ warning:\ ignoring\ old\ commands\ for\ target%.%#

set errorformat=%-G%f:%l:\ warning:\ overriding\ commands\ for\ target%.%#,%-G%f:%l:\ warning:\ ignoring\ old\ commands\ for\ target%.%#,%f:%l:\ %m,%-G%.%#

" Make script (to be executed when VI's make is called - :make )
set makeprg=bash\ -c\ ihbo/home/ihamer/bin/ihbo\ /local_vol1_nobackup/user/ihamer/smu8_0/cz/mp/src/firmware/carrizo/mp1/src 


" Creates a session for the particular directory you loaded VI from.
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:sessionfile = b:sessiondir . '/session.vim'
  exe "mksession! " . b:sessionfile
endfunction

" Updates a session, BUT ONLY IF IT ALREADY EXISTS
function! UpdateSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe "mksession! " . b:sessionfile
    echo "updating session"
  endif
endfunction

" Loads a session if it exists
function! LoadSession()
  if argc() == 0
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
      exe 'source ' b:sessionfile
    else
      echo "No session loaded."
    endif
  else
    let b:sessionfile = ""
    let b:sessiondir = ""
  endif
endfunction

au VimEnter * nested :call LoadSession()
" Uncomment the following if you want the session to be updated every time 
" you exit VI
" au VimLeave * :call UpdateSession()
map <leader>m :call MakeSession()<CR>

" Prevent x from storing the deleted character into the default register
noremap x "_x

" Paste in visual mode without updating the default register:
vnoremap p "_dP

" Shows some details in the bottom right corner (such as number of lines
" selected in visual mode, repeat count for a command...)
set showcmd

" Who doesn't like autoindent?
set autoindent

" Change the color of matched paren for less confusion 
highlight MatchParen ctermbg=4

" Converting hex to decimal
nnoremap gn :call DecAndHex(expand("<cWORD>"))<CR>

function! DecAndHex(number)
  let ns = '[.,;:''"<>()^_lL]'      " number separators
  if a:number =~? '^' . ns. '*[-+]\?\d\+' . ns . '*$'
     let dec = substitute(a:number, '[^0-9+-]*\([+-]\?\d\+\).*','\1','')
     echo dec . printf('  ->  0x%X, -(0x%X)', dec, -dec)
  elseif a:number =~? '^' . ns. '*\%\(h''\|0x\|#\)\?\(\x\+\)' . ns . '*$'
     let hex = substitute(a:number, '.\{-}\%\(h''\|0x\|#\)\?\(\x\+\).*','\1','')
     echon '0x' . hex . printf('  ->  %d', eval('0x'.hex))
     if strpart(hex, 0,1) =~? '[89a-f]' && strlen(hex) =~? '2\|4\|6'
        " for 8/16/24 bits numbers print the equivalent negative number
        echon ' ('. float2nr(eval('0x'. hex) - pow(2,4*strlen(hex))) . ')'
     endif
     echo
  else
     echo "NaN"
  endif
endfunction


command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction

" Functions to start a search command in current file's directory using Ack plugin
function! AckInCurrentFileDirComplete(ArgLead, CmdLine, CursorPos)
  let dir = expand('%:p:h') 
  return dir . "\n" . dir ."/..\n"
endfunction

command! -nargs=* -complete=custom,AckInCurrentFileDirComplete AckInCurrentFileDir call s:AckInCurrentFileDir(<f-args>)
function! s:AckInCurrentFileDir(what, ...)
  if a:0 == 0
    let file_dir = expand('%:p:h') 
  else
    let file_dir = expand('%:p:h') . "/" . a:1
  endif
  "echo a:where
  echo "Find" a:what ". Look in" file_dir  
  " :let choice = confirm("What do you want?", "&Apples\n&Oranges\n&Bananas", 2)
  call AckInDir(a:what, file_dir)
endfunction

nmap ,a <Esc>:AckInCurrentFileDir <C-r><C-w> 

" Function to run cscope within the STEM Directory
function! s:CscopeInStem()
  let stem = expand('$STEM')
  exec 'silent !cd ' . stem . '&& /home/ihamer/bin/cscope -b'
  exec 'silent cs reset'
  redraw!
  echo 'cscope database updated'
endfunction
command! -nargs=* CscopeInStem call s:CscopeInStem(<f-args>)

nmap ,c <Esc>:CscopeInStem

" Fixing problems with tmux. The codes sent from tmux to vi are not the same
" as when from xterm to vi.
map OC <Right>
map OD <Left>
map [C <C-Right>
map [D <C-Left>

" Change directory to STEM. This was done so that command-t plugin sees the
" full directory tree all the time.
if exists("$STEM")
  cd $STEM
endif

" \fr:  reverse the order of lines (vertical mirror)
nmap \fr :set lz<CR>o<Esc>mz'aO<Esc>ma:'a+1,'z-1g/^/m 'a<CR>'addma'zdd:set nolz<CR>

" Flip from c to h
function! Mosh_Flip_Ext()
  " Switch editing between .c* and .h* files (and more).
  " Since .h file can be in a different dir, call find.
  if match(expand("%"),'\.c') > 0
    let s:flipname = substitute(expand("%"),'\.c\(.*\)','.h',"")
    exe ":find " s:flipname
  elseif match(expand("%"),"\\.h") > 0
    let s:flipname = substitute(expand("%"),'\.h\(.*\)','.c\1',"")
    if (!filereadable(s:flipname))
      let s:flipname = substitute(expand("%"),'\.h\(.*\)','.cpp',"")
    endif
    exe ":e " s:flipname
  endif
endfun

map <C-i> :call Mosh_Flip_Ext()<CR>
map <C-q> :q<CR>
map <C-n> <C-w><Down><Down><CR>zz<C-w><Up>
map <C-h> <C-w><Down><Up><CR>zz<C-w><Up>
