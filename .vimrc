
" Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

 if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimfiler'
"NeoBundle 'Shougo/vimproc'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vim-vcs'
"NeoBundle 'Shougo/echodoc'

" colorscheme
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'

" indent guide
NeoBundle 'nathanaelkane/vim-indent-guides'

" autoclose parentheses
NeoBundle 'Townk/vim-autoclose'

"NeoBundle 'davidhalter/jedi-vim'
"NeoBundle 'kevinw/pyflakes-vim'
NeoBundle 'nvie/vim-flake8'

" syntax check
NeoBundle 'scrooloose/syntastic'

" cpp-enhanced-highlight
NeoBundle 'octol/vim-cpp-enhanced-highlight'

" autocomplete
"NeoBundle 'Shougo/neocomplete.vim'

" quickrun
NeoBundle 'thinca/vim-quickrun'

" Markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" syntax highlight for MATLAB
NeoBundle 'lazywei/vim-matlab'

" syntax highlight for Processing
NeoBundleLazy 'sophacles/vim-processing'
" syntax highlight for TypeScript
NeoBundle 'leafgarland/typescript-vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""


colorscheme molokai
set background=dark


""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""


" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

let g:syntastic_checkers=['flake8']

let g:syntastic_cpp_compiler='g++'
let g:syntastic_cpp_compiler_options='-std=c++11'
"let g:syntastic_cpp_include_dirs=['/usr/local/include']

if filereadable("~/.secrets/.vimrc")
    source ~/.secrets/.vimrc
endif

let g:quickrun_config={'*': {'hook/time/enable': '1'},}

" neocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable AutoComplPop
let g:acp_enableAtStartup=0
" Use neocomplete
let g:neocomplete#enable_at_startup=1
" Use smartcase
let g:neocomplete#enable_smart_case=1
" Set minimum syntax keyword length
let g:neocomplete#sources#syntax#min_keyword_length=3
let g:neocomplete#lock_buffer_name_pattern='\*ku\*'
" Define dictionary
let g:neocomplete#sources#dictionary#dictionaries={
    \ 'default' : '',
    \ }
" Define keyword
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns={}
endif
let g:neocomplete#keyword_patterns['default']='\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" Recommended key-mappings
" <CR>: close popup and save indent
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns={}
endif
""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""


" jedi.vim settings
command! -nargs=0 JediRename :call jedi#rename()
let g:jedi#rename_command="<leader>R"
let g:jedi#documentation_command="K"

" jedi.vim and neocomplete
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration=0
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns={}
endif


""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""


let g:netrw_listyle=3
let g:netrw_altv=1

" vim-flake8 settings
nnoremap <leader>l :call Flake8()

" vim-indent-guides settings
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=black ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=4
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Markdown
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd='google-chrome --incognito'
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1

" cpp-enhanced-highlight
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_template_highlight=1

" processing
augroup Processing
  autocmd!
  autocmd BufNewFile *.pde NeoBundleSource vim-processing
  autocmd BufRead    *.pde NeoBundleSource vim-processing
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""


syntax on

"au BufNewFile,BufRead *.m set filetype=octave
au BufRead,BufNewFile *.m set filetype=matlab

" ROS
au BufRead,BufNewFile *.launch set filetype=xml
au BufRead,BufNewFile *.sdf    set filetype=xml
au BufRead,BufNewFile *.world  set filetype=xml

# Arduino
au BufRead,BufNewFile *.ino set filetype=cpp

" encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformat=unix

" use OS clipboard
set clipboard=unnamedplus

" keep input method off
set iminsert=0
set imsearch=-1

" show invisible characters
set list
set listchars=tab:>-,trail:~,eol:$,nbsp:%,extends:>,precedes:<

" text wrap
set wrap
set textwidth=0
set colorcolumn=80

" indent
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set shiftround

" editor window
set number
set ruler
set cursorline
set showcmd
set wildmenu

" cursor movement
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set nostartofline
"set virtualedit=all

" backup files
set noswapfile
set nowritebackup
set nobackup

" history
set history=10000
set viminfo=

" search
set ignorecase
set smartcase
set incsearch
set hlsearch
set infercase

" properly display two-byte fonts
set ambiwidth=double

" beep
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" pairs
set matchpairs& matchpairs+=<:>
set showmatch
set matchtime=3

" show file encodings and file formats
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 

" etc
set title
set hidden
set switchbuf=useopen
set mouse=a
set ttymouse=xterm2


""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""


" remove trailing whitespaces before saving Python script
autocmd BufWritePre *.py :%s/\s\+$//e

" run Python script
autocmd BufNewFile,BufRead *.py nnoremap <C-e> :!python %

" change color of status line in insert mode
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction
function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" highlight two-byte whitespace
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=LightMagenta gui=underline guifg=LightMagenta
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif

" change cursor color when IME is on (not working on Linux)
if has('multi_byte_ime') || has('xim')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif

" create non-existent directory
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" change current directory to the parent directory of the file opened
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""


" save and quit with <C-s> and <C-q> in insert mode
inoremap <C-s> <Esc>:w<CR>
inoremap <C-q> <Esc>:q<CR>

" save and quit with <C-s> and <C-q> in normal mode
nnoremap <C-s> <Esc>:w<CR>
nnoremap <C-q> <Esc>:q<CR>

" select to the end of line with vv
vnoremap v $h

" enable to move wrapped line
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
" move by line
nnoremap gj j
nnoremap gk k

" quit search highlight with <ESC><ESC>
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" jump to paired parenthesis with TAB key
nnoremap <Tab> %
vnoremap <Tab> %

" search selected word with *
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" change window with Ctrl + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" change window size with Shift + arrows
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" show found word in center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" input \/ instead of / when writing /{pattern}
" input \? instead of ? when writing ?{pattern}
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" run scripts with \ + r
nmap <Leader>r <plug>(quickrun)

" save as superuser with w!!
cmap w!! w !sudo tee > /dev/null %

" use jj as <Esc> in insert mode
inoremap jj <Esc>



