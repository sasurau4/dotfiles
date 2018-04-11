"setting
"文字コードをUFT-8に設定
set fenc=utf-8
"□や○文字が崩れる問題を解決
set ambiwidth=double
"バックアップファイルを作らない
set nobackup
"スワップファイルを作らない
set noswapfile
"編集中のファイルが変更されたら自動で読み直す
set autoread
"バッファが編集中でもその他のファイルを開けるように
set hidden
"入力中のコマンドをステータスに表示する
set showcmd


"見た目系
"行番号を表示
set number
"現在の行を強調表示
set cursorline
"行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
"インデントはスマートインデント
set smartindent
"括弧入力時の対応する括弧を表示
set showmatch
"ステータスラインを常に表示
set laststatus=2
"コマンドラインの補完
set wildmode=list:longest
"カーソルの位置表示を行う
set ruler
"現在のモードを表示
set showmode
"折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk


"Tab系
"不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
"Tab文字を半角スペースにする
set expandtab
"行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
"行頭でのTab文字の表示幅
set shiftwidth=2
"indent
set autoindent
"insert space instead of tab
set expandtab


"検索系
"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索語をハイライト表示
set hlsearch
"ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"クリップボード連携
set clipboard=unnamedplus,unnamed

"syntax highlight
syntax enable
set background=dark
colorscheme solarized

"mode control
"インサートモードから抜けると自動的にIMEをオフにする
set iminsert=2

filetype indent on

" 括弧の対応関係を一瞬表示する
set showmatch 
" enable filetype plugin
filetype plugin on
" Vimの「%」を拡張する
source $VIMRUNTIME/macros/matchit.vim 

" コマンドモードの補完
set wildmenu wildmode=list:longest,full
" 保存するコマンド履歴の数
set history=5000 

"manage plugin
let g:neocomplete#enable_at_startup = 1
let g:indentline#enable_at_startup = 1
let g:lightline#enable_at_startup = 1

"settings for lightline
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ], 
      \             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \ },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ }, 
      \ 'component_type': {
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \ }
      \ }

"settings for neocomlete & neosnippet & neosnippet-snippets
 " Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

"settings for denite
let g:python3_host_prog = expand('/usr/bin/python3')

"settings for NERDTree
let NERDTreeShowHidden= 1
autocmd vimenter * NERDTree
noremap <Space>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"settings for vim-javascript
let g:javascript_plugin_jsdoc = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

"setting for vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 1

" Setting for Ale
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\}
let g:ale_javascript_prettier_options = '--single-quote'
let g:ale_javascript_prettier_use_local_config = 1

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Settings for lightline-ale plugin
let g:lightline#ale#indicator_warnings = "Warning:"
let g:lightline#ale#indicator_errors = "Error:"
