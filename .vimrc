"{{{ Vundle Stuff
filetype off
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'python-mode/python-mode'
Plugin 'scrooloose/syntastic'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-perl/vim-perl'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'jalvesaq/Nvim-R'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"}}}

"{{{ Java stuff

let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

"}}}

"{{{ Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings
set showcmd
set nocompatible
set autowrite
set foldmethod=marker
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*
set autoindent
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set wildmenu
set wildmode=list:longest,full
set mouse=a
set backspace=2
set number
set ignorecase
set smartcase
inoremap jj <Esc>
set incsearch
set hlsearch
set nohidden
highlight MatchParen ctermbg=4

" }}}

"{{{ Look and Feel

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Colors
let g:solarized_termtrans=0
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"
set background=light
colorscheme solarized

"}}}

"{{{ Functions

"{{{ Open URL in browser

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!konqueror ".line
endfunction

"}}}

" {{{ Paste Mode

let paste_mode = 0
function! Paste_on_off()
    if g:paste_mode == 0
        set paste
        let g:paste_mode = 1
    else
        set nopaste
        let g:paste_mode = 0
    endif
    return
endfunc

" }}}


"}}}

 "{{{ Mappings

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" Paste Mode
nnoremap <silent> PPP:call Paste_on_off()<CR>
set pastetoggle=PPP

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" DOS is for fools.
nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Edit gvimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Bracket Completion
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
map <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Set backup directories for vim -- MAKE THESE DIRECTORIES FIRST
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Delete trailing white space on save. Python, YAML
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd FileType python set nowrap

" Parens Completion
inoremap        (  ()<Left>
inoremap (<CR> {<CR>}<Esc>O
inoremap (( (
inoremap () ()
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

" Testing
set completeopt=longest,menuone,preview

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

"}}}

"{{{ Plugin Settings

" neocomplete
let g:neocomplete#enable_at_startup=1
let g:rct_completion_use_fri = 1
let g:Tex_ViewRule_pdf = "kpdf"

" Python Mode
let g:pymode_doc=1
let g:pymode_doc_key='?'
let g:pymode_lint=1
let g:pymode_lint_write=1
let g:pymode_lint_on_fly=1
let g:pymode_lint_message=0
let g:pymode_lint_checker=["pyflakes","pep8","mccabe"]
let g:pymode_virtualenv=1
let g:pymode_breakpoint=1
let g:pymode_breakpoint_bind='<leader>BB'
let g:pymode_syntax=1
let g:pymode_rope=1
let g:pymode_syntax_all=1
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_folding=1
let g:pymode_python='python3'

" NERD Tree Settings
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"}}}
