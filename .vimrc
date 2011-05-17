" Basic .vimrc
" Absolute  "{{{2

if !exists('s:loaded_my_vimrc')
  " Don't reset twice on reloading - 'compatible' has SO many side effects.
  set nocompatible  " to use many extensions of Vim.
endif

" for vundle
set rtp+=~/.vim/vundle/
call vundle#rc()
Bundle 'Shougo/neocomplcache'
Bundle 'scrooloose/nerdcommenter'
Bundle 'clones/vim-l9'
Bundle 'edsono/vim-matchit'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'digitaltoad/vim-jade'
Bundle 'Shougo/unite.vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'tpope/vim-fugitive'
Bundle 'cakebaker/scss-syntax.vim'

" Options  "{{{2
if (1 < &t_Co || has('gui')) && has('syntax')
  if &term ==# 'xterm' || &term ==# 'screen-bce'
    set t_Co=256
  endif
  syntax enable
  if !exists('g:colors_name')  " Don't override colorscheme on reloading.
    if (&t_Co ==# 256)
      colorscheme inkpot
    endif
  endif
endif

filetype plugin indent on


set ambiwidth=double
set smartindent "インデントはスマートインデント
set backspace=indent,eol,start  " more powerful backspacing
set nobackup    " Don't keep a backup file
set formatoptions=tcqnlM1
autocmd FileType * setlocal formatoptions-=ro "Don't set auto comment on any file
set formatlistpat&
let &formatlistpat .= '\|^\s*[*+-]\s*'
set history=1000   " keep 50 lines of command line history
set hlsearch "検索結果文字列のハイライトを有効にする
nohlsearch  " To avoid (re)highlighting the last search pattern
            " whenever $MYVIMRC is (re)loaded.
set incsearch "検索文字列入力時に順次対象文字列にヒットさせる
set laststatus=2 "ステータスラインを常に表示
set ruler   " show the cursor position all the time
set showcmd   "入力中のコマンドをステータスに表示する
set showmode
set title
set titlestring=Vim:\ %f\ %h%r%m
set ttimeoutlen=50  " Reduce annoying delay for key codes, especially <Esc>...
set wildmenu " コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set viminfo='50,<1000,s100,\"50 " read/write a .viminfo file, don't store more than
"set viminfo='50,<1000,s100,:0,n~/.vim/viminfo
"
" ステータスラインに文字コードと改行文字を表示する
let &statusline = ''
let &statusline .='%<[%n]%f %h%m%r%w'
let &statusline .= '%='
  "" temporary disabled.
  "let &statusline .= '(%{' . s:SID_PREFIX() . 'vcs_branch_name(getcwd())}) '
let &statusline .= '[%{( &l:fileencoding == "" ? &encoding : &l:fileencoding ).":".&fileformat}]%y'
let &statusline .= ' %-14.(%l,%c%V%) %P'

let mapleader = ','
"let maplocalleader = '.'

" Syntax  "{{{1
" Utf8 and others - :edit with specified 'fileencoding'  "{{{2

command! -bang -bar -complete=file -nargs=? Cp932
\ edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Eucjp
\ edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp
\ edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Utf8
\ edit<bang> ++enc=utf-8 <args>

command! -bang -bar -complete=file -nargs=? Jis  Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis  Cp932<bang> <args>

" Mappings  "{{{1
" Disable some dangerous key.
nnoremap ZZ  <Nop>
nnoremap ZQ  <Nop>
" turn off highlighting
nnoremap <silent> gh :nohlsearch<CR>

" Now we set some defaults for the editor
set scrolloff=5   " Scrool offset
set textwidth=0   " Don't wrap words by default
set autoread    " 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set noswapfile   " スワップファイル作らない
set hidden   " バッファが編集中でもその他のファイルを開けるように
set showmatch   "括弧入力時の対応する括弧を表示

" 全角スペースをハイライト
if has("syntax")
    syntax on
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Cyan guibg=Cyan
"        syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
"        highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=Red
"        syntax match InvisibleTab "\t" display containedin=ALL
"        highlight InvisibleTab term=underline ctermbg=Cyan guibg=Cyan
    endf
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif


" タブ幅の設定
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" コマンドライン補間をシェルっぽく
set wildmode=list:longest


" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Debian uses compressed helpfiles. We must inform vim that the main
" helpfiles is compressed. Other helpfiles are stated in the tags-file.
" set helpfile=$VIMRUNTIME/doc/help.txt.gz
set helpfile=$VIMRUNTIME/doc/help.txt
set helplang=ja,en

set modelines=0

"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan
"タブの左側にカーソル表示
set listchars=tab:>-,trail:-,nbsp:%,extends:<
set list

" Plugins
" Neocomplecache
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Use selection first candidate
let g:neocomplcache_enable_auto_select = 1
" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup()."\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup() 
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" unite.vim
let g:unite_enable_start_insert=1
nnoremap [unite] <Nop>
nmap <Space> [unite]
nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b :<C-u>UniteWithBufferDir -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
" split
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" vsplit
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" close with <ESC><ESC>
autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#set_substitute_pattern('file', '[^~.]\zs/', '*/*', 20)
call unite#set_substitute_pattern('file', '/\ze[^*]', '/*', 10)
call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
call unite#set_substitute_pattern('file', '^\\', '~/*')
call unite#set_substitute_pattern('file', '^;v', '~/.vim/*')
call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/*"')
if has('win32') || has('win64')
  call unite#set_substitute_pattern('file', '^;p', 'C:/Program Files/*')
endif
call unite#set_substitute_pattern('file', '\*\*\+', '*', -1)
call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)

" surround.vim
" Ruby http://d.hatena.ne.jp/ursm/20080402/1207150539
let g:surround_{char2nr('%')} = "%(\r)"
let g:surround_{char2nr('w')} = "%w(\r)"
let g:surround_{char2nr('#')} = "#{\r}"
let g:surround_{char2nr('e')} = "begin \r end"
let g:surround_{char2nr('i')} = "if \1if\1 \r end"
let g:surround_{char2nr('u')} = "unless \1unless\1 \r end"
let g:surround_{char2nr('c')} = "class \1class\1 \r end"
let g:surround_{char2nr('m')} = "module \1module\1 \r end"
let g:surround_{char2nr('d')} = "def \1def\1\2args\r..*\r(&)\2 \r end"
let g:surround_{char2nr('p')} = "\1method\1 do \2args\r..*\r|&| \2\r end"
let g:surround_{char2nr('P')} = "\1method\1 {\2args\r..*\r|&|\2 \r }"
