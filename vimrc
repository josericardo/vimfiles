set nocompatible
let mapleader=","

" Per-directory .vimrc files
set exrc
set secure

""""""""""""""""""""""""""""""""""""""""
" Vundle Setup
""""""""""""""""""""""""""""""""""""""""
filetype off                   " required! by vundler

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle (required!)
Plugin 'VundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'editorconfig/editorconfig-vim'
call vundle#end()

filetype plugin indent on    " required
""""""""""""""""""""""""""""""""""""""""

" make Python plugin Jedi minimally annoying
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_assignments_command = 'gd'
let g:jedi#goto_command = 'gD'
let g:jedi#popup_on_dot = 0
let g:jedi#rename_command = "<leader>rr"
let g:jedi#smart_auto_mappings = 0

" gist-vim configuration
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

let g:syntastic_python_checkers=['pyflakes']

set diffopt+=vertical " specially for Gdiff

call pathogen#infect()

augroup General
  autocmd!
  au BufWritePost .vimrc so ~/.vimrc
augroup END

filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
" enter just selects the selected item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

colorscheme github
set nocompatible " be improved
set nomodeline
set t_Co=256

" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch

" splitting more naturally
set splitbelow
set splitright

" removes the highlight of the previous search
set hlsearch

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set switchbuf=useopen
set numberwidth=5
set number
set showtabline=2
set winwidth=79
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
setlocal cm=blowfish2

" status line
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

nnoremap j gj
nnoremap k gk
noremap : ;
noremap ; :
noremap , _

nnoremap <Leader>/ :nohlsearch<cr>
" replace with blank start
nnoremap <Leader>sv :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
" replace with the current word as a start
nnoremap <Leader>ss :%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>
nnoremap <Leader>a :Ack!
nnoremap <Leader>gac :Gwrite<CR> <bar> :Gcommit -v<CR> <bar> ,max
nnoremap <Leader>spell :set spell! spell?<CR>
nnoremap <Leader>vv :vsplit $MYVIMRC<cr>
nnoremap <Leader>vl :so $MYVIMRC<cr>
nnoremap <Leader>paste :set paste!<cr>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Zooms current split
nnoremap <Leader>max :wincmd _ <bar> wincmd <bar><CR>

" reopens the last buffer
noremap <Leader><Leader> <C-^>

" Bubble single lines
nnoremap <C-Up> [e
nnoremap <C-Down> ]e

" Bubble multiple lines
vnoremap <C-Up> [egv
vnoremap <C-Down> ]egv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

let g:ctrlp_arg_map = 1
let g:ctrlp_working_path_mode = 0

set viminfo='100,\"100,:20,%,n~/.viminfo

augroup IDE
  autocmd!

  function! PyTestPathAsModule()
    return shellescape(substitute(substitute(expand('%'), '.py', '', 'g'), '/', '.', 'g'))
  endfunction

  " My universal IDE :D
  au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
  "autocmd BufWritePost *.py call Flake8()
  au BufNewFile,BufRead *.py noremap <Leader>r :w!<cr>:!python %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>rj :w!<cr>:!python % < input<cr>
  au BufNewFile,BufRead *.py noremap <Leader>ri :w!<cr>:!ipython -i %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>rl :w!<cr>:!ipython --pylab -i %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>i :w!<cr>:!ipython<cr>
  au BufNewFile,BufRead *.py noremap <Leader>e :w!<cr>:!python -c 
  au BufNewFile,BufRead *.py noremap <Leader>pt :w!<cr>:!nosetests -s --with-doctest %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>f8 :w!<cr>:!flake8 %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>pl :w!<cr>:Shell pylint %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>pe :w!<cr>:Shell pylint -E %<cr> 
  au BufNewFile,BufRead *.py noremap <Leader>nt :w!<cr>:NosetestFile<cr> 
  au BufNewFile,BufRead *.py noremap <Leader>nm :w!<cr>:NosetestMethod<cr> 
  au BufNewFile,BufRead *.py noremap <Leader>dt :w!<cr>:exec '!python manage.py test ' . PyTestPathAsModule() <cr>
  au BufNewFile,BufRead *_test.py noremap <Leader>r :w!<cr>:exec '!python -m ' . PyTestPathAsModule() <cr>
  au BufNewFile,BufRead *.py,*.rb noremap <Leader>out :!grep -w '^[ ]*class\\|^[ ]*def' %<cr>
  au BufWritePre *.py,*.rb :%s/\s\+$//e

  function! PyTestName()
    return shellescape(substitute(expand('%:t:r'), '_test', '', 'g') . '_test.py')
  endfunction

  au BufNewFile,BufRead *.py noremap <Leader>t :echo system('find . -iname ' .
        \ PyTestName() . ' <bar> xargs nosetests -s -v ')<CR>

  au BufNewFile,BufRead *.py noremap <Leader>ta :w!<cr>:!nosetests<cr>
  au BufNewFile,BufRead *.py nnoremap <buffer> K :<C-u>let save_isk = &iskeyword \|
      \ set iskeyword+=. \|
      \ execute "!pydoc " . expand("<cword>") \|
      \ let &iskeyword = save_isk<CR>
augroup END

" Remove trailing white space
noremap <Leader>rtws :%s/\s\+$//e<cr>

" Some stuff stolen from aurelio:
" http://aurelio.net/doc/dotfiles/vimrc.txt

" Keeping myself sane
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq

if filereadable(".vim.custom")
  so .vim.custom
endif

if filereadable("../.vim.custom")
  so ../.vim.custom
endif

set nobackup
set noswapfile

set wildignore+=*.pyc

ab :shrug: ¯\_(ツ)_/¯
hi IncSearch cterm=NONE ctermfg=black ctermbg=green
