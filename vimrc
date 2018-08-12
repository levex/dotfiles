" Levente Kurusa's reduced vimrc
set wildignore=*.o,*~,*.pyc
set cmdheight=1
set nocompatible
set backspace=indent,eol,start
let mapleader=","

" Swapfiles are evil
set nobackup
set nowb
set noswapfile

" Orientation
set colorcolumn=80
set ruler
set rnu
set number
" set list
" set listchars=tab:>.,trail:.,extends:#,nbsp:.
set wildmenu

" Search
set hlsearch
set ignorecase
set incsearch
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
map <silent> <leader><cr> :noh<cr>
map <silent> <leader>p :set paste! <cr>
map <silent> <leader>w :wq<cr>
map <silent> <leader>c :call TalkWithLev()<cr>
noremap <silent> <leader>syt :SyntasticToggleMode<cr>
noremap <silent> <leader>syc :SyntasticCheck<cr>

" Code navigation
set showmatch
set mat=1

" Syntax
syntax on

set background=dark

" Vundle, must be before filetype commands
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Syntastic: Syntax checker
" Plugin 'scrooloose/syntastic'
" Plugin 'bitc/vim-hdevtools'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'kcsongor/vim-monochrome'
Plugin 'ARM9/arm-syntax-vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'neomake/neomake'
Plugin 'milkypostman/vim-togglelist'
Plugin 'scrooloose/nerdcommenter'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'scrooloose/nerdtree'
" Plugin 'eagletmt/neco-ghc'
" Plugin 'AndreaMichi/wacc-vim'
call vundle#end()

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" Rust
set hidden
let g:racer_cmd = "/home/lkurusa/.cargo/bin/racer"
let g:racer_experimental_completer = 1
set completeopt-=preview

set t_Co=256
colorscheme monochrome

set laststatus=2
let g:airline_powerline_fonts = 1

" Haskell
function! ExecHaskell()
  let line = getline(".")
  exec ".! echo 'main = print $ ".line."' | runghc"
endfunction
nnoremap <Leader>eh :call ExecHaskell()<cr>
" ds]^qaf,sq9@a

function! ToggleRelativeNumber()
  set nornu!
endfunction

function! ToggleScrollOff()
  if (&scrolloff == 3)
    set scrolloff=9999
  else
    set scrolloff=3
  endif
endfunction

function! ToggleShowCursor()
	set cursorcolumn!
	set cursorline!
endfunction

map <Up>  :call ToggleRelativeNumber()<cr>
map <Down>  :call ToggleScrollOff()<cr>
map <Left> :call ToggleShowCursor()<cr>

function! Termbin() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| sed -e s/\\\\\$// | curl -F "sprunge=<-" sprunge.us 2>/dev/null | pbcopy')
endfunction

function! CopyLine() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| xclip -selection c')
endfunction

" Old for termbin.com
" echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| sed -e s/\\\\\$// | nc termbin.com 9999 | xclip -selection c')

function! TakeScreenshot()
  echo system("xwininfo -name Terminal | grep id: | awk \'{print $4}\' | xargs xwd -id | convert /dev/stdin PNG:/homes/lk1015/Pictures/vim-`date +%H-%M-%S--%d-%m-%Y`.png 2>/dev/null")
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap t :call Termbin()<cr>
vnoremap T :call CopyLine()<cr>


" Move one line up or down by 1
nnoremap <silent> K :move .-2<cr>
nnoremap <silent> J :move .+1<cr>

" Move selection up or down by 1
vnoremap <silent> K :move '<-2<cr>gv
vnoremap <silent> J :move '>+1<cr>gv

set shell=bash

nnoremap <C-j> J
vnoremap <C-j> J

" let g:syntastic_c_include_dirs = [ '/lib/modules/4.4.5-1-ARCH/build/include/' ]
let g:syntastic_c_config_file = '.syntastic_c_config'

filetype plugin on
filetype plugin indent on
set mouse=

augroup NeomakeHaskell
  autocmd!
  autocmd! BufWritePost *.hs Neomake
augroup END

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
au BufNewFile,BufRead *.wacc set filetype=wacc
