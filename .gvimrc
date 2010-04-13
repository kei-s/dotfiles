if has('gui_macvim')
  set columns=100
  set lines=45
  set go-=T
  set bg=dark
  set imdisable
  if &background == "dark"
   hi normal guibg=black
   set transp=8
  endif
endif

if has('windows')
  colorscheme Dark2
  set columns=120
  set lines=40
  set go-=T
  set bg=dark
  set imdisable
  if &background == "dark"
    hi normal guibg=black
  endif

  " �����R�[�h�̎����F��
  if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
  endif
  if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconv��eucJP-ms�ɑΉ����Ă��邩���`�F�b�N
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'eucjp-ms'
      let s:enc_jis = 'iso-2022-jp-3'
    " iconv��JISX0213�ɑΉ����Ă��邩���`�F�b�N
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'euc-jisx0213'
      let s:enc_jis = 'iso-2022-jp-3'
    endif
    " fileencodings���\�z
    if &encoding ==# 'utf-8'
      let s:fileencodings_default = &fileencodings
      let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
      let &fileencodings = &fileencodings .','. s:fileencodings_default
      unlet s:fileencodings_default
    else
      let &fileencodings = &fileencodings .','. s:enc_jis
      set fileencodings+=utf-8,ucs-2le,ucs-2
      if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
        set fileencodings+=cp932
        set fileencodings-=euc-jp
        set fileencodings-=euc-jisx0213
        set fileencodings-=eucjp-ms
        let &encoding = s:enc_euc
        let &fileencoding = s:enc_euc
      else
        let &fileencodings = &fileencodings .','. s:enc_euc
      endif
    endif
    " �萔������
    unlet s:enc_euc
    unlet s:enc_jis
  endif
  " ���{����܂܂Ȃ��ꍇ�� fileencoding �� encoding ���g���悤�ɂ���
  if has('autocmd')
    function! AU_ReCheck_FENC()
      if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
        let &fileencoding=&encoding
      endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
  endif
  " ���s�R�[�h�̎����F��
  set fileformats=unix,dos,mac
  " ���Ƃ����̕����������Ă��J�[�\���ʒu������Ȃ��悤�ɂ���
  if exists('&ambiwidth')
    set ambiwidth=double
  endif
endif
