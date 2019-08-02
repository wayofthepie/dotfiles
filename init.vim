scriptencoding utf-8
set background=dark
let g:airline_theme= 'onedark'
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
set number

" Custom commands
com! FormatJSON %!python -m json.tool

" Plugins
call plug#begin('~/.vim/plugged')

" CoC
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" CoC extensions
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tslint-plugin', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}

" End Coc extensions

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'

Plug 'leafgarland/typescript-vim'

"Plug 'rakr/vim-one' " color scheme
Plug 'joshdick/onedark.vim' " color scheme
"Plug 'morhetz/gruvbox'

Plug 'tpope/vim-surround' 

Plug 'meain/vim-package-info', { 'do': 'npm install' }

Plug 'cespare/vim-toml'

Plug 'LnL7/vim-nix'
call plug#end()

" Allow comments in json Coc config
augroup fix_jsonc
  autocmd!
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup end

" Setup fzf
nnoremap <silent> ,f :FZF<CR>

" Setup statusline
set statusline=%{FugitiveStatusline()}

" Airline setup
" requires manual install of https://github.com/powerline/fonts
" and then setting a powerline font in settings
let g:airline_powerline_fonts = 1 


" Terminal setup 
" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec 'resize ' . a:height
        try
            exec 'buffer ' . g:term_buf
        catch
            call termopen($SHELL, {'detach': 0})
            let g:term_buf = bufnr('')
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

colorscheme onedark

" Toggle terminal on/off (neovim)
nnoremap <A-#> :call TermToggle(30)<CR>
inoremap <A-#> <Esc>:call TermToggle(30)<CR>
tnoremap <A-#> <C-\><C-n>:call TermToggle(30)<CR>

nnoremap <C-o> :Files<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>


inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
 
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * if ! coc#util#has_float() | call CocActionAsync('doHover') | endif 

au BufNewFile,BufRead *.tsx set filetype=typescript.tsx
let g:airline#extensions#tabline#enabled = 1
nmap <C-n> :bn<CR>  " Next buffer in list
nmap <C-p> :bp<CR>  " Previous buffer in list
nmap <C-j> :b#<CR>  " Previous buffer you were in
nnoremap <silent> ,c :bdelete<CR>
nnoremap <A-r> :so ~/.config/nvim/init.vim<CR> " reload current config

nnoremap <silent> ,ru :CocCommand rls.restart <CR> " reload current file

nmap <silent> ,rn <Plug>(coc-rename)
nmap <silent> ,s :w<CR>

nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"
