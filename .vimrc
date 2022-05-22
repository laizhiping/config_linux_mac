" set encoding
set encoding=utf-8
set fileencodings=utf-8,gb18030,gbk
set fileencoding=utf-8

" 定义快捷键的前缀，即<Leader>
let mapleader=";"
" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $
" 将H映射为到行首
nnoremap H <S-^>
" 将L映射为到行尾
nnoremap L $
" 将esc映射为control + c
nmap <C>c esc
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至左方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j
 
" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
 
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" 防止退格键无法使用
set backspace=indent,eol,start
" 取消自动补全的preview窗口
set completeopt-=preview
" vim 自身命令行模式智能补全
set wildmenu
 
" 设置显示行号
set number
" 设置智能缩进
set smartindent
" 下一行自动复制本行的缩进
set autoindent
" 设置缩进的空格数
set shiftwidth=4
" 设置tab键对应的空格数
set tabstop=4
" 自动替换tab键为空格
set expandtab
" 设置光标在屏幕中的位置
set scrolloff=3

 " 启用鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 以下是高亮搜索项
set hlsearch
set display=lastline
" 高亮光标所在行列
set cursorcolumn
set cursorline
" highlight CursorLine   cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
" highlight CursorColumn cterm=NONE ctermbg=black ctermfg=NONE guibg=NONE guifg=NONE
" 总是显示状态栏
set laststatus=2
" 自动匹配括号
set showmatch
 
" 打开文件默认不折叠代码
set foldlevelstart=99
" " 代码可折叠
set foldmethod=indent
set foldlevel=99
" 所有python语法高亮功能生效
let python_highlight_all=1
 
set term=screen
 
" 显示执行的命令
set showcmd
" 设置自动保存
set autowrite
 
" 括号自动补全
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ []<ESC>i
" inoremap } <c-r>=ClosePair('}')<CR>
 
" 为python文件自动添加文件头
autocmd BufNewFile *.py execute ":call NewPy()"
function! NewPy() 
    " call setline(1,"#!/usr/bin/env python"   
    call setline(1,"# -*- encoding: utf-8 -*-")
endfunction
 
" 记录上次关闭vim光标所在的位置
autocmd BufReadPost *
            \ if line("'\"")>0&&line("'\"")<=line("$") |
            \   exe "normal g'\"" |
                        \ endif
" 设置背景色
syntax enable
let g:solarized_termtrans = 1
set background=dark
 
" 高亮行列的配色方
" 深色
" highlight CursorLine   cterm=NONE ctermbg=black ctermfg=white guibg=red guifg=white
" highlight CursorColumn cterm=NONE ctermbg=black ctermfg=white guibg=red guifg=white
" 浅色
" highlight CursorLine   cterm=NONE ctermbg=lightgray ctermfg=black guibg=red guifg=white
" highlight CursorColumn cterm=NONE ctermbg=lightgray ctermfg=black guibg=red guifg=white
" 修改高亮的背景色
" highlight SyntasticErrorSign guifg=white guibg=black
 
"自动补全结束函数
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
set pastetoggle=<F9>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" "vundle 环境设置
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" " vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'git@github.com:Valloric/YouCompleteMe.git’
call vundle#end()
filetype plugin indent on


" YouCompleteMe
" Python Semantic Completion
let g:ycm_python_binary_path = '/usr/bin/python3'
" C family Completion Path
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" 跳转快捷键
nnoremap <c-k> :YcmCompleter GoToDeclaration<CR>|
nnoremap <c-h> :YcmCompleter GoToDefinition<CR>| 
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|
" 停止提示是否载入本地ycm_extra_conf文件
let g:ycm_confirm_extra_conf = 0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files = 1
" 从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2
" 在注释输入中也能补全
let g:ycm_complete_in_comments = 1
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 弹出列表时选择第1项的快捷键(默认为<TAB>和<Down>)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" 弹出列表时选择前1项的快捷键(默认为<S-TAB>和<UP>)
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" 主动补全, 默认为<C-Space>
"let g:ycm_key_invoke_completion = ['<C-Space>']
" 停止显示补全列表(防止列表影响视野), 可以按<C-Space>重新弹出
"let g:ycm_key_list_stop_completion = ['<C-y>']
