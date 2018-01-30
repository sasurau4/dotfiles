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
