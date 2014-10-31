set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'Shougo/neocomplete.vim'
Bundle 'fatih/vim-go'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'

filetype plugin indent on
filetype on

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

if filereadable(expand("~/.vim/colors/visualstudio.vim"))
    color visualstudio
else
    color murphy
endif

set backup                      " Backups are nice ...
if has('persistent_undo')
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif
if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
endif
if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    set statusline=%{getcwd()}:              " Current dir
    set statusline+=[%t]\                      " Filename
    set statusline+=%w%h%m%r                 " Options
    "set statusline+=\ [%{&ff}/%Y]           " Filetype
    set statusline+=%=%-14.(%l\ of\ %L,%c%V%)\ %p%%  " Right aligned file nav info
    " Show tab number and filename in tab title
    set guitablabel=\[%N\]\ %t\ %M
endif

" highlight the current line in insert mode
au InsertEnter * set cursorline
au InsertLeave * set nocursorline

syntax on
set autoindent
set backspace=indent,eol,start  " Backspace for dummies
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
set expandtab                   " Tabs are spaces, not tabs
set foldenable                  " Auto fold code
set history=1000                " Store a ton of history (default is 20)
set hidden                      " Allow buffer switching without saving
set hlsearch                    " Highlight search terms
set ignorecase                  " Case insensitive search
set incsearch                   " Find as you type search
set linespace=0                 " No extra spaces between rows
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
"set matchpairs+=<:>             " Match, to be used with %
set modeline
set mouse=a
set nocursorline                " Do not Highlight current line
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set nowrap                      " Wrap long lines
set number                      " Line numbers on
set omnifunc=syntaxcomplete#Complete
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set shiftwidth=2                " Use indents of 2 spaces
set showmatch                   " Show matching brackets/parenthesis
set showmode                    " Display the current mode
set smartcase                   " Case sensitive when uc present
set softtabstop=2               " Let backspace delete indent
set spell                       " Spell checking on
set splitbelow                  " Puts new split windows to the bottom of the current
set splitright                  " Puts new vsplit windows to the right of the current
set tabpagemax=15               " Only show 15 tabs
set tabstop=2                   " An indentation every two columns
set winminheight=0              " Windows can be 0 line high
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

" Remove trailing whitespaces and ^M chars
autocmd FileType go,javascript,python autocmd BufWritePre <buffer> call StripTrailingWhitespace()
"autocmd FileType go autocmd BufWritePre <buffer> GoFmt
let g:go_fmt_options = '-tabs=false -tabwidth=2'


" tab navigation using Ctrl-Left/Right
nnoremap <C-left>  :tabprevious<CR>
nnoremap <C-right> :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>

let mapleader = ','
" fast tabnew
nmap <leader>. :tabnew 
" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$
" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>
" toggle search highlighting rather than clear the current
nmap <silent> <leader>/ :set invhlsearch<CR>
" quick jumping to next and previous errors
nmap <leader>n :lnext<CR>
" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0
" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        set columns=90
        if has("gui_gtk2")
            set guifont=Consolas\ Regular\ 11,Courier\ New\ Regular\ 10
        elseif has("gui_mac")
            set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
        elseif has("gui_win32")
            set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
        endif
        if has('gui_macvim')
            set transparency=5      " Make the window slightly transparent
        endif
        " show a different color after 80 columns
        let &colorcolumn=join(range(81,999),",")
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }
" Plugins

    " NerdTree {
        map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        map <leader>e :NERDTreeFind<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " ctrlp {
        let g:ctrlp_map = '<c-p>'
        let g:ctrlp_cmd = 'CtrlP'
        let g:ctrlp_working_path_mode = 'ra'
        " open result in new tab
        let g:ctrlp_prompt_mappings = {'AcceptSelection("t")': ['<cr>'], 'AcceptSelection("e")': ['<c-x>']}
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

        " On Windows use "dir" as fallback command.
        if has('win32') || has('win64')
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': 'dir %s /-n /b /s /a-d'
            \ }
        else
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': 'find %s -type f'
            \ }
        endif

        if executable('ag')
          " Use ag over grep
          set grepprg=ag\ --nogroup\ --nocolor

          " remove previous setting of var
          unlet g:ctrlp_user_command
          " Use ag in CtrlP for listing files. Lightning fast and
          " respects .gitignore
          let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

          " ag is fast enough that CtrlP doesn't need to cache
          let g:ctrlp_use_caching = 0
        endif
    "}

    " Ag {
        " bind leader,k to grep word under cursor
        nnoremap <leader>k :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
    "}
    "
    " syntastic {
        let g:syntastic_always_populate_loc_list = 1
    "}

    " neocomplete {
      let g:acp_enableAtStartup = 0
      let g:neocomplete#enable_at_startup = 1
      let g:neocomplete#enable_smart_case = 1
      let g:neocomplete#enable_auto_delimiter = 1
      let g:neocomplete#max_list = 15
      let g:neocomplete#force_overwrite_completefunc = 1

      " SuperTab like snippets behavior.
      imap <silent><expr><TAB> neosnippet#expandable() ?
                  \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                  \ "\<C-e>" : "\<TAB>")
      smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

      " Define dictionary.
      let g:neocomplete#sources#dictionary#dictionaries = {
                  \ 'default' : '',
                  \ 'vimshell' : $HOME.'/.vimshell_hist',
                  \ 'scheme' : $HOME.'/.gosh_completions'
                  \ }

      " Define keyword.
      if !exists('g:neocomplete#keyword_patterns')
          let g:neocomplete#keyword_patterns = {}
      endif
      let g:neocomplete#keyword_patterns['default'] = '\h\w*'

      " Plugin key-mappings {
          " These two lines conflict with the default digraph mapping of <C-K>
          " If you prefer that functionality, add the following
          "   let g:_no_neosnippet_expand = 1
          if !exists('g:_no_neosnippet_expand')
              imap <C-k> <Plug>(neosnippet_expand_or_jump)
              smap <C-k> <Plug>(neosnippet_expand_or_jump)
          endif

          inoremap <expr><C-g> neocomplete#undo_completion()
          inoremap <expr><C-l> neocomplete#complete_common_string()
          inoremap <expr><CR> neocomplete#complete_common_string()

          " <TAB>: completion.
          inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
          inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

          " <CR>: close popup
          " <s-CR>: close popup and save indent.
          inoremap <expr><s-CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
          inoremap <expr><CR> pumvisible() ? neocomplete#close_popup()."\<CR>" : "\<CR>"

          " <C-h>, <BS>: close popup and delete backword char.
          inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
          inoremap <expr><C-y> neocomplete#close_popup()
      " }

      " Enable omni completion.
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
      autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
      autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

      " Haskell post write lint and check with ghcmod
      " $ `cabal install ghcmod` if missing and ensure
      " ~/.cabal/bin is in your $PATH.
      if !executable("ghcmod")
          autocmd BufWritePost *.hs GhcModCheckAndLintAsync
      endif

      " Enable heavy omni completion.
      if !exists('g:neocomplete#sources#omni#input_patterns')
          let g:neocomplete#sources#omni#input_patterns = {}
      endif
      let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
      let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
      let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
      let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
      let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

      " Use honza's snippets.
      let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

      " Enable neosnippet snipmate compatibility mode
      let g:neosnippet#enable_snipmate_compatibility = 1

      " For snippet_complete marker.
      if has('conceal')
          set conceallevel=2 concealcursor=i
      endif

      " Disable the neosnippet preview candidate window
      " When enabled, there can be too much visual noise
      " especially when splits are used.
      set completeopt-=preview
    " }

" Functions {

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        let common_dir = $HOME . '/.vim/' . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        if !exists('g:_keep_trailing_whitespace')
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endif
    endfunction
    " }
"}
