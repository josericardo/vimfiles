set nocompatible
let mapleader=","

""""""""""""""""""""""""""""""""""""""""
" Vundle Setup
""""""""""""""""""""""""""""""""""""""""
filetype off                   " required! by vundler

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle (required!)
Plugin 'gmarik/vundle'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'msanders/snipmate.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'JarrodCTaylor/vim-python-test-runner'
Plugin 'davidhalter/jedi-vim'
Plugin 'jmcantrell/vim-virtualenv'

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
nnoremap <Leader>/ :nohlsearch<cr>

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
nnoremap <Leader>n :call RenameFile()<cr>

cnoremap %% <C-R>=expand('%:h').'/'<cr>

" reopens the last buffer
noremap <Leader><Leader> <C-^>

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

" replace with blank start
nnoremap <Leader>sv :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
" replace with the current word as a start
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
  au BufNewFile,BufRead *.py noremap <Leader>rj :w!<cr>:!python % < input<cr>
  au BufNewFile,BufRead *.py noremap <Leader>ri :w!<cr>:!ipython -i %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>rl :w!<cr>:!ipython --pylab -i %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>i :w!<cr>:!ipython<cr>
  au BufNewFile,BufRead *.py noremap <Leader>e :w!<cr>:!python -c 
  au BufNewFile,BufRead *.py noremap <Leader>pt :w!<cr>:!nosetests -s %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>f8 :w!<cr>:!flake8 %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>pl :w!<cr>:Shell pylint %<cr>
  au BufNewFile,BufRead *.py noremap <Leader>pe :w!<cr>:Shell pylint -E %<cr> 
  au BufNewFile,BufRead *.py noremap <Leader>nt :w!<cr>:NosetestFile<cr> 
  au BufNewFile,BufRead *.py noremap <Leader>nm :w!<cr>:NosetestMethod<cr> 


  function! PyTestPathAsModule()
    return shellescape(substitute(substitute(expand('%'), '.py', '', 'g'), '/', '.', 'g'))
  endfunction

  au BufNewFile,BufRead *_test.py noremap <Leader>r  :w!<cr>:exec '!python -m ' . PyTestPathAsModule() <cr>

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

  au BufNewFile,BufRead *.m noremap <Leader>r :w!<cr>:!octave %<cr>
  au BufNewFile,BufRead *.m noremap <Leader>i :!octave<cr>
  au BufNewFile,BufRead *.m noremap <Leader>e :!octave --eval 
  au BufNewFile,BufRead *.m noremap <Leader>t :w!<cr>:!octave --eval 'test %'<cr>

  au BufNewFile,BufRead *.rb nnoremap <Leader>i :!pry<cr>

  if filereadable("Gemfile") 
    au BufNewFile,BufRead *.rb noremap <Leader>r :w!<cr>:!bundle exec ruby -Ilib %<cr>

    if filereadable("Rakefile")
      au BufNewFile,BufRead test*.rb noremap <Leader>t :w!<cr>:!bundle exec rake test TEST=%<cr>
    end
  else
    au BufNewFile,BufRead *.rb noremap <Leader>r :w!<cr>:!ruby %<cr>
    au BufNewFile,BufRead *_spec.rb noremap <Leader>t :w!<cr>:!rspec %<cr>
  endif

  function! OpenTestAlternate()
    let new_file = AlternateForCurrentFile()
    exec ':vsplit ' . new_file
  endfunction
  
  function! AlternateForCurrentFile()
    let current_file = expand("%")
    let new_file = current_file
    let in_spec = match(current_file, '^tests/') != -1
    let going_to_spec = !in_spec

    if going_to_spec
      let new_file = substitute(new_file, 'lib/', 'tests/fast/', '')
      let new_file = substitute(new_file, expand('%:t'), 'test_' . expand('%:t'), '')
    else
      let new_file = substitute(new_file, 'tests/fast/', 'lib/', '')
      let new_file = substitute(new_file, 'test_', '', '')
    endif
    return new_file
  endfunction

  au BufNewFile,BufRead *.rb nnoremap <Leader>. :call OpenTestAlternate()<cr>

  au BufNewFile,BufRead *.rb noremap <Leader>smell :Shell reek %<cr>

  " shortcuts to all project files
  " all syntaxb
  au BufNewFile,BufRead *.rb noremap <Leader>as :!for f in `ack -f --ruby`; do ruby -c $f; done<cr>

  au BufNewFile,BufRead *.py,*.rb noremap <Leader>out :!grep -w '^[ ]*class\\|^[ ]*def' %<cr>
  au BufWritePre *.py,*.rb :%s/\s\+$//e

  """"""""""""""""""""""""""""
  " Scala
  """"""""""""""""""""""""""""
  au BufNewFile,BufRead *.scala noremap <Leader>r :w!<cr>:!scala %<cr>

  """"""""""""""""""""""""""""
  " Scheme
  """"""""""""""""""""""""""""
  au BufNewFile,BufRead *.scm noremap <Leader>r :w!<cr>:!scheme < %<cr>
  au BufNewFile,BufRead *.scm noremap <Leader>i :!scheme<cr>
  
  """"""""""""""""""""""""""""
  " Ruby
  """"""""""""""""""""""""""""
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

  """"""""""""""""""""""""""""
  " PHP
  """"""""""""""""""""""""""""
  au FileType php set tabstop=4 shiftwidth=4
  au BufNewFile,BufRead *.php noremap <Leader>out :!grep -w '^[ ]*class\\|^.*function' %<cr>
  au BufNewFile,BufRead *.php noremap <Leader>outp :!grep -w '^[ ]*class\\|^.*public.*function' %<cr>
  au BufNewFile,BufRead *.php noremap <Leader>cs :!make cs FILE=%<cr>
  au BufNewFile,BufRead *.php noremap <Leader>ct :!make test FILE=%<cr>
  au BufNewFile,BufRead *.php syn match tabmala '^\s\*\t\+' | hi tabmala ctermbg=red
  au BufNewFile,BufRead *.php hi ExtraWhitespace ctermbg=red guibg=red| match ExtraWhitespace /\s\+$\|\t/

  """"""""""""""""""""""""""""
  " Elixir
  """"""""""""""""""""""""""""
  au BufNewFile,BufRead *.exs noremap <Leader>r :w!<cr>:!elixir %<cr>
  
  " Show trailing white space
  au BufNewFile,BufRead * syn match brancomala '\s\+$' | hi brancomala ctermbg=red
  
  au BufNewFile,BufRead *.json nnoremap <Leader>= :%!python -m json.tool<cr>
  
augroup END

nnoremap <Leader>a :Ack!

" Remove trailing white space
noremap <Leader>rtws :%s/\s\+$//e<cr>

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

nnoremap <Leader>gac :Gwrite<CR> <bar> :Gcommit -v<CR> <bar> ,max

nnoremap <Leader>spell :set spell! spell?<CR>

nnoremap <Leader>vv :vsplit $MYVIMRC<cr>
nnoremap <Leader>vl :so $MYVIMRC<cr>

nnoremap <Leader>paste :set paste!<cr>

if filereadable(".vim.custom")
  so .vim.custom
endif

if filereadable("../.vim.custom")
  so ../.vim.custom
endif

nnoremap <Leader>mkdir :!mkdir -p "%:h"<cr>
nnoremap <Leader>fixhl <Esc>:syntax sync fromstart<CR>

noremap <Esc><f1> :w!<cr>
inoremap <Esc><f1> <Esc>:w!<cr>
noremap <Esc><f2> :wq!<cr>
inoremap <Esc><f2> <Esc>:wq!<cr>
noremap <Esc><f3> :q!<cr>
inoremap <Esc><f3> <Esc>:q!<cr>

noremap <Leader>nt :NERDTree<cr>

function! ToggleErrors()
    if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
         " No location/quickfix list shown, open syntastic error location panel
         Errors
    else
        lclose
    endif
endfunction

nnoremap <silent> <Leader>e  :<C-u>call ToggleErrors()<CR>

noremap : ;
noremap ; :
noremap , _

set nobackup
set noswapfile

nnoremap j gj
nnoremap k gk

set wildignore+=*.pyc

