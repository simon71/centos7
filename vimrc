set nocompatible 
autocmd! bufwritepost $HOME/simon/.vimrc source %


" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

"" set pastetoggle=<F2>
"" set clipboard=unnamed


" Mouse and backspace
"" set mouse=a  " on OSX press ALT and click
"" set bs=2     " make backspace behave like normal again


" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","


" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
"" noremap <C-n> :nohl<CR>
"" vnoremap <C-n> :nohl<CR>
"" inoremap <C-n> :nohl<CR>


" Quicksave command
"" noremap <C-Z> :update<CR>
"" vnoremap <C-Z> <C-C>:update<CR>
"" inoremap <C-Z> <C-O>:update<CR>


" Quick quit command
"" noremap <Leader>e :quit<CR>  " Quit current window
"" noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using
" Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
" map <c-j> <c-w>j
" map <c-k> <c-w>k
" map <c-l> <c-w>l
" map <c-h> <c-w>h
map <c-w><down> <c-w>j
map <c-w><up> <c-w>k
map <c-w><right> <c-w>l
map <c-w><left> <c-w>h


" easier moving between buffers
map <Leader>n <esc>:bprevious<CR>
map <Leader>m <esc>:bnext<CR>


" map sort function to a key
" vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
" vnoremap < <gv  " better indentation
" vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

"set paset mode to F2
set pastetoggle=<F2>

" Color scheme
set t_Co=256
color evening

if &t_Co >= 256 || has("gui_running")
    colorscheme wombat256mod
endif

if &t_Co > 2 || has("gui_running")
    "switch synta highlight on, when termian has color
    syntax on
endif

" shortcut mapping
nnoremap ; :

" stops the arrow keys working
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" formatting for drop down
let g:NERDTreeDirArrowCollapsible="~"
let g:NERDTreeDirArrowExpandable="+"

" Use Q for formating the current paragraph (or slection)
vmap Q gp
nmap Q gqap

" Clears search buffer with ,/
nmap <slient> ,/ :nohlsearch<CR>

" Lets you use w!! to write when you forgot to use sudo
cmap w!! w !sudo tee % >/dev/null

" causes the curosr to jump to next command instead of next line
nnoremap j gj
nnoremap k gk

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


" Showing line numbers and length
set number  " show line numbers
set textwidth=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
"" set colorcolumn=80
highlight ColorColumn ctermbg=233


" easier formatting of paragraphs
"" vmap Q gq
"" nmap Q gqap


" Useful settings
set history=700
set undolevels=700
set mouse=a
set showmatch
set smarttab

"real programmes don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set autoindent

" Don't ring any bell.
set noerrorbells novisualbell


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile


" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" Turn folding off for real, hopefully
" set foldmethod=manual
" set nofoldenable
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
" If a file is changed outside of vim, automatically reload it without asking
set autoread


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType puppet,ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Indent p tags
  " autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal ft=

  " indent slim two spaces, not four
  autocmd! FileType *.slim set sw=2 sts=2 et
augroup END

augroup markdown

    au! BufRead,BufNewFile *.mkd   set filetype=markdown
    au! BufRead,BufNewFile *.markdown   set filetype=markdown
    au! BufRead,BufNewFile *.md   set filetype=markdown

augroup END


" Setup Pathogen to manage your plugins
call pathogen#infect()


" Python IDE Setup
" ============================================================================


" Settings for vim-powerline
set laststatus=2


" Setting Status line
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)


" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
"" let g:ctrlp_max_height = 30
"" set wildignore+=*.pyc
"" set wildignore+=*_build/*
"" set wildignore+=*/coverage/*

" Settings for jedi-vim
"" let g:jedi#usages_command = "<leader>z"
"" let g:jedi#popup_on_dot = 0
"" let g:jedi#popup_select_first = 0
"" map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
"" set completeopt=longest,menuone
"" function! OmniPopup(action)
""     if pumvisible()
""         if a:action == 'j'
""             return "\<C-N>"
""         elseif a:action == 'k'
""             return "\<C-P>"
""         endif
""     endif
""     return a:action
"" endfunction

"" inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
"" inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

autocmd vimenter * NERDTreeToggle
autocmd VimEnter * wincmd l
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let Tlist_Use_Right_Window   = 1

" MiniBufExpl Colors
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#CD5907 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi MBEVisibleChanged       guifg=#F1266F guibg=fg
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
