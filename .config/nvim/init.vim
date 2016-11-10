source ~/.config/nvim/plugins.vim

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" enable 24 bit color support if supported
if (empty($TMUX) && has("termguicolors"))
    set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:gruvbox_italic=1
set termguicolors
set background=dark

syntax on
colorscheme gruvbox
