"  __  __               _                    
" |  \/  |_   _  __   _(_)_ __ ___  _ __ ___ 
" | |\/| | | | | \ \ / / | '_ ` _ \| '__/ __|
" | |  | | |_| |  \ V /| | | | | | | | | (__ 
" |_|  |_|\__, |   \_/ |_|_| |_| |_|_|  \___|
"         |___/                              
" 
"-------------------vim-plug---------------
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree',{'on':'NERDTreeToggle'}
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'connorholyday/vim-snazzy'
Plug 'Yggdroot/indentLine',{'on':'IndentLinesToggle'}
Plug 'gcmt/wildfire.vim'
Plug 'preservim/nerdcommenter'
" coc需要先安装nodejs
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
"-------------------------通用vim配置----------------------------------
set nocp            "与vi不兼容
set backspace=2

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

"解决文本乱码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set ambiwidth=double    "防止特殊符号无法显示
set nobomb
set fileformats=unix,dos    "新建文件默认使用LF作为换行

"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"设置缩进为4空格等
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
set tabstop=4
set softtabstop=4	"按退格键时回退的空格数
set expandtab		"tab变为空格，若要使用tab，则ctrl-v-tab
autocmd BufRead *.md,*.tex setlocal sw=2 ts=2 sts=2

"有关*.un~,*~,*.swp 文件
set backup
set swapfile
set updatetime=4000
set undofile
set undolevels=10000
set directory=$HOME/.vim/tmp/swp//  "//告诉vim保存完整路径到文件名,使用作为分隔符
set backupdir=$HOME/.vim/tmp/backup//
set undodir=$HOME/.vim/tmp/undofile//

 
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
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
					
set textwidth=0		"阻止自动插入换行符，不一定起作用。还要看其他地方是否也有textwidth的设置
set wildmenu        "命令模式时自动补全菜单
set autoread        "如果文件编辑过程中被外部改变，发出提示
set clipboard=unnamedplus  "vim默认寄存器与剪切板共享,寄存器+(linux)
"set clipboard=unnamed  "vim默认寄存器与剪切板共享,寄存器*(windows)
set cursorline
set scrolloff=5
set foldmethod=indent
set nofoldenable
"set whichwrap=b,s,<,>,[,]
"set backspace=indent,eol,start whichwrap+=<,>,[,]   "光标在行首时往左则上移一行

colorscheme snazzy
" set guifont=DejaVu_Sans_Mono:h10    "gvim的字体（windows）
set guifont=DejaVu\ Sans\ Mono\ 10    "gvim的字体
 
filetype plugin indent on   "启动文件类型插件,文件类型自动缩进
syntax on

if &term == "alacritty"        "解决alacritty中vim没有颜色的问题
  let &term = "xterm-256color"
endif

"---------------- key maps 
noremap <C-P> :set paste! <CR>
noremap <LEADER><LEADER> <ESC>/<++>/<CR>:nohl<CR>c4l
" tabs
noremap <C-T> :tabe<CR>
noremap <C-left> :tabN<CR>
noremap <C-right> :tabn<CR>
" 保存退出
noremap <C-S> :w<CR>
noremap <C-Q> :q<CR>
inoremap <C-S> <ESC>:w<CR>
" 全选复制
noremap <C-A> ggVG
noremap <C-C> y
" '的作用是将剪切转化成删除
" 用法举例：'S+ctrl-v 粘贴复制的内容
noremap ' "_
" window
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
" function
vnoremap <C-N> :normal 
  " fzf.vim插件，模糊搜索buffer中文件内容（在map命令后不可能加"注释，所以只能单行注释
noremap <C-F> :Lines<CR>
noremap gf :NERDTreeToggle<CR>
  " 显示匹配数，n表示统计匹配数并且忽略:s的替换功能
noremap gp :%s///gn<CR>
noremap gr :%s///cg<left><left><left>
" other
    " 使用undo时更加友好
inoremap <c-w> <c-g>u<c-w>
    "insert模式下方便粘贴，如果是windows可能要换成*
inoremap <c-v> <c-r>+
" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

"-----------plugin setting-----------------------
set grepprg=rg\ --vimgrep\ --smart-case\ --follow "fzf.vim
let NERDTreeShowHidden=1

"----------coc config--------

" 默认安装的coc插件
"let g:coc_global_extensions = ['coc-json', 'coc-vimlsp', 'coc-python']

" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-o> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"----------------syntastic config----------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"----------------nerdcommenter config----------
let g:NERDSpaceDelims = 1
let g:NERDAltDelims_c = 1
map gc <Plug>NERDCommenterToggle

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

