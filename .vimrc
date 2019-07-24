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
"All files folding by syntax
:set foldmethod=syntax

"Tab系
"visualize tab
set list 
set listchars=tab:>-
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
"disable bells
set visualbell t_vb=
set noerrorbells

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
" for vimgrep auto open quickfix-window
autocmd QuickFixCmdPost *grep* cwindow
"クリップボード連携
set clipboard=unnamedplus,unnamed

"syntax highlight
syntax enable
set background=light
colorscheme solarized

"mode control
"インサートモードから抜けると自動的にIMEをオフにする
set iminsert=2
set imdisable

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
      \   'filename': 'MyFileName',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
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


"settings for deoplete.nvim
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000

" for deoplete, <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

"do not want to move to the next line after the selected word
inoremap <silent><expr><CR> pumvisible() ? deoplete#close_popup() : "\<CR>"

"settings for denite
"let g:python3_host_prog = expand('/usr/bin/python3')

"settings for NERDTree
let NERDTreeShowHidden= 1
autocmd vimenter * NERDTree
noremap <Space>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeHighlightCursorline = 0

"settings for vim-javascript
let g:javascript_plugin_jsdoc = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

augroup json_folding
  au!
  au FileType json setlocal foldmethod=syntax
augroup END

"fold settings
autocmd InsertEnter * if !exists('w:last_fdm')
            \| let w:last_fdm=&foldmethod
            \| setlocal foldmethod=manual
            \| endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
            \| let &l:foldmethod=w:last_fdm
            \| unlet w:last_fdm
            \| endif

"solve too slow problem
set lazyredraw
set ttyfast

"setting for vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config = 1

" Setting for Ale
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'tslint', 'eslint'],
\   'graphql': ['prettier', 'eslint'],
\   'json': ['prettier'],
\   'rust': ['rustfmt'],
\   'yaml': ['prettier'],
\}

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Settings for lightline-ale plugin
let g:lightline#ale#indicator_warnings = "Warning:"
let g:lightline#ale#indicator_errors = "Error:"

" Settings for vim-devicons
set encoding=utf-8


let OSTYPE = system('uname')
if OSTYPE == "Darwin\n"
  set guifont=DroidSansMono\ Nerd\ Font:h12
elseif OSTYPE == "Linux\n"
  set guifont=DroidSansMono\ Nerd\ Font\ 12
endif

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_unite = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderPatternMatching = 1
autocmd FileType nerdtree setlocal nolist
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
function! MyFileName()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  return filename . ' ' . WebDevIconsGetFileTypeSymbol()
endfunction

if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
"
" Markdown highlight
autocmd BufNewFile,BufRead *.md set filetype=markdown

" for LanguageClient-neovim
set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescript.tsx': ['javascript-typescript-stdio'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ }
"    \ 'kotlin': ['kotlin-language-server'],
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :sb <CR>:call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
set runtimepath+=~/.vim/pack/mypackage/start/LanguageClient-neovim

" TypeScript
autocmd BufRead,BufNewFile *.ts set filetype=typescript

" for vim-fugitive
nnoremap <silent> gs :Gstatus<CR> 

" for aliases
command Gpushh Gpush origin HEAD
command Gpullh Gpull origin HEAD

" for vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.erb,*.jsx,*.js,*.tsx"
let g:closetag_xhtml_filenames = '*.xhtml,*.erb,*.jsx,*.js,*.tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" for tabnine
set rtp+=~/dotfiles/.vim/pack/mypackage/start/tabnine-vim

" ***************************************************************************
" * CAUTION: Put below lines at the very end of your vimrc file.            *
" * For more details, https://github.com/w0rp/ale#generating-vim-help-files *
" ***************************************************************************
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL


