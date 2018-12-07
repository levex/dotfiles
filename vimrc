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
noremap <silent> <leader>syt :SyntasticToggleMode<cr>
noremap <silent> <leader>syc :SyntasticCheck<cr>

" Code navigation
set showmatch
set mat=1
set diffopt="filler,vertical"

" Syntax
syntax on

set background=dark

" Vundle, must be before filetype commands
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Syntastic: Syntax checker
" Plugin 'scrooloose/syntastic'
" Plugin 'bitc/vim-hdevtools'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'levex/vim-monochrome'
Plugin 'ARM9/arm-syntax-vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'neomake/neomake'
Plugin 'milkypostman/vim-togglelist'
Plugin 'scrooloose/nerdcommenter'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'scrooloose/nerdtree'
" Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'vimwiki/vimwiki'
Plugin 'wakatime/vim-wakatime'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'shumphrey/fugitive-gitlab.vim'
Plugin 'godlygeek/tabular'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-eunuch'
Plugin 'aklt/plantuml-syntax'
Plugin 'tyru/open-browser.vim' " dependency for next
Plugin 'weirongxu/plantuml-previewer.vim'
Plugin 'euclio/vim-markdown-composer'
Plugin 'adborden/vim-notmuch-address'
" Plugin 'scrooloose/vim-slumlord' " Does not work
" Plugin 'eagletmt/neco-ghc'
" Plugin 'AndreaMichi/wacc-vim'
Plugin 'vim-syntastic/syntastic'
call vundle#end()

" plantuml
let g:plantuml_previewer#plantuml_jar_path = "/home/lkurusa/sw/plantuml.jar"
au BufNewFile,BufRead *.uml set filetype=plantuml

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
	\ "mode": "passive",
	\ "active_filetypes": ["rust"],
	\ "passive_filetypes": ["c"] }

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <m-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <m-j> :TmuxNavigateDown<cr>
nnoremap <silent> <m-k> :TmuxNavigateUp<cr>
nnoremap <silent> <m-l> :TmuxNavigateRight<cr>
nnoremap <silent> <m-\> :TmuxNavigatePrevious<cr>

" Misc
let g:toggle_list_no_mappings = 1

" System clipboard
nnoremap <silent> <leader>Y "+y

" tagbar
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" vimwiki
autocmd FileType vimwiki set shiftwidth=2

" ctrlp
" map <silent> <leader>o :CtrlP
let g:ctrlp_cache_dir = '/home/lkurusa/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = {
  \ 'dir':  'src/test|target|\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

" FZF
map <silent> <C-p> :GFiles<CR>
map <silent> <leader>f :Files<CR>
map <silent> <leader>t :Tags<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~20%' }


" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDTreeRespectWildIgnore = 1

" nerdtree
map <C-n> :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<CR>

" cscope stuff
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  
    nmap <C-\><C-s> :tab cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	
endif

" Rust
set hidden
let g:racer_cmd = "/home/lkurusa/.cargo/bin/racer"
let g:racer_experimental_completer = 1
set completeopt-=preview
let g:rustfmt_command = "/home/lkurusa/.cargo/bin/rustfmt"
let g:rustfmt_options = "+nightly"
nnoremap <leader><leader>c :Cbuild<cr>

set t_Co=256
colorscheme monochrome

set laststatus=2
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_tab_type = 1
" let g:airline#extensions#tabline#show_tab_nr = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#tab_nr_type = 1
" let g:airline#extensions#tabline#tabs_label = 't'
" let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline_section_y = airline#section#create_right([])

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
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| sed -e s/\\\\\$// | curl -F "sprunge=<-" sprunge.us 2>/dev/null | xclip -selection c')
endfunction

function! CopyLine() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| sed -e s/\\\\\$// | xclip -selection c')
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

" Buffer management stuff
" nnoremap <silent> <leader>l :ls<CR>:b<space>
nnoremap <silent> <leader>l :Buffers<CR>
nmap <leader>d :b#<bar>bd#<CR>
" nnoremap <silent> <leader>d :bdelete<CR>
noremap <silent> <leader>v :vsp<CR>
noremap <silent> <leader>h :sp<CR>

set shell=zsh

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

" enable manpage viewer
runtime ftplugin/Man.vim
