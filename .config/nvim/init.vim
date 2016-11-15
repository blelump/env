source ~/.config/nvim/plugins.vim

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" enable 24 bit color support if supported
if (empty($TMUX) && has("termguicolors"))
    set termguicolors
endif

let mapleader = ','

filetype plugin on
set omnifunc=syntaxcomplete#Complete

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:gruvbox_italic=1
set termguicolors
set background=dark

syntax on
set encoding=utf-8
colorscheme gruvbox

set number                  " show line numbers
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set colorcolumn=80
set hidden

set clipboard+=unnamedplus
set autoindent              " automatically set indent of new line
set smartindent

" Tab control
set expandtab             " insert tabs rather than spaces for <Tab>
set smarttab                " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=2               " the visible width of tabs
set softtabstop=2           " edit as if the tabs are 4 characters wide
set shiftwidth=2            " number of spaces to use for indent and unindent
set shiftround              " round indent to a multiple of 'shiftwidth'
set completeopt+=longest

" code folding settings
set foldmethod=syntax       " fold based on indent
set foldnestmax=10          " deepest fold is 10 levels
set nofoldenable            " don't fold by default
set foldlevel=1

" Searching
set ignorecase              " case insensitive searching
set smartcase               " case-sensitive if expresson contains a capital letter
set hlsearch                " highlight search results
set incsearch               " set incremental search, like modern browsers
set nolazyredraw            " don't redraw while executing macros

set magic                   " Set magic on, for regex

set showmatch               " show matching braces
set mat=2                   " how many tenths of a second to blink

" Open new split panes to right and bottom
set splitbelow
set splitright

" edit ~/.config/nvim/init.vim
map <leader>ev :e! ~/.config/nvim/init.vim<cr>

" enable . command in visual mode
vnoremap . :normal .<cr>

" Easier buffers navigation
map <silent> <C-h> :call functions#WinMove('h')<cr>
map <silent> <C-j> :call functions#WinMove('j')<cr>
map <silent> <C-k> :call functions#WinMove('k')<cr>
map <silent> <C-l> :call functions#WinMove('l')<cr>

" Deal with trailing whitespaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre     *.rb :call TrimWhiteSpace()

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkred
match ExtraWhitespace /\s\+$\|\t/

" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>

let NERDTreeShowHidden=1
let NERDTreeDirArrowExpandable = '▷'
let NERDTreeDirArrowCollapsible = '▼'

" FZF config
let g:fzf_layout = { 'down': '~25%' }

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


nmap <silent> <leader>p :FZF<cr>
nmap <leader>f :Ack ""<Left>
map <F12> :call fzf#vim#tags(expand('<cword>'))<cr>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Buffers
nmap <silent> <leader>r :Buffers<cr>
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
nmap <leader>. <c-^>
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>


" Windows
" go to next window
map <leader>m <C-w>W

" Move the whole line above/below
map  <A-,> :m -2<cr>
map  <A-.> :m +1<cr>

" remap esc
inoremap jk <esc>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" shortcut to save
nmap <leader>, :w<cr>

nmap <Leader>s :%s//g<Left><Left>
nmap <Leader><space> gg=G''
noremap <F10> :set list!<CR>

" Textmate style indentation
vmap <leader>[ <gv
vmap <leader>] >gv
nmap <leader>[ <<
nmap <leader>] >>

" Airline conf
let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
let g:airline#extensions#tabline#tab_min_count = 2 " only show tabline if tabs are being used (more than 1 tab open)
"let g:airline#extensions#tabline#show_buffers = 0 " do not show open buffers in tabline
let g:airline#extensions#tabline#show_splits = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" CtrlSF conf
let g:ctrlsf_ackprg = 'ag'
nmap <C-F>r <Plug>CtrlSFPrompt -G .rb <space>

" CamelCaseMotion conf
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" Clever XML tags autocomplete
inoremap ><Tab> ><Esc>F<lyt>o</<C-r>"><Esc>O<Space>

" SplitjoinJoin conf
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>

" Deoplete conf
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_camel_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" vim-commentary conf
xmap <C-_> <Plug>Commentary
nmap <C-_> <Plug>Commentary
omap <C-_> <Plug>Commentary

" vim-test conf
let test#strategy = {
  \ 'nearest': 'vtr',
  \ 'file':    'vtr',
  \ 'suite':   'basic',
\}
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" vim-tmux-navigator conf
let g:tmux_navigator_no_mappings = 1
" nmap <silent> <c-h> :TmuxNavigateLeft<cr>
" nmap <silent> <c-l> :TmuxNavigateRight<cr>
nmap <silent> <c-j> :TmuxNavigateDown<cr>
nmap <silent> <c-k> :TmuxNavigateUp<cr>
nmap <silent> <c-\> :TmuxNavigatePrevious<cr>
