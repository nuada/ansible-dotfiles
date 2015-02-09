syntax on

set autoindent
set bg=dark
set formatoptions-=t
set helplang=en
set history=50
set hlsearch
set ignorecase
set incsearch
set lcs=tab:>.,eol:$
set list
set mouse=nv
set nowrap
set ruler
set shiftround
set shiftwidth=3
set shortmess=a
set showcmd
set showmode
set smartcase
set textwidth=79
set ts=3
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100
set wildmode=list:longest,full

if has("gui_running")
	" Highligth current line
	set cursorline
	" Line numbering
	set nu
	set nuw=5
	" Disable menu and toolbar
	set guioptions-=T
	set guioptions-=m
	set guifont=Monospace\ 9
	color zellner
	" Don't blink cursor
	let &guicursor = &guicursor . ",a:blinkon0"
endif

filetype on
autocmd FileType c,cpp,slang set cindent
autocmd FileType css set smartindent
autocmd FileType html set formatoptions+=tl
autocmd FileType html,css set noexpandtab tabstop=3
autocmd FileType make set noexpandtab shiftwidth=4

nnoremap Q gqap
vnoremap Q gq
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

" Read-only buffers
if &readonly
	set nomod
	map q :q!<CR>
	set ts=8
	set nolist
endif

" Templates
function! LoadFileTemplate()
	silent! 0r ~/.vim/templates/%:e.tmpl
endfunction
autocmd BufNewFile * :call LoadFileTemplate()

" Auto jump to line, grep style: some/path/file.ext:lineno:what_ever
autocmd BufReadCmd *:[0-9]\+:* silent edit `=substitute(expand('<afile>'), ':[0-9]\+:.*', '', '')` | exe substitute(expand('<afile>'), '.*:\([0-9]\+\):.*', ':\1', '')

function! Format()
	if &filetype=='xml'
		:%!xmllint --format -
	elseif &filetype=='c'
		:%!astyle -t3 -b -p -U
	elseif &filetype=='javascript'
		:%!js-beautify --indent-with-tabs --wrap-line-length 120 --file -
	elseif &filetype=='css'
		:%!css-beautify --indent-size 3 --file -
	elseif &filetype=='html'
		:%!html-beautify --indent-size 3 --wrap-line-length 120 --file -
	else
		echo "Formatting of this file type is not supported!"
	endif
endfunction
map <F9> :call Format()<CR>
