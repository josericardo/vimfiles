" gist-vim configuration
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

call pathogen#infect()

augroup General
  autocmd!
  au BufWritePost .vimrc so ~/.vimrc
augroup END

filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required!)
Bundle 'gmarik/vundle'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'rking/ag.vim'

colorscheme elflord
set nocompatible " be improved

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
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Zooms current split
nnoremap <Leader>max :wincmd _ <bar> wincmd <bar><CR>

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
noremap ,, <C-^>

" Bubble single lines
nnoremap <C-Up> [e
nnoremap <C-Down> ]e

" Bubble multiple lines
vnoremap <C-Up> [egv
vnoremap <C-Down> ]egv

let g:ctrlp_arg_map = 1

nmap <C-W>! <Plug>Kwbd

" Map Control-# to switch tabs
noremap <C-0> 0gt
inoremap <C-0> <Esc>0gt
noremap <C-1> 1gt
inoremap <C-1> <Esc>1gt
noremap <C-2> 2gt
inoremap <C-2> <Esc>2gt
noremap <C-3> 3gt
inoremap <C-3> <Esc>3gt
noremap <C-4> 4gt
inoremap <C-4> <Esc>4gt
noremap <C-5> 5gt
inoremap <C-5> <Esc>5gt
noremap <C-6> 6gt
inoremap <C-6> <Esc>6gt
noremap <C-7> 7gt
inoremap <C-7> <Esc>7gt
noremap <C-8> 8gt
inoremap <C-8> <Esc>8gt
noremap <C-9> 9gt
inoremap <C-9> <Esc>9gt

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

nnoremap <Leader>sv :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap <Leader>ss :%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>

let g:ctrlp_working_path_mode = 0

" PYTHON
let g:flake8_max_line_length=110

augroup IDE
  autocmd!
  " My universal IDE :D
  au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
  "autocmd BufWritePost *.py call Flake8()
  au BufNewFile,BufRead *.py noremap <Leader>r :w!<cr>:!python %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>ri :w!<cr>:!ipython -i %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>rl :w!<cr>:!ipython --pylab -i %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>i :w!<cr>:!ipython<cr>
  au BufNewFile,BufRead *.py noremap <Leader>e :w!<cr>:!python -c 
  au BufNewFile,BufRead *.py noremap <Leader>t :w!<cr>:!nosetests<cr>
  au BufNewFile,BufRead *.py noremap <Leader>pl :w!<cr>:Shell pylint %<cr>
  " Just looking for errors
  au BufNewFile,BufRead *.py noremap <Leader>pe :w!<cr>:Shell pylint -E %<cr> 

  au BufNewFile,BufRead *.m noremap <Leader>r :w!<cr>:!octave %<cr>
  au BufNewFile,BufRead *.m noremap <Leader>i :!octave<cr>
  au BufNewFile,BufRead *.m noremap <Leader>e :!octave --eval 
  au BufNewFile,BufRead *.m noremap <Leader>t :w!<cr>:!octave --eval 'test %'<cr>

  au BufNewFile,BufRead *.rb nnoremap <Leader>i :!pry<cr>

  if filereadable("Gemfile") 
    au BufNewFile,BufRead *.rb noremap <Leader>r :w!<cr>:!bundle exec ruby %<cr>

    if filereadable("Rakefile")
      au BufNewFile,BufRead test*.rb noremap <Leader>t :w!<cr>:!bundle exec rake test TEST=%<cr>
    end
  else
    au BufNewFile,BufRead *.rb noremap <Leader>r :w!<cr>:!ruby %<cr>
    au BufNewFile,BufRead *_spec.rb noremap <Leader>t :w!<cr>:!rspec %<cr>
  endif

  au BufNewFile,BufRead *.rb noremap <Leader>smell :Shell reek %<cr>

  " shortcuts to all project files
  " all syntaxb
  au BufNewFile,BufRead *.rb noremap <Leader>as :!for f in `ack -f --ruby`; do ruby -c $f; done<cr>

  au BufNewFile,BufRead *.py,*.rb noremap <Leader>out :!grep -w '^[ ]*class\\|^[ ]*def' %<cr>
  au BufWritePre *.py,*.rb normal m`:%s/\s\+$//e


  au BufNewFile,BufRead *.scm noremap <Leader>r :w!<cr>:!scheme < %<cr>
  au BufNewFile,BufRead *.scm noremap <Leader>i :!scheme<cr>
  "
  " tell vim to use the rspec compiler for all *_spec.rb files by adding this line to your vimrc
  au BufNewFile,BufRead *_spec.rb compiler rspec
  au BufNewFile,BufRead *_spec.rb setl makeprg=rspec

  " XMPFILTER https://github.com/t9md/vim-ruby-xmpfilter
  au BufNewFile,BufRead *.rb nmap <buffer> <F5> <Plug>(xmpfilter-run)
  au BufNewFile,BufRead *.rb xmap <buffer> <F5> <Plug>(xmpfilter-run)
  au BufNewFile,BufRead *.rb imap <buffer> <F5> <Plug>(xmpfilter-run)

  au BufNewFile,BufRead *.rb nmap <buffer> <F4> <Plug>(xmpfilter-mark)
  au BufNewFile,BufRead *.rb xmap <buffer> <F4> <Plug>(xmpfilter-mark)
  au BufNewFile,BufRead *.rb imap <buffer> <F4> <Plug>(xmpfilter-mark)
  
  " Show trailing white space
  au BufNewFile,BufRead * syn match brancomala '\s\+$' | hi brancomala ctermbg=red
augroup END

nnoremap <leader>a <Esc>:Ack!

" Some stuff stolen from aurelio:
" http://aurelio.net/doc/dotfiles/vimrc.txt

" Close everything!
inoremap <F11> <esc>:wqa!<cr>
noremap <F11> :wqa!<cr>

" Keeping myself sane
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq

" :Shell runs and command and puts its output in a new buffer
" http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  vsplit new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

map <leader>gac :Gwrite<CR> <bar> :Gcommit -v<CR> <bar> ,max

map <leader>spell :set spell! spell?<CR>

nnoremap <leader>vv :vsplit $MYVIMRC<cr>
nnoremap <leader>vl :so $MYVIMRC<cr>

inoremap dk <esc>
inoremap <esc> <nop>

noremap ;w <esc>:w!<cr>
ino ;w <esc>:w!<cr>
noremap ;wq <esc>:wq!<cr>
ino ;wq <esc>:wq!<cr>
noremap ;q <esc>:q!<cr>
ino ;q <esc>:q!<cr>
nnoremap :w :echo "no!"<cr>
