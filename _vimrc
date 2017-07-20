" This is something to do.  " for map , c means  something 
"          C means  something else
"           here shall be some comment
"
"Remove all abbreviations I defined before 
abclear

"let mapleader = "\\" 
let mapleader = '\' 

" Jump between x.h and x.cpp----------------{{{
function! HeadFileJump()
        exe "update"
        let filedata = split( expand( "%:p" ) , "\\." )
        if  "cpp" == filedata[-1] || "c" == filedata[-1]
                let filedata[-1] = "h"
        else
                let filedata[-1] = "cpp"
        endif

        let newname = join( filedata , "\." )
        if 1 == filereadable( newname )
                exe "e "  newname
        else
                if "cpp" == filedata[ -1 ]
                        let filedata[ -1 ] = "c"
                        let newname = join( filedata , "\." )
                        if 1 == filereadable( newname )
                                exe "e "  newname
                        else
                                echo "no file exist"
                        endif
                else
                        echo "no file exist"
                endif
        endif 
endfunction

nnoremap <leader>h :call HeadFileJump() <cr> 
"}}}

" Open a debug create windows ----------------{{{
function  OpenDebugMakingWindow()
        exe "tabnew a.awk"
        exe "sp tmp2"
        exe "vsp tmp"
endfunction

command -nargs=0 MakeDebug call OpenDebugMakingWindow()
"}}}

" Open a debug create windows ----------------{{{
function! DeleteTheLinesWithTheWordOf( theWord )
        exe "%s\/\\v.*" . a:theWord . ".*\\n//"
endfunction

"Futher we can delete Words
function! DeleteWord( theWord )
        exe "%s\/\\<" . a:theWord . "\\>\/\/g"
endfunction
"}}}

command -nargs=1 DL call DeleteTheLinesWithTheWordOf( "<args>" )
command -nargs=1 DW call DeleteWord( "<args>" )
nnoremap \dw yiw:call DeleteWord( "<C-R>0" ) <cr>


" Loat local vim files once it exist----------------{{{
if filereadable( ".\\session.vim" )
        source .\session.vim
endif

if filereadable( ".\\posi.vim" )
        source .\posi.vim
endif

"}}}

syntax on
filetype on
filetype plugin on
filetype indent on
"}}}


" c & cpp programming ----------------{{{

" returns----------------{{{
iabbrev rt return ;<ESC>k
iabbrev re return
iabbrev rtt return true;<ESC>
iabbrev rtf return false;<ESC>
iabbrev rt0 return 0;<ESC>
iabbrev rtn return NULL;<ESC>
iabbrev rtn1 return -1;<ESC>

"}}}

" branch----------------{{{

iabbrev ife if ( ) {<cr>} else {<cr>}<ESC>2k3la
iabbrev eif <space>else if ( ) {<cr>}<ESC>k^f(a
iabbrev es <space>else {<cr>}<ESC>k$a
iabbrev sw switch( )<cr>{<cr>default:<cr>break;<cr>}<ESC>4k6la

nnoremap \def yy:call HeadFileJump()<cr>Gp$xo{<cr>}<esc>O

iabbrev _out std::cout <<;<ESC>i
iabbrev _oout std::cout << << ;<ESC>^7li
iabbrev _ooout std::cout << <<  << ;<ESC>^7li

iabbrev _endl std::cout << std::endl;<esc>
iabbrev _outl std::cout << << std::endl;<ESC>02f<a
iabbrev _ooutl std::cout << <<  << std::endl;<ESC>^7li
iabbrev _oooutl std::cout << <<  <<  << std::endl;<ESC>^7li
iabbrev _+ ____________________________
iabbrev =+ <ESC>28a=<ESC>a
iabbrev -+ <ESC>28a-<ESC>a

iabbrev --> <ESC>10a-<ESC>a>
"iabbrev _oo  <ESC>a<< <ESC>3hi
iabbrev _in cin >>;<ESC>i
"iabbrev _iin cin >> >> ;<ESC>^5la
"iabbrev _iiin cin >> >> >>;<ESC>^5la
"iabbrev _ii  <ESC>a>> <ESC>3hi

"}}}

" Loops----------------{{{
iabbrev fri for ($ i = 0 ; i < $ ; ++ i ){<cr>$<cr>}<ESC>2kI<c-l>
iabbrev frii for ( int i = 0 ; i <$ ; ++ i ){<cr>$<cr>}<ESC>2kI<c-l>
iabbrev frj for ( int j = 0 ; j < ; ++ j ){<cr>$<cr>}<ESC>2kI<c-l>
iabbrev fra for ($ ; $ ; $ ){<cr>$<cr>}<ESC>2kI<c-l>
iabbrev frir for ( int i =$ ; i >= 0 ; -- i ){<cr>$<cr>}<ESC>2kI<c-l>
iabbrev forever for(;;){<cr>}<esc>k

"}}}

" # define ----------------{{{
iabbrev RFIN RETURN_FALSE_IF_NOT( );<esc>F(a
iabbrev RFINp RETURN_FALSE_IF_NOT(  );<esc>F(lp
iabbrev RIFNp RETURN_INT_IF_NOT(  , $ );<esc>F(lp
"  }}}

" For vim script ----------------{{{
abbrev vicom " ----------------{{{<cr>}}}<esc>k^a
iabbrev vifunc function!($)<cr>endfunction<esc>k0f(i
iabbrev vifor for<cr>endfor<esc>kA
iabbrev viif if<cr>endif<esc>kA
iabbrev viwh while<cr>endwhile<esc>kA
function! SourceIfisVimFile()
        update
        if expand( "%:e" ) == "vim"
                exec "source " . expand( "%:p" )
        endif
endfunction
inoremap kj <esc>:call SourceIfisVimFile()<cr>
"  }}}

" Preprocess----------------{{{
inoremap _imap #include <map><esc>
inoremap incl #include ""<esc>i
inoremap inc #include <><esc>i
inoremap _def #define
iabbrev ifdef #ifdef<cr>#endif // $<esc>kA
iabbrev ifdefe #ifdef<cr>#else<cr>#endif // $<esc>2kA
iabbrev if0 #if 0<cr>#endif /* if 0 */<esc>2k
iabbrev ifndef #ifndef<cr>#endif // $<esc>kA
iabbrev ifndefe #ifndef<cr>#else<cr>#endif // $<esc>2kA

iabbrev ifdeb #ifdef DEBUG <cr>#endif // DEBUG<esc>k
iabbrev ifndeb #ifndef DEBUG <cr>#endif // DEBUG<esc>k

iabbrev _mark cout << " ____________________________ " << endl;<esc>
inoremap ustd using std::;<esc>i
iabbrev  uns using namespace std;<esc>

"}}}
"map and containerwork----------------{{{
inoremap _map map< $ , $ >$<esc>^f$cw
inoremap _mit map< $ , $ >::iterator$<esc>^f$cw
inoremap it1 it -> first
inoremap it2 it -> second
inoremap _bg .begin()
inoremap _ed .end()
"}}}

"memory copy ----------------{{{
iabbrev mp memcpy($ , $ , sizeof( $ ) - 1 );<ESC>^/\$<cr>cw
iabbrev mms memset($ , 0 , sizeof( $ ) );<ESC>^/\$<cr>cw
iabbrev mcp memcmp($ , $ , $ );<ESC>^/\$<cr>cw
iabbrev sp strcpy($ , $ );<ESC>^/\$<cr>cw
iabbrev snp strncpy($ , $ , $ );<ESC>^/\$<cr>cw
iabbrev snps strncpy_s($ , $ , sizeof( $ ) - 1 );<ESC>^/\$<cr>cw
iabbrev sz sizeof($ )<ESC>^/\$<cr>cw
iabbrev sz1 sizeof($ ) - 1<ESC>^/\$<cr>cw
iabbrev sc strcmp($ , $ );<esc>I<C-Cr>
"}}}

" "add blankArea----------------{{{
iabbrev abl /***********************New Area***********************/<cr><cr>/******************************************************/
"}}}

" Parenthesess----------------{{{
inoremap [[ [  ]<ESC>hi
inoremap (( ( )<ESC>hi 
iabbrev <> < ><ESC>hi
iabbrev {{ {<cr>}<ESC>ka
iabbrev {}; {<cr>};<ESC>ka
iabbrev /g //_gb 
"}}}

abbrev tr try{<cr>}catch(  )<cr>{<cr>}<ESC>3k$a

" class creating ----------------{{{
inoremap pub public
inoremap prv private
inoremap prt protected
iabbrev vir virtual();<esc>Fla
iabbrev virt virtual()=0;<esc>Fla
"}}}

"comments ----------------{{{


autocmd FileType c nnoremap <BS> I//<esc>
autocmd FileType c nnoremap =<BS> ^xx<esc>
autocmd FileType c vnoremap <BS> :s/^/\/\/<cr>
autocmd FileType c vnoremap =<BS> :s/^\/\///<cr>

autocmd FileType cpp nnoremap <BS> I//<esc>
autocmd FileType cpp nnoremap =<BS> ^xx<esc>
autocmd FileType cpp vnoremap <BS> :s/^/\/\/<cr>
autocmd FileType cpp vnoremap =<BS> :s/^\/\///<cr>

autocmd FileType python nnoremap <BS> I#<esc>
autocmd FileType python nnoremap =<BS> ^x<esc>
autocmd FileType python vnoremap <BS> :s/^/#/<cr>
autocmd FileType python vnoremap =<BS> :s/^#//<cr>

autocmd FileType sql nnoremap <BS> I#<esc>
autocmd FileType sql nnoremap =<BS> ^x<esc>
autocmd FileType sql vnoremap <BS> :s/^/#/<cr>
autocmd FileType sql vnoremap =<BS> :s/^#//<cr>


nnoremap \ac :s/^/\/\/<cr>/_______________<cr>
nnoremap \rc :s/\/\//<cr>/_______________<cr>

vnoremap \ac :s/^/\/\/<cr>/_______________<cr>
vnoremap \rc :s/\/\//<cr>/_______________<cr>

"format comment
nmap \fc  ^t/D^O<ESC>p==       
"}}}

" SettingDebug----------------{{{
nmap \sd :tabnew DebugSetting.h<cr>
nnoremap \nt i/*Not Tested*/<esc>
nnoremap \def :tabnew e:\codes\my_defs.h<cr>    "Open my defs
"}}}

" other----------------{{{
iabbrev pause system( "pause" );<esc>
"iabbrev msg _msg( "--$ --" );<esc>F$xi
nnoremap \err :tabnew <cr>:!make 2> error_message<cr>:lfile error_message<cr>:lopen<cr>
                                        "Read the error from clipboard and get vim to read it.
                                        "see efm setting given for Visual stdio here
"error format for gcc
"set errorformat=%E1>%f\(%l\)\:%[\ fatal]%#\ error\ C%n\:\ %m,
"                        \%W1>%f\(%l\)\:\ warning\ C%n\:\ %m,
"                        \%E1\>%m
nnoremap <c-cr> "+yi":execute "tabnew " . expand( "%:h" ) . "\\<c-r>+"<cr>
                        "open the file 
                        "TAG_bug：在深入文件目录之后，无法对文件目录递归
                        "eg . \quickfix\a.h 里有一个 #include "fix44\a.h",这个时候对"fix\a.h"执行此操作会跳到 \quickfix\a.h而不是\quickfix\fix44\a.h
nnoremap <c-\> "+yi" :tabnew <c-r>+<cr>

inoremap <c-l> <esc>/\v\$<cr>xi
"}}}

" other not used yet----------------{{{
"inoremap (1 ( $ )<esc>F(/\$<cr>cw
"inoremap (2 ( $ , $ )<esc>F(/\$<cr>cw
"inoremap (3 ( $ , $ , $ )<esc>F(/\$<cr>cw
"inoremap (4 ( $ , $ , $ , $ )<esc>F(/\$<cr>cw
"inoremap (5 ( $ , $ , $ , $ , $ )<esc>F(/\$<cr>cw
"nnoremap <C-CR> <esc>/\$<cr>cw "??
"inoremap <C-CR> <esc>/\$<cr>cw "??
"iabbrev _if If<cr>else<cr>endif<esc>2ko ??
"}}}

"}}}

" Other short cut----------------{{{
" insert a time into to the script
iabbrev _t <ESC>:r !date/T<cr>:r !time/t<cr>2kJJA
iabbrev _eof End of function<esc>
"}}}

" Buffer control----------------{{{
noremap <c-h> :bp<cr>
noremap <c-l> :bn<cr>
"}}}

" Disable some keys to get used to the way of vim ----------------{{{
"noremap <up> <nop>
"noremap <down> <nop>
"noremap <left> <nop>
"noremap <right> <nop>
"noremap <home> <nop>
"noremap <End> <nop>
"noremap <Del> <nop>
"noremap <Insert> <nop>
"noremap <PageUp> <nop>
"noremap <PageDown> <nop>
"inoremap <up> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"inoremap <down> <nop>
"inoremap <home> <nop>
"inoremap <End> <nop>
"inoremap <Del> <nop>
"inoremap <Insert> <nop>
"inoremap <PageUp> <nop>
"inoremap <PageDown> <nop>
"inoremap <ESC> <nop>
"}}}

" Move up and down screens----------------{{{
nmap <c-n> Lzt
nmap <c-i> Hzb

nmap <c-j> 7j 
nmap <c-k> 7k
"}}}

" tab page work----------------{{{
nnoremap \c :tabclose<cr>:tabprevious<cr>
nnoremap \x :w<cr>:tabclose<cr>
nnoremap \f :tabm 0<cr>
nnoremap \1 :tabn 1<cr>
nnoremap \2 :tabn 2<cr>
nnoremap \3 :tabn 3<cr>
nnoremap \4 :tabn 4<cr>
nnoremap \5 :tabn 5<cr>
nnoremap \6 :tabn 6<cr>
nnoremap \7 :tabn 7<cr>
nnoremap \8 :tabn 8<cr>
nnoremap \9 :tabn 9<cr>
nnoremap \0 :tabn 10<cr>
nnoremap nl :tabn<cr>
nnoremap ns :tabp<cr>
nnoremap \n :tabnew note.txt<cr>
nnoremap \en :edit note.txt<cr>
command EREF tabnew .\ref_4_user.txt
command EREF2 tabnew .\ref_4_coder.txt

"}}}

" Help to quick edit and config---------------{{{
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ed :tabnew tmp/_done.cpp<cr>
nnoremap <leader>eo :tabnew tmp/_todo.cpp<cr>
nnoremap <leader>et :vsp tmp/_tmp.cpp<cr>
                        "  check whether dir exist and the type of the file

nnoremap <leader>em :tabnew Makefile<cr>
augroup filetype_setting
	autocmd!
        autocmd FileType vim setlocal foldmethod=marker
        autocmd FileType python setlocal foldmethod=indent

        autocmd FileType python nnoremap <leader>et :vsp tmp/_tmp.py<cr>
        autocmd FileType cpp nnoremap <leader>et :vsp tmp/_tmp.cpp<cr>
        autocmd FileType sql nnoremap <leader>et :vsp tmp/_tmp.sql<cr>
        autocmd FileType c  nnoremap <leader>et :vsp tmp/_tmp.c<cr>
        autocmd FileType sql  nnoremap <leader>et :vsp tmp/_tmp.sql<cr>
augroup END
"}}}

" My highlight setting ----------------{{{

highlight Normal guibg=lightgreen
highlight Pmenu guibg=DarkBlue guifg=Green
highlight Folded guibg=NONE guifg=gray
highlight Cursor guifg=black guibg=green
highlight cursorline guibg=darkgrey
highlight statusline guibg=red guifg=lightyellow
highlight statuslineNC guibg=darkred guifg=lightyellow
highlight Comment guifg=lightgrey gui=bold
highlight visual guifg=black guibg=white


highlight Normal ctermbg=none ctermfg=white
highlight Pmenu ctermbg=DarkBlue ctermfg=Green
highlight Folded ctermbg=NONE ctermfg=gray
highlight Cursor ctermfg=black ctermbg=green
highlight cursorline ctermbg=darkgrey
highlight statusline ctermbg=red ctermfg=yellow
highlight statuslineNC ctermbg=darkred ctermfg=yellow
highlight Comment ctermfg=lightgrey cterm=bold
highlight _Underlined term=underline cterm=underline ctermbg=blue
highlight PreProc ctermfg=green

"highlight visual ctermfg=none ctermbg=green   cterm=reverse   
highlight visual   cterm=reverse   
"}}}

" Searchs ----------------{{{

" Show the list of a keyword in this file and another .h or .cpp file----------------{{{
function! ShowList( keyWord )
        let fileName = split( expand( "%:t" ) , "\\." )
        if "cpp" == fileName[-1]
                let fileName[-1] = "h"
        elseif "h" == fileName[-1] 
                let fileName[-1] = "cpp"
        else
                exe "lvimgrep " a:keyWord " % \| lopen"
                return 
        endif
        let fileName2 = join( fileName , "\." )
        exe "lvimgrep " a:keyWord " " expand( "%:t" ) " " fileName2 "\| lopen"
endfunction

"}}}

command! -nargs=1 FA2 lvimgrep /\v<<args>>/ **/*.h **/*.cpp  **/*.c | lopen
command! -nargs=1 FA1 lvimgrep /\v<args>/ **/*.h **/*.cpp **/*.c | lopen
command! -nargs=1 FApy2 lvimgrep /\v<<args>>/  **/*.py | lopen
command! -nargs=1 FApy1 lvimgrep /\v<args>/ **/*.py | lopen

command! -nargs=1 FAphp2 lvimgrep /\v<<args>>/  **/*.php | lopen
command! -nargs=1 FAphp1 lvimgrep /\v<args>/ **/*.php | lopen

command! -nargs=1 FT lvimgrep /\v<args>/ % | lopen

function! SearchWithinVisualLine(Regex)
        let beginLine = line( "'<" ) - 1
        let endLine = line( "'>" ) + 1
        exec "lvimgrep /\\%>" . beginLine ."l\\%<" . endLine . "l\\v" . a:Regex .  "/ % | lopen" 
endfunction

command! -nargs=1 SearchInRange call SearchWithinVisualLine( <q-args> )
vnoremap <leader>se <esc>:SearchInRange 

nnoremap <leader>w viw"0y:tabnew<cr>:FA1 <C-R>0<cr>
nnoremap <leader>W viw"0y:call ShowList( "<C-R>0" )<cr>

nmap \fw "0yiw<c-w>w/<c-r>0<cr>
"}}}

" Just to control vim----------------{{{
"close current buffer
nnoremap <leader>q :q<cr>
"save current buffer
nnoremap <F2> :update<cr>
"open the file list in a new tab
nnoremap <F3> :tabnew .<cr>
"copy a word to clean board
nnoremap <leader>rw yiw:%s/\v<<C-R>0>/
nnoremap ;dw :echom "Error , not exist"<cr>
"delete all words of this 
nnoremap <leader>da :exe printf( '%%s/%s//g' , expand("<cword>") )<cr>

"Copy to the end of line 

nmap Y y$
"Give it to the command line and get it out .
nnoremap <leader>ss 0y$:<c-r>0<cr>
"Hight light cursor line or not 
map \l :set cursorline!<cr>
"run r.bat
map <F9> :w<cr>:!r<cr>
command! TAG !ctags -R .
" 'Good Bye' Save the current gvim settings
command GB mapclear| mksession! .\session.vim |  wqall
" 'Clean Sessions file'
command CS ! rm .\session.vim

"Gui setting
set guioptions-=m
set guioptions-=T

"add script block
iabbrev asb ----------------{{{<cr><cr>"}}}<esc>2kI"

inoremap jk <ESC>
inoremap JK <ESC>

inoremap <c-a> <esc>A
"}}}

" Say hi when a new file created----------------{{{
function! AddToSvn()
        write
        " exec "! svn add " . expand( "%:t" )
endfunction


augroup echo_group
        autocmd! 
        autocmd BufNewFile *.cpp :echo "Welcome to CPP word"
        autocmd BufNewFile *.java :echo "Welcome to Java word"
        autocmd BufNewFile *.py :echo "Welcome to Python word"
        autocmd BufNewFile *.h :call AddDefineProtectionToCppHeaderFile()
        autocmd BufWinLeave .bashrc :!source ~/.bashrc
        autocmd BufNewFile * :call AddToSvn()
        autocmd BufNewFile *.sh : exec "! chmod +x "  . expand( "%p" )
augroup END

autocmd InsertLeave * write

"autocmd InsertLeave *.vim source %
"}}}

" "Not gruoped yet butuseful----------------{{{


"This nnoremap will help us with good programming habit of thinking
"Clear all the info in the parameters


"remove the parameters in one function and edit it
nnoremap cp $F(ci(  <esc>i
"Just delete the parameters in one function
nnoremap dp $F(hdi(<esc>
"Body of the blocks, so we can take 'cb' , 'db' easily
onoremap b i{
"To the end of the line .for copy and cut.
onoremap . f.

"nnoremap <tab> /[,(>2<2\[\n]<cr>2l
"remove all the tabs in the file
nnoremap <leader>d<tab> :%s/[ \t]*//g<cr> 
nnoremap <leader>a<space> :%s/(/( /g<cr>:%s/)/ )/g<cr>:%s/,/ , /g<cr>

nnoremap <leader>i pkJ
nnoremap <leader>PP :set paste!<cr>a
nnoremap <leader>q :q<cr>

"Under line the current lines
autocmd CursorMoved * silent! exe printf('match _Underlined /\<%s\>/', expand('<cword>'))
autocmd CursorHold * silent! exe printf('match _Underlined /\<%s\>/', expand('<cword>'))
"}}}

"To imporove to fit google's programming standard TAG_todo
let g:currentProjName =  "NONAME00"
function! AddDefineProtectionToCppHeaderFile()
        let fileNameWithNoExtend = expand( "%:t:r" )
        let protectKey = g:currentProjName .  toupper( fileNameWithNoExtend ) . "_H_"
        call append( 0 , "\#ifndef " . protectKey )
        call append( 1 , "\#define " . protectKey )
        call append( line( "$" ) , "\#endif // " . protectKey )
        update
        execute "e  " . fileNameWithNoExtend . ".cpp"
        call AddToSvn()
        call AddIncludeOfCorrespondingHeaderFile()
        write
        execute "e  " . fileNameWithNoExtend . ".h"
        write
endfunction
function! H_CPP_pairCreate(fileName)
        exec "tabnew " . a:fileName . ".h"

        exec "edit " . a:fileName . ".cpp"
        call AddIncludeOfCorrespondingHeaderFile()
endfunction

command! -nargs=1 New call H_CPP_pairCreate("<args>")
function! AddIncludeOfCorrespondingHeaderFile()
        let headerName = expand( "%:t:r" ) . '.h'
        call append( 0 , "\#include \"" . headerName . "\"" )
endfunction 

command -nargs=0 HeaderAdd call AddIncludeOfCorrespondingHeaderFile()
command -nargs=0 HA HeaderAdd

"nnoremap \tv :tabnew f.h<cr>

"My Class Mydesign

" Just to test not used yet----------------{{{
let g:lastFile = ""
function JumpToDebugMsg()
        let g:lastFile =  expand( "%:p" )
        exe "e tmp2"
endfunction

function! JumpBackForDebug()
        exe "e " g:lastFile
endfunction

map \aa :call JumpToDebugMsg()<cr>ggyG:call JumpBackForDebug()<cr>gg/$$$<cr>pkdaw=i{

"edit r.bat
nnoremap <leader>er :tabnew t.sh<cr> 

"inoremap <cr> <esc>o;<esc>i
iabbrev vector vector< > $<ESC>2hi
iabbrev map map< , $ > $<ESC>7hi
iabbrev list list< > $ <ESC>F<a
iabbrev listi list< >::iterator $<esc>F<a

"Delete lines with this word
nnoremap <leader>dl yiw:%s/\v.*<C-R>0.*\n//<cr>
nnoremap <leader>da yiw:%s/<C-R>0//g<cr>
nnoremap <leader><leader>n :%s/\n\n//g<cr>
"}}}

"call pathogen#infect()

function! StrToList(theString)
        let theList = []
        for i in range( len( a:theString ) )
                call add( theList , a:theString[ i ] )
        endfor
        return theList
endfunction 

"for FFFIX protocol develop{{{
function! AddFixField(MsgName,FieldType)
        let l:tmpList = StrToList( a:FieldType )
        let l:tmpList[ 0 ] = tolower( l:tmpList[ 0 ] )
        let l:FieldName = join( tmpList  , '' )
        call append( line( '.' ) + 0 , "FIX::" . a:FieldType . " " . l:FieldName . ";"  )
        call append( line( '.' ) + 1 , "if ( true == " . a:MsgName . ".isSet( " . l:FieldName . " ) )" )
        call append( line( '.' ) + 2 , "{" )
        call append( line( '.' ) + 3 ,  a:MsgName . ".get( " . l:FieldName . " );" )
        call append( line( '.' ) + 4 , "}" )
        exe "normal! =5j"
endfunction

function! AddFixField2(MsgName,FieldType)
        let l:tmpList = StrToList( a:FieldType )
        let l:tmpList[ 0 ] = tolower( l:tmpList[ 0 ] )
        let l:FieldName = join( tmpList  , '' )
        call append( line( '.' ) + 0 , "FIX::" . a:FieldType . " " . l:FieldName . ";"  )
        call append( line( '.' ) + 1 ,  a:MsgName . ".get( " . l:FieldName . " );" )
        exec "normal! =2j"
endfunction

command! -nargs=* NewF call AddFixField( <f-args> )
command! -nargs=* NewF2 call AddFixField2( <f-args> )

"}}}
" {{{ begin of testing 

nnoremap ;w :match error /\v[ ]+$/<cr>
nnoremap ;q :match normal /\v[ ]+$/<cr>

let g:quickfix_is_open = 0
let g:quickfix_return_to_window = 0

function! QuickFixToggle()
        if g:quickfix_is_open
                cclose
                let g:quickfix_is_open = 0
                execute g:quickfix_return_to_window . 'wincmd w'
        else
                let g:quickfix_return_to_window = winnr()
                copen
                let g:quickfix_is_open = 1
        endif 
endfunction

"nnoremap <leader>qq :call QuickFixToggle()<cr>

"}}} end of test

" Loat local vim files once it exist----------------{{{
if filereadable( "./session.vim" )
        source ./session.vim
endif

if filereadable( "./posi.vim" )
        source posi.vim
endif

"}}}

vnoremap <leader>NN y:tabnew tmp.cpp<cr>ggp
iabbrev _fdm function define modified

function! VisualBlockReplace(From,To)
        exe "'<,'>s/\\<" . a:From . "\\>/" . a:To . "/g"
endfunction 

command -nargs=* ReplaceInVisualLines call VisualBlockReplace( <f-args> )
vnoremap <leader>r :<c-u>ReplaceInVisualLines <space>


function! GlobalReplace(From,To)
        exe "argdo %s/\\<" . a:From . "\\>/". a:To ."/g|update"
endfunction

command! -nargs=* ReplaceAll call GlobalReplace( <f-args> )

iabbrev spf sprintf($ , "$" , $ );<esc>I<c-l>
iabbrev snpf snprintf($ , $ , "$" , $ );<esc>I<c-l>
iabbrev fpf fprintf( stderr ,$ );<esc>I<c-l>
iabbrev pf printf($ );<esc>I<c-l>

nnoremap <leader>t<leader> :tabnew tmp<cr>
nnoremap <leader>tt :e tmp.cpp<cr> 

iabbrev _done //  ___________{ done }_________________ <esc>mA
vnoremap <leader>sv d?done<cr>P/done<cr>ko<esc>/fix_list<cr>

"Command lock and unlock
iabbrev todo to_do[ ]<esc>F[a
inoremap "" ""<esc>i
"complete in just this file
inoremap <c-j> <c-x><c-n>
nnoremap <leader>ep :tabnew posi.vim<cr>
nnoremap <leader>sp :source posi.vim<cr>


nnoremap <leader>st :source %<cr>
nmap <leader>add yy\hpA;<esc>
nmap <leader>f /<c-r>0<cr>

let EasyFilterPath = "~/easy"
command! -nargs=0 DAYLOG exec printf("tabnew %s/work_day_log" , EasyFilterPath )
iabbrev _log ____________________________<space><esc>:r !date/T<cr>____________________________<esc>
command! -nargs=0 NOTE exec printf("tabnew %s/tmp_work_note" , EasyFilterPath )
iabbrev _ti  ____________________________  ___________________________<esc>bbea
inoremap __+ cout << "____________________________" << endl;

" my code factory
"
" ____________________________ {{{
"Get Code
command! GC  read code_factory/code_production

"Make Code
command! MC exec "! cat source_code | awk -f " g:currentAwkFileName " > code_production "

"Close codeFactory
command! CF cd .. | tabclose! 

"View Code
command! VC !type .\code_factory\

"Create Code
command! -nargs=1 CC call OpenCodeFactory( "<args>" )

let g:currentAwkFileName = ""
 
function! OpenCodeFactory( creatorName )
        if ! filereadable( "code_factory/source_code" )
                exec "! mkdir code_factory"
                exec "! cp ~/.code_factory/* ./code_factory/"
                #exec "! svn add code_factory"
        endif
        let g:currentAwkFileName = a:creatorName . ".awk"
        tabnew code_factory/source_code
        exec "vsplit  code_factory/". g:currentAwkFileName

        if 1 == line( "." ) " when there is nohting in the file
                call append( 0 , "BEGIN{" )
                call append( 1 , "}" )
                call append( 2 , "{" )
                call append( 3 , "}" )
                call append( 4 , "END{" )
                call append( 5 , "}" )
        endif
        exec "normal! \<c-w>\<c-w>"
        split code_factory/code_production
        setlocal autoread
        exec "normal! \<c-w>\<c-h>"
        " move to the 3rd line 
        exec "3" 
        cd code_factory
        " fill the source code with the data visualed.
endfunction
"____________________________ }}}

" Remove comment
command! -nargs=0 RC %s/\v\/\/.*$// | %s/\/\*.*\*\///g
" Remove Empty line
command! -nargs=0 REL %s/\v^\s*\n//

" Remove Extra Blanks
command!-nargs=0 REB %s/\v\s+/\t/g


" Get current FileName 
" _todo  , this could be better , get the file name an path of relative current path
nnoremap \gf :let @0 = expand( "%:p" )<cr>
" omap a = gg to G
" To work with visual stdio
command! Rcfg tabnew ../Release/Config.ini
command! Dcfg tabnew ../Debug/Config.ini
command! Dfcfg tabnew ../Debug/*.cfg
command! Rsyb tabnew ../Release/Symbol.ini
command! Dsyb tabnew ../Debug/Symbol.ini

nnoremap nk :lnext<cr>zz
nnoremap nd :lprevious<cr>zz

"I shall classify my maps 
nnoremap <leader>ft yaw:FT <c-r>0<cr>

function! ShowFixAnsi(FixStr)
        let data1 = split( a:FixStr , '=' )
        let result= system( "get_fix_value " . data1[ 0 ] . " " . data1[ 1 ] )
        let result1= split( result , '\n' )
        return result1[ 1 ]
endfunction

noremap <silent> <leader>ga yiW:echom ShowFixAnsi( "<c-r>0" )<cr>

"Release Log
command! -nargs=0 RLOG call OpenLogAnsiTabpage( "..\\Release\\LogPath" )
"Debug Log
command! -nargs=0 DLOG call OpenLogAnsiTabpage( "..\\Debug\\LogPath"  )
function! OpenLogAnsiTabpage(_logpath)
        let logpath = a:_logpath
        let lspath = "c:\\gb_programming_tool\\cygwin64\\bin\\ls.exe"
        let filelist = split( system( lspath . ' ' . logpath ) , "\n" )
        for i in filelist
                if i =~# '\v.*\.txt'
                        let filename = i
                endif
        endfor
        tabnew tmp
        exec "normal! ggdG"
        exec "read " . logpath . "\\". filename
        exec "normal gg"
        exec printf( "%%s/%s/ /g" , "\001" )
        "%s/\v\:([0-9A-Za-z]+[ \=])/: \1/g
endfunction

inoremap <leader>b <esc>mzF,Byt `zp
inoremap <leader><leader>b <esc>mz2F,Byt `zp
inoremap <leader><leader><leader>b <esc>mz3F,Byt `zp
nnoremap <leader>yy mtggyG't
nnoremap <leader>tt mt0Wyw/endif<cr>f_PlC<esc>'t
"let's match it.

command! -nargs=0 Pro9 tabnew c:\songs\esunny_libs\TapProtocol9\
command! -nargs=0 Pro3 tabnew c:\songs\esunny_libs\Protocol\
inoremap _de  #ifdef DEBUG<cr>COUT_FUNC_NAME;<cr>cout << "" << endl;<cr>#endif // DEBUG<esc>=3k2jf"a
command! -nargs=0 CDFC cd c:\easy\gb_component_factory\
command! -nargs=0 Dmsg tabnew ..\Debug\message.ini


"----------{{{


function! GetEachLine(Reg,Fields)
        let result = []
        for line_num in range( line( "$" ) )
                let current_line = getline( line_num ) 
                if current_line =~# a:Reg  && current_line =~ g:header_sparator && current_line =~ g:field_saparator && current_line =~ g:field_value_key_spaparator "judge if it is log data
                        let tmp_list = split( current_line , g:header_sparator )
                        let message =  tmp_list[ 0 ] . g:header_sparator
                        call remove( tmp_list , 0 )
                        let tmp_str = join( tmp_list , g:header_sparator ) 
                        let line_arr = split( tmp_str , g:field_saparator )
                        for j in a:Fields
                                let j = "\\\v<" . j . ">" 
                                for i in line_arr
                                        if  i=~g:field_value_key_spaparator "In this field , the saparator may not exist
                                                let field_name = split( i , g:field_value_key_spaparator )[ 0 ]
                                                if field_name =~# j
                                                        let message = message .  i . g:field_saparator 
                                                endif 
                                        endif
                                endfor
                        endfor
                        let message = "line:" . line_num . " " . message
                        call add( result , message )
                endif
        endfor
        split log_insi
        normal ggdG
        for i in result
                call append( line( "$" ) , i )
        endfor 
endfunction

function! BuildArgs(Reg,...)
        let Fields = []
        let index = 1
        while index <= a:0
                call add( Fields , a:{index} )
                let index = index + 1
        endwhile 
        call GetEachLine(a:Reg,Fields)
endfunction
command! -nargs=* Ansi    let g:header_sparator =  ' '| let g:field_saparator = ',' | let g:field_value_key_spaparator = ':' | call BuildArgs(<f-args>)
command! -nargs=* YHAnsi  let g:header_sparator =  ']'| let g:field_saparator = ',' | let g:field_value_key_spaparator = ':' | call BuildArgs(<f-args>)
command! -nargs=* FIXAnsi let g:field_saparator = ' ' | let g:header_sparator = ' ' | let g:field_value_key_spaparator = '=' | call BuildArgs(<f-args>) 

"Read Ini
command! -nargs=1 RIni normal ! ggdG | read <args>
"}}}
"Rename the name of the class.h ,chancge #ifndef #ifdef ,cpp file name and  ,function name
onoremap [[ i[
onoremap {{ i{
onoremap (( i(
onoremap " i"
onoremap ' i'

iabbrev gbmodify // MODIFIED_BY_GB

" Code form format----------------{{{

"格式调整 找时间把这个弄成循环的 恩
"并且需要加强，用自己的缩进
"Old Version
"nmap \t   t,la<cr><ESC>  t,la<cr><ESC>  t,la<cr><ESC>  t,la<cr><ESC>  t,la<cr><ESC> 
nmap \t :call SetFunctionCallForm()<cr>

function! CreateEmptySpace(Length)
        echo a:Length
        let result = ""
        if 0 >= a:Length
                return result
        endif
        for i in range( a:Length )
                let result = result . " "
        endfor
        return result
endfunction

function! SetFunctionCallForm()
        normal 0f(
        let empty_space = CreateEmptySpace( col( "." ) )
        exec "s/\\v,/,\\r" . empty_space . "/g"
endfunction

"Move the comment at the end of this line to the top of this line

"}}}

"Switch the parameter position of c fucntion . 
"Only avaliable for two parameter in one pare of  '(', ')';
function! SwapParameter()
        normal 0f)hdi(
        let parameterList = split( @" , "," )
        let tmp = parameterList[ 0 ]
        let parameterList[ 0 ] = parameterList[ 1 ]
        let parameterList[ 1 ] = tmp
        let @" = join( parameterList , "," ) 
        normal 0f)hp
endfunction
command -nargs=0 SW call SwapParameter()

"Copy a function defination to the end of the current file
nnoremap <leader>rf mF<c-]>v/{<cr>%y'FGo<esc>p
"Copy a struct defination to the second line of the current file
nnoremap <leader>rs mF<c-]>v/}<cr>y'Fggo<esc>p

" Search in visual Range ----------------{{{
function! SearchWithinVisualLine(Regex)
        let beginLine = line( "'<" ) - 1
        let endLine = line( "'>" ) + 1
        exec "lvimgrep /\\%>" . beginLine ."l\\%<" . endLine . "l\\v" . a:Regex .  "/ % | lopen" 
endfunction
command! -nargs=1 SearchInRange call SearchWithinVisualLine( <q-args> )
vnoremap <leader>s <esc>:SearchInRange 
"  }}}
" not collect yet ----------------{{{
iabbrev // /* */<esc>2F*a
iabbrev alias alias='$'<esc>^f=i
iabbrev malloc ( * )malloc( $ * sizeof( $ ) )<esc>3F(a
iabbrev realloc ( * )realloc( $ , $ * sizeof( $ ) )<esc>3F(a
"<< ----------> <>
" add strncpy
"  }}}

function! Make4Winodw()
      split 
      vsplit 
      exec "normal \<c-w>j"
      vsplit 
      exec "normal \<c-w>k"
endfunction

nnoremap <leader>m4 :call Make4Winodw()<cr>
" main func of C
nnoremap <leader>bss yy:!<c-r>0<cr>
abbrev dowh do{<cr>} while( $ );<esc>?do<cr>
iabbrev frit for(::iterator it = $.begin() ;<cr> it != $.end() ;<cr> ++ it )<esc>2k0f:ljdwjdw2k0f:i


" for svn ----------------{{{
"
iabbrev _svn <esc>:call SvnLogAutoFill()<cr>
function! SvnLogAutoFill()
        call append( 0 ,  "[version]:  v0.1" )
        call append( 1 ,  "[modification]:" )
        call append( 2 ,  "1." )
        call append( 3 ,  "2." )
        exec "normal :3\<cr>"
endfunction
"  }}}
"
" Basic Setting----------------{{{
set number                      "Show line number 
set autoindent                   
set shiftwidth=8                "set number of spaces to use for each step of (auto)indent.
set tabstop=8                   "set number of spaces of one tab
set softtabstop=8               

set foldmethod=syntax           "The kind of folding used for the current window
set nobackup                    "Do not save backup file
set nolinebreak                 "Do not break a line
set nowritebackup               "Do not save bacup file while editing
set laststatus=2                "Always show the status
set statusline=%F\ -\ FileType:%y\ \ \ \ \ \ \ \ \ \ [Warnning\ \!\]\ IS\ IT\ THE\ PROBLEM\ OF\ ABILITY\ OR\ ATTUTUDE\?\ \ \ \ \ \ %l\/%L:%c
set textwidth=2000              "set line break to infinite
"set nohlsearch                 "Do note highlight search result
"set cursorline                  "highlight current line
set nocompatible
set splitright
set expandtab                   "Convert tab into space while inputing
set guifont=Courier\ 10\ Pitch\ 9

"}}}

" for_python ----------------{{{
iabbrev ifma if '__main__' ==  __name__ :<esc>
"  }}}"
"
let php_folding = 1

syntax on
filetype on
filetype plugin on
filetype indent on

iabbrev vd var_dump( );<esc>F(a
iabbrev pt print




iabbrev _form <form method=""<esc>A  action="$"><cr></form><esc>kf=
iabbrev _itext <input type="text"  name=""<esc>A><esc>=02f=
iabbrev _itextarea <input type="textarea"  name=""<esc>A><esc>=02f=
iabbrev _iradio  <input type="radio"  name=""<esc>A value="$"  ><esc>=02f=
iabbrev _isub  <input type="submit"  name=""<esc>A value="$"  ><esc>=02f=
iabbrev _html <html><cr><body><cr></body><cr></html><esc>3k
iabbrev _br <br><esc>

iabbrev span <span class="error"></span><esc>F"



autocmd FileType cpp   iabbrev if if ( ) {<cr>}<ESC>k3la
autocmd FileType c iabbrev if if ( ) {<cr>}<ESC>k3la
autocmd FileType python iabbrev if if :<esc>hi

autocmd FileType c   iabbrev bk break;<ESC>
autocmd FileType cpp  iabbrev bk break;<ESC>
autocmd FileType python iabbrev bk break<esc>

autocmd FileType c iabbrev wh while ($ ){<cr>$<cr>}<ESC>2k^/\$<cr>cw
autocmd FileType cpp iabbrev wh while ($ ){<cr>$<cr>}<ESC>2k^/\$<cr>cw
autocmd FileType python iabbrev wh while :<esc>Fea
