"{{{ Misc Settings
    set nocompatible              " We're using vim instead of vi for a reason!
    let mapleader=","             " , is easy and convenient
    set showmatch                 " Show matching brackets.
    set foldmethod=marker         " Folding
    let g:clipbrdDefaultReg = '+' " Copy-paste
    set ruler                     " I like knowing where I'm at
    set encoding=utf-8            " Yay, unicode!!!
    set termencoding=utf-8        " Yay, unicode!!
    scriptencoding utf-8          " Yay, unicode!
    set fileencoding=utf-8        " Yay, unicode...
    set wrap
    set linebreak
    set nolist
    set number
    set autowrite                 " Automatically save before commands like :next and :make
    set more                      " Use more prompt
    set autoread                  " Watch for file changes
    set lazyredraw                " don't redraw if unnecessary
    set scrolloff=5               " keep at least 5 lines above/below
    set sidescrolloff=5           " keep at least 5 lines left/right
    set cmdheight=2               " command line two lines high
    set undolevels=1000           " 1000 undos
    set updatecount=100           " write swap every 100 chars
    set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
    set ttyfast                   " we have a fast terminal
    set noerrorbells              " No error bells please
    set visualbell
    set t_vb=
    set shell=zsh                 " I like zsh
    set fileformats=unix
    set wildmode=longest:full
    set wildmenu                  " menu has tab completion
    set tags=tags;/
    "{{{ Backups and such
        set history=9001
        set backup
        set backupdir=~/.vim/backup
        set directory=~/.vim/tmp
        set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
    "
    "}}} EndBackups


    "}}} EndVundle
    "{{{ Syntax highlighting and indenting
        filetype on
        filetype plugin on
        filetype plugin indent on
        set autoindent
        syntax enable
        set grepprg=grep\ -nH\ $* "???

        " Highlight cursorline
        set cursorline
        hi CursorLine term=none cterm=none ctermbg=8

        " flips syntax highlighting
        set background=dark
    "}}} end Syntax

    "{{{ Tabs and indentation
        set expandtab
        set smarttab
        set shiftwidth=4
        set softtabstop=4
        set tabstop=4
    "}}} endTabs

    "{{{ Use cases nicely
        set ignorecase
        set smartcase
    "}}} end UseCases

    "{{{ Use english for spellchecking, but not by default.
        if version >=700
            set spl=en spell
            set nospell
        endif
    "}}} endSpellcheck

    "{{{ Searching
        set incsearch
        set hlsearch
        set diffopt=filler,iwhite     " ignore all whitespace and sync
    "}}} endSearching
"}}} endMisc
"{{{"Statusline
    set showmode                  " Show mode in status line
    set showcmd                   " Show (partial) command in status line.

    " set laststatus=2
    " set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
    "{{{ StatuslineCurrentHighlight
        "return the syntax highlight group under the cursor
        function! StatuslineCurrentHighlight()
            let name = synIDattr(synID(line('.'),col('.'),1),'name')
            if name == ''
                return ''
            else
                return '[' . name . ']'
            endif
        endfunction
    "}}} endstatusline high

    "{{{StatuslineLongLineWarning
        "return a warning for "long lines" where "long" is either &textwidth or 80
        "(if"no &textwidth is set)
        "return '' if no long lines
        "return '[#x,:y,$z] if long lines are found, were x is the number of long
        "lines, y is the longest line numbr and z is the length of the
        "longest line
        function! StatuslineLongLineWarning()
            if !exists("b:statusline_long_line_warning")
                if !&modifiable
                    let b:statusline_long_line_warning
                endif
                let i = 0
                let long_line_lens =s:LongLines()
                let longest_line=s:LongestLine()
                    if len(long_line_lens) > 0
                        let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . ","
                        \ .':' . longest_line . "," .
                        \ '$' . max(long_line_lens) . "]"
                    else
                        let b:statusline_long_line_warning = ""
                    endif
                endif
            return b:statusline_long_line_warning
        endfunction
    "}}} end at statuslinelong
    "{{{ s:LongestLine
        "return the longest line's number in this buffer
        function! s:LongestLine()
            let i = 0
            let spaces = repeat(" ", &ts)
            let longest_line = 0
            let longest_len = 0
            while i <= line("$")
                let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
                if len > longest_len
                    let longest_len = len
                    let longest_line = i
                endif
                let i += 1
            endwhile
            return longest_line
        endfunction
    "}}} End s:LongestLine
    "{{{ s:LongLines()
        "return a list containing the lengths of the long lines in this buffer
        function! s:LongLines()
            let threshold = (&tw ? &tw : 80)
            let spaces = repeat(" ", &ts)
            let long_line_lens = []
            let i = 0
            while i <= line("$")
                let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
                if len > threshold
                    call add(long_line_lens, len)
                endif
                let i += 1
            endwhile
            return long_line_lens
        endfunction
    "}}} End s:LongLines

"{{{ statusline=...
    set statusline=%f "tail of the filename
    "display a warning if fileformat isn't unix
    set statusline+=%#warningmsg#
    set statusline+=%{&ff!='unix'?'['.&ff.']':''}
    set statusline+=%*
    "display a warning if file encoding isn't utf-8
    set statusline+=%#warningmsg#
    set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
    set statusline+=%*

    set statusline+=%h "help file flag
    set statusline+=%y "filetype
    set statusline+=%r "read only flag
    set statusline+=%m "modified flag
    if exists("*StatuslineLongLineWarning")
        set statusline+=%{StatuslineLongLineWarning()}
    endif
    if exists("*SyntasticStatuslineFlag")
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
    endif
    "{{{ display a warning if &paste is set
        set statusline+=%#warningmsg#
        set statusline+=%{&paste?'[paste]':''}
        set statusline+=%*
        set statusline+=%= "left/right separator
    "}}} End display
    function! SlSpace()
        if exists("*GetSpaceMovement")
            return "[" . GetSpaceMovement() . "]"
        else
            return ""
        endif
    endfunc
    set statusline+=%{SlSpace()}
    set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
    set statusline+=%c, "cursor column
    set statusline+=%l/%L "cursor line/total lines
    set statusline+=\ %P "percent through file
    set laststatus=2
    "}}} end statusline=
"}}} endStatus

"{{{Auto Commands
    set autochdir
    "recalculate the long line warning when idle and after saving
    autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

    " No trailing whitespace
    autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

    " Tab --> 4 spaces in the file
    autocmd BufRead,BufWrite * if ! &bin | silent! %s/\t/    /g | endif

    " Scons is python syntax
    autocmd BufReadPre,BufNewFile SConstruct set filetype=python
    autocmd BufReadPre,BufNewFile SConscript set filetype=python

    " set shell region height
    let g:ScreenShellHeight = 12


    "{{{ Restore cursor position upon reopening file
    augroup JumpCursorOnEdit
         au!
         autocmd BufReadPost *
         \   if expand("<afile>:p:h") !=? $TEMP |
         \      if line("'\"") > 1 && line("'\"") <= line("$") |
         \          let JumpToLine = line("'\"") |
         \          let b:doopenfold = 1 |
         \          if (foldlevel(JumpToLine) > foldlevel(JumpToLine - 1)) |
         \              let JumpToLine = JumpToLine - 1 |
         \              let b:doopenfold = 2 |
         \          endif |
         \          exe JumpToLine |
         \       endif |
         \   endif
    " Need to postpone using "zv" until after reading the modelines.
    autocmd BufWinEnter *
         \ if exists("b:doopenfold") |
         \     exe "normal zv" |
         \     if(b:doopenfold > 1) |
         \          exe  "+".1 |
         \     endif |
         \     unlet b:doopenfold |
         \ endif
    augroup END "}}}

"}}} EndAutocmd


"{{{ Functions
    "{{{ Mosh tab or complete()
        function! Mosh_Tab_Or_Complete()
            if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
                return "\<C-N>"
            else
                return "\<Tab>"
        endfunction
        inoremap <Tab> <C-R>=Mosh_Tab_Or_Complete()<CR>
    "}}} end Mosh tab or complete()
    "{{{ Open URL in browser
        function! Browser ()
            let line = getline (".")
            let line = matchstr (line, "http\S*")
            exec "!chromium ".line
        endfunction
        " Open Url on this line with the browser \w
        map <Leader>w :call Browser ()<CR>
    "}}} end open url in browser
    "{{{ make with all cores
        if filereadable('/proc/cpuinfo')
            let &makeprg = 'make -j'.(system('grep -c ^processor /proc/cpuinfo')+1)
        endif
    "}}} end make with all cores

    "{{{ Paste mode
        " Paste Mode!  Dang! <F10>
        nnoremap <silent> <F10> :set invpaste<CR>
        set pastetoggle=<F10>
    "}}} end Paste mode


   "{{{ Edit vimrc, gvimrc, etc
        " Edit vimrc \ev
        nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>
        " Edit gvimrc \gv
        nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

    "}}} end edit rc

    "{{{ Movement
    ": jj, ldru, mouse
        set mouse=a        " Enable mouse usage (all modes)
        inoremap jj <Esc>

        " Up and down are more logical with g..
        vnoremap <silent> k gk
        vnoremap <silent> j gj
        nnoremap <silent> k gk
        nnoremap <silent> j gj

        " Home and End keys work
        nnoremap <silent> <Home> ^i
        nnoremap <silent> <End> A
    "}}} end movement
    "{{{ Toggle folds
        " Space, <CR> will toggle folds
        vnoremap <space> za<space>
        nnoremap <space> za<space>
        nnoremap <CR> za<CR>
        vnoremap <CR> za<CR>
    "}}} End toggle folds
    "{{{ Searching centers you on line
        " Search mappings: These will make it so that going to the next one in a
        " search will center on the line it's found in.
        map N Nzz
        map n nzz
    "}}} end searching
    "{{{
    "Swap ; and :  Convenient.
        nnoremap ; :
        nnoremap : ;
        vnoremap ; :
        vnoremap : ;:
        nore ; :
        nore , ;
    "}}} end swap ; and :

    " TODO Mode
    nnoremap <silent> <Leader>todo :execute TodoListMode()<CR>

    " Open the TagList Plugin <F3>
    nnoremap <silent> <F3> :Tlist<CR>

    " DOS is for fools.
    nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

    " Create Blank newlines and stay in Normal mode
    nnoremap <silent> zj o<Esc>
    nnoremap <silent> zk O<Esc>

    " Testing
    set completeopt=longest,menuone,preview

    " Fix email paragraphs
    nnoremap <leader>par :%s/^>$//<CR>

"}}} end functions
