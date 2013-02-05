call pathogen#infect()

set nocompatible
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

" removes the highlight of the previous search
set hlsearch
:map ,/ :nohlsearch<cr>

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
let mapleader=","

" status line
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" tell vim to use the rspec compiler for all *_spec.rb files by adding this line to your vimrc
au BufNewFile,BufRead *_spec.rb compiler rspec
au BufNewFile,BufRead *_spec.rb setl makeprg=rspec
au BufNewFile,BufRead *_spec.rb map ,t :w!<cr>:!rspec %<cr>
au BufNewFile,BufRead *.rb map ,t :w!<cr>:!rspec %:r_spec.rb<cr>
au BufNewFile,BufRead *.py map <Leader>t :w!<cr>:!nosetests<cr>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

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
map <leader>n :call RenameFile()<cr>

cnoremap %% <C-R>=expand('%:h').'/'<cr>

" reopens the last buffer
map ,, <C-^>

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

au BufWritePost .vimrc so ~/.vimrc

let g:ctrlp_arg_map = 1

nmap <C-W>! <Plug>Kwbd

" Map Control-# to switch tabs
map <C-0> 0gt
imap <C-0> <Esc>0gt
map <C-1> 1gt
imap <C-1> <Esc>1gt
map <C-2> 2gt
imap <C-2> <Esc>2gt
map <C-3> 3gt
imap <C-3> <Esc>3gt
map <C-4> 4gt
imap <C-4> <Esc>4gt
map <C-5> 5gt
imap <C-5> <Esc>5gt
map <C-6> 6gt
imap <C-6> <Esc>6gt
map <C-7> 7gt
imap <C-7> <Esc>7gt
map <C-8> 8gt
imap <C-8> <Esc>8gt
map <C-9> 9gt
imap <C-9> <Esc>9gt

set viminfo='100,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
