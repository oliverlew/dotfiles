" Plugin Manager {{{
" Vim-Plug {{{
" automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" begin vim-plug
call plug#begin('~/.vim/bundle')
" the Vundle plugin it self
Plug 'VundleVim/Vundle.vim'
" CtrlP
Plug 'ctrlpvim/ctrlp.vim'
" Nerd plugin series
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
" markdown plugins
Plug 'godlygeek/tabular' " this plugin must be before vim-markdown
Plug 'plasticboy/vim-markdown'
" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" surround-vim
Plug 'tpope/vim-surround'
" theme
Plug 'morhetz/gruvbox'
" leader guide like in spacevim
Plug 'liuchengxu/vim-which-key'
" linter plugin
Plug 'w0rp/ale'
"  asynchronous run tasks in parallel
Plug 'skywind3000/asyncrun.vim'
" tag bar
Plug 'majutsushi/tagbar'
" supertab
Plug 'ervandew/supertab'
" vimtex plugin
Plug 'lervag/vimtex'
" mathematica
Plug 'rsmenon/vim-mathematica'
" fcitx
Plug 'lilydjwg/fcitx.vim'
" vim-slime
Plug 'jpalardy/vim-slime'
" gpg plugin
Plug 'jamessan/vim-gnupg'
call plug#end()
" }}}
" }}}
" Vim Settings {{{
" Vim Config {{{
" be iMproved
set nocompatible
" leader key
let mapleader = ','
let maplocalleader = '\'
" syntax
syntax on
" filetype
filetype on
filetype plugin on
filetype indent on
" auto reload files
set autoread
" set vim folder
let $VIM='~/.vim/'
" set encoding
set encoding=utf-8
" use x11 normal clipboard
set clipboard=unnamedplus
" automatically write a file when leaving a buffer
set autowrite
" time out for key code delays, decide how long to wait for key code
" sequence and how long leader guide (if installed) will pop up.
set timeoutlen=300
set ttimeoutlen=0
" open diff window vertically
set diffopt+=vertical
" }}}
" UI basic {{{
" gui options
set guioptions=ci
set guifont=Hack\ 12
" show line number
set number
" enable mouse support in console
set mouse=a
" highlight current line
set cursorline
" color the 80th column
set colorcolumn=80
" shows what you are typing as a command
set showcmd
" turn on wild menu on :e <Tab>
set wildmenu
" change the terminal's title
set title
" show matching characters
set showmatch
" minimum lines above and below cursor
set scrolloff=5
" split into right by default
set splitright
" update time
set updatetime=100
" redraw when needed
set lazyredraw
" don't beep
set noerrorbells
" }}}
" Space Tabs Indentations {{{
" indentations
set autoindent
set smartindent
set cindent
" tabs
set tabstop=4
set shiftwidth=0  " make it the same as tabstop
set softtabstop=-1  " make it the same as shiftwidth
set expandtab
set smarttab
" show tabs and trailing whitespace
set list
set listchars=tab:>-,trail:.
" }}}
" Search {{{
" incremental search
set incsearch
" case-insensitive search
set ignorecase
" smart case search(only when search pattern has no capital letters)
set smartcase
" highlight search
set hlsearch
" }}}
" Navigations {{{
" go up/down
nnoremap <silent> j gj
nnoremap <silent> k gk
" buffers
nnoremap <silent> <C-H> :bprevious<CR>
nnoremap <silent> <C-L> :bnext<CR>
" toggle fold
nnoremap <space> za
" }}}
" Autocmd {{{
autocmd BufWritePost *Xresources :!xrdb %
" Automatically deletes all trailing whitespace on save. (Thanks Luke!)
autocmd BufWritePre * %s/\s\+$//e
" }}}
" }}}
" Plugin Settings {{{
" Vim Which Key {{{
let g:which_key_use_floating_win = 0
let g:which_key_map = {
  \ 'c' : { 'name' : '+commenting' },
  \ 'q' : [ ':q', 'quit (all)'],
  \ 'Q' : [ ':q!', 'quit without saving'],
  \ 'w' : [ ':w',  'save'],
  \ 'e' : [ ':e',  'edit (reload)'],
  \ 'x' : [ ':x',  'save and quit'],
  \ '.' : [ ':let @/=""', 'clear search hl'],
  \ 'r' : [ ':so $MYVIMRC', 'reload vimrc'],
  \ }
let g:which_key_map_local = {
  \ 'l' : { 'name' : '+vimtex' }
  \ }
nnoremap <silent> <leader> :WhichKey '<leader>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<leader>'<CR>
nnoremap <silent> <localleader> :WhichKey '<localleader>'<CR>
vnoremap <silent> <localleader> :WhichKeyVisual '<localleader>'<CR>
call which_key#register(mapleader, "g:which_key_map")
call which_key#register(maplocalleader, "g:which_key_map_local")
" }}}
" Markdown {{{
"set conceallevel=2
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
" }}}
" Airline {{{
let g:airline#extensions#tabline#enabled   = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ale#enabled       = 1
let g:airline_theme                        = 'gruvbox'
let g:airline_powerline_fonts              = 1
let g:airline_highlighting_cache           = 0
" }}}
" Fugitive {{{
" wrote this by my own, show the log in a pretty way
function! GitRepoLogAll()
    silent Git log --all --decorate --oneline --graph --date-order
    redraw!
endfunction
" key bindings
let g:which_key_map.g = {
  \ 'name' : '+git-operation',
  \ 'b' : [ '!git branch -a', 'git show branch' ],
  \ 'd' : [ ':Gvdiff', 'git diff' ],
  \ 'c' : [ ':Gcommit -v', 'git commit' ],
  \ 's' : [ ':Gstatus', 'git status' ],
  \ 'l' : [ ':call GitRepoLogAll()', 'git show log' ],
  \ 'u' : [ ':Gpush', 'git push' ],
  \ 'f' : [ ':Gpull', 'git pull' ],
  \ 't' : {
    \ 'name' : '+stash',
    \ 's' : [ ':Git stash', 'git stash' ],
    \ 'p' : [ ':Git stash pop', 'git stash pop' ],
    \ 'l' : [ ':Git stash list', 'git stash list' ]
    \ }
  \ }
" }}}
" Gitgutter {{{
" the previous ~_ take two columns
let g:gitgutter_sign_modified_removed   = '^'
" update signs after focus
let g:gitgutter_terminal_reports_focus  = 0
" always show sign column
set signcolumn=yes
" }}}
" ALE {{{
"let g:ale_completion_enabled = 1
let g:ale_sign_column_always   = 1
let g:ale_sign_error           = '>'
let g:ale_sign_warning         = '-'
" only lint when leaving insert mode
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
" specify linters
let g:ale_linters = {
  \ 'c': ['gcc'],
  \ 'python': ['flake8']
  \ }
let g:ale_c_gcc_options = "-std=c11 -Wall -lncurses"
" Keymapping
let g:which_key_map.a = {
  \ 'name' : '+ale',
  \ 'j' : [ '<Plug>(ale_next_wrap)' , 'go to next ale mark' ],
  \ 'k' : [ '<Plug>(ale_previous_wrap)' , 'go to previous ale mark' ],
  \ }
" }}}
" Nerdtree {{{
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
nnoremap <C-N> :NERDTreeToggle<CR>
" }}}
" Asyncrun {{{
let g:asyncrun_open = 8
" fugitive related, see official website
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
" vim-airline
let g:asyncrun_status = ''
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
" }}}
" Vim Tex Settings {{{
" enable vimtex fold
let g:vimtex_fold_enabled = 1
" start vim with a server, see ':h vimtex-clientserver'
if empty(v:servername) && exists('*remote_startserver') && !empty($DISPLAY)
  call remote_startserver('VIM')
endif
" viewer setting
let g:vimtex_view_method = 'zathura'
" matching delimiters is causing performance issues
let g:vimtex_matchparen_enabled = 0
" compiler
let g:vimtex_compiler_method = "latexmk"
" compiler engine
let g:vimtex_compiler_latexmk_engines = {
        \ '_'                : '-xelatex',
        \ 'pdflatex'         : '-pdf',
        \ 'dvipdfex'         : '-pdfdvi',
        \ 'lualatex'         : '-lualatex',
        \ 'xelatex'          : '-xelatex',
        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
        \ 'context (luatex)' : '-pdf -pdflatex=context',
        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
        \}
" }}}
" Mathematica {{{
let g:mma_candy = 1
autocmd BufNewFile,BufRead *.wl setfiletype mma
autocmd BufNewFile,BufRead *.wls setfiletype mma
" }}}
" ibus-vim {{{
let g:ibus#layout = "xkb:us::eng"
let g:ibus#engine = "libpinyin"
" }}}
" fcitx {{{
" }}}
" Theme solarized, gruvbox {{{
colorscheme gruvbox
let g:gruvbox_italic      = 1
let g:gruvbox_sign_column = "bg0"
let g:solarized_underline = 0
set background=dark
" }}}
" vim-slime {{{
" use tmux
"let g:slime_target = "tmux"
" set config to use the pane on the right by default
"let g:slime_default_config = {
    "\ "socket_name": "default",
    "\ "target_pane": "{right-of}"
    "\ }
" or use vim :terminal
let g:slime_target = "vimterminal"
" vim terminal config
let g:slime_vimterminal_config = {
    \ "vertical": 1
    \ }
let g:slime_dont_ask_default = 1
" use temp file
let g:slime_paste_file = tempname()
" ipython specific setting
let g:slime_python_ipython = 1
" }}}
" }}}
" vim:foldmethod=marker:foldlevel=1
