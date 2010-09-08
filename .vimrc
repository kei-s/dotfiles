" Basic .vimrc
" Absolute  "{{{2

if !exists('s:loaded_my_vimrc')
  " Don't reset twice on reloading - 'compatible' has SO many side effects.
  set nocompatible  " to use many extensions of Vim.
endif

" Encoding  "{{{2
"if &encoding !=# 'utf-8'
  "set encoding=japan
  "set fileencoding=japan
"endif
"if has('iconv')
  "let s:enc_euc = 'euc-jp'
  "let s:enc_jis = 'iso-2022-jp'
  "" Does iconv support eucJP ms ?
  "if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    "let s:enc_euc = 'eucjp-ms'
    "let s:enc_jis = 'iso-2022-jp-3'
  "" Does iconv support JIS X 0213 ?
  "elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    "let s:enc_euc = 'euc-jisx0213'
    "let s:enc_jis = 'iso-2022-jp-3'
  "endif
  "" Make fileencodings
  "if &encoding ==# 'utf-8'
    "let s:fileencodings_default = &fileencodings
    "let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    "let &fileencodings = &fileencodings .','. s:fileencodings_default
    "unlet s:fileencodings_default
  "else
    "let &fileencodings = &fileencodings .','. s:enc_jis
    "set fileencodings+=utf-8,ucs-2le,ucs-2
    "if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      "set fileencodings+=cp932
      "set fileencodings-=euc-jp
      "set fileencodings-=euc-jisx0213
      "set fileencodings-=eucjp-ms
      "let &encoding = s:enc_euc
      "let &fileencoding = s:enc_euc
    "else
      "let &fileencodings = &fileencodings .','. s:enc_euc
    "endif
  "endif
  "unlet s:enc_euc
  "unlet s:enc_jis
"endif

"if has('autocmd')
  "function! AU_ReCheck_FENC()
    "if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      "let &fileencoding=&encoding
    "endif
  "endfunction
  "autocmd BufReadPost * call AU_ReCheck_FENC()
"endif
"set fileformats=unix,dos,mac

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
" FuzzyFinder
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_abbrevMap = {
      \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
      \   '^m0:' : [ '/mnt/d/0/', '/mnt/j/0/' ],
      \ }
let g:fuf_mrufile_maxItem = 300
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> <C-n>      :FufBuffer<CR>
nnoremap <silent> <C-p>      :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <C-f><C-p> :FufFileWithFullCwd<CR>
nnoremap <silent> <C-f>p     :FufFile<CR>
nnoremap <silent> <C-f><C-d> :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <C-f>d     :FufDirWithFullCwd<CR>
nnoremap <silent> <C-f>D     :FufDir<CR>
nnoremap <silent> <C-j>      :FufMruFile<CR>
nnoremap <silent> <C-k>      :FufMruCmd<CR>
nnoremap <silent> <C-b>      :FufBookmark<CR>
nnoremap <silent> <C-f><C-t> :FufTag<CR>
nnoremap <silent> <C-f>t     :FufTag!<CR>
noremap  <silent> g]         :FufTagWithCursorWord!<CR>
nnoremap <silent> <C-f><C-f> :FufTaggedFile<CR>
nnoremap <silent> <C-f><C-j> :FufJumpList<CR>
nnoremap <silent> <C-f><C-g> :FufChangeList<CR>
nnoremap <silent> <C-f><C-q> :FufQuickfix<CR>
nnoremap <silent> <C-f><C-l> :FufLine<CR>
nnoremap <silent> <C-f><C-h> :FufHelp<CR>
nnoremap <silent> <C-f><C-b> :FufAddBookmark<CR>
vnoremap <silent> <C-f><C-b> :FufAddBookmarkAsSelectedText<CR>
nnoremap <silent> <C-f><C-e> :FufEditInfo<CR>
nnoremap <silent> <C-f><C-r> :FufRenewCache<CR>

" Outpuz.vim
"let g:outputz_secret_key = 'xAuArU1SNvRH'
