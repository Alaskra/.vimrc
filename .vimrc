"  __  __               _                    
" |  \/  |_   _  __   _(_)_ __ ___  _ __ ___ 
" | |\/| | | | | \ \ / / | '_ ` _ \| '__/ __|
" | |  | | |_| |  \ V /| | | | | | | | | (__ 
" |_|  |_|\__, |   \_/ |_|_| |_| |_|_|  \___|
"         |___/                              
" 
"-------------------vim-plug---------------
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree',{'on':'NERDTreeToggle'}
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'connorholyday/vim-snazzy'
Plug 'gcmt/wildfire.vim'
Plug 'tpope/vim-commentary'
call plug#end()
"-------------------------通用vim配置----------------------------------
set backspace=2 " same as ":set backspace=indent,eol,start"
set whichwrap=b,s,<,>,[,]
set nowrap "关闭折行
set list lcs=tab:\|\ "显示tab以区分space
set guifont=新宋体:h14:cGB2312:qDRAFT "用于windows gvim
"解决文本乱码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileformats=unix,dos    "新建文件默认使用LF作为换行
" ambiwidth=double在nvim中有bug，先不设置
" if !exists("g:vscode")
    " set ambiwidth=double " 防止某些字符重叠，比如“♥” . if 语句防止vscode-nvim插件报错
" endif

"设置缩进为4空格等
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
set tabstop=4
set softtabstop=4   "按退格键时回退的空格数
set expandtab       "tab变为空格，若要使用tab，则ctrl-v-tab
autocmd BufRead *.md,*.tex setlocal sw=2 ts=2 sts=2

if !isdirectory($HOME."/.vim/tmp/backup")
    silent! execute "!mkdir -p ~/.vim/tmp/{backup,swap,undo}"
endif
set backup " 在写入文件前保存之前的内容到*.~文件中，backup文件位置由backupdir变量设置
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
 
"底部状态栏
set showcmd         " Show (partial) command in status line.
set showmode        "显示当前模式
set ruler
set number          " Show line numbers.

 
"搜索
set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
 
"其他
set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
 
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <cr> in Insert mode or when using the "o" or "O"
                    " command).
set wildmenu        "命令模式时自动补全菜单
set autoread        "如果文件编辑过程中被外部改变，发出提示
set clipboard=unnamedplus  "vim默认寄存器与剪切板共享,寄存器+(linux)
"set clipboard=unnamed  "vim默认寄存器与剪切板共享,寄存器*(windows)
set cursorline
set scrolloff=5
setlocal foldmethod=syntax " za to toggle fold
autocmd BufRead *.py,*.txt setlocal foldmethod=indent " for python fold
set nofoldenable
set foldlevel=99
function! MyFoldText()
    let nl = v:foldend - v:foldstart + 1
    let txt = getline(v:foldstart) . ' : length ' . nl
    return txt
endfunction
set foldtext=MyFoldText()

colorscheme snazzy
filetype plugin indent on   "启动文件类型插件,文件类型自动缩进
syntax on

if &term == "alacritty"        "解决alacritty中vim没有颜色的问题
  let &term = "xterm-256color"
endif

"-----------plugin setting-----------------------
let g:airline#extensions#tabline#enabled = 1 "Automatically displays all buffers when there's only one tab open.
autocmd BufRead *.pro setlocal commentstring=#\ %s

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
let NERDTreeQuitOnOpen=1
let g:NERDSpaceDelims = 1
let g:NERDAltDelims_c = 1
noremap gw :NERDTree %<cr>
noremap ge :NERDTreeToggle<cr>


"--------------------##### auto fcitx  ###########
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式
autocmd InsertEnter * call Fcitx2zh()
"--------------##### auto fcitx end ######

"---------------- key maps
noremap <leader><leader> <esc>/<++>/<cr>:nohl<cr>c4l
vnoremap <c-n> :normal
cnoremap <c-v> <c-r>+
" tabs
noremap <c-t> :tabe<cr>
noremap <c-left> :tabN<cr>
noremap <c-right> :tabn<cr>
" buffers
noremap g1 :bN<cr>
noremap g2 :bn<cr>
noremap gq :bd<cr>
" 显示匹配数，n表示统计匹配数并且忽略:s的替换功能
noremap gp :%s///gn<cr>
noremap gr :%s///cg<left><left><left>

" 模拟一般gui编辑器的操作
noremap <c-s> :w<cr>
nnoremap <c-a> ggVG
inoremap <c-s> <esc>:w<cr>
inoremap <c-a> <esc>ggVG
inoremap <c-v> <c-r>+
vnoremap <c-c> y
vnoremap <c-x> d

" '的作用是将剪切转化成删除
" 用法举例：'S+ctrl-v 粘贴复制的内容
noremap ' "_
noremap Y y$
" window
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
" Unbind some useless/annoying default key bindings.
noremap H 5zh
noremap K :echo "you are press K"<cr>
noremap L 5zl
noremap U :echo "you are press U"<cr>
noremap <c-u> 5k
noremap <c-d> 5j
nnoremap Q <nop>
nnoremap q: <nop>
" 使用undo时更加友好
inoremap <c-w> <c-g>u<c-w>
inoremap <c-u> <c-g>u<c-u>
