set bg=dark
set hlsearch
set ignorecase
set list
set mouse=nv
set nowrap
set textwidth=79
set tabstop=3
set shiftwidth=3
set wildmode=list:longest,full
set lcs=tab:>.,eol:$

" Paste toggle
nnoremap Q gqap
vnoremap Q gq
nnoremap \tp :set invpaste paste?<CR>
nmap <F4> \tp
imap <F4> <C-O>\tp
set pastetoggle=<F4>

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

" Templates
function! LoadFileTemplate()
	silent! 0r ~/.vim/templates/%:e.tmpl
endfunction
autocmd BufNewFile * :call LoadFileTemplate()

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

" Align columns
map <C-t> :%!column -t -n -s '	'<CR>
map <C-T> :%!column -t -n<CR>

execute pathogen#infect()
syntax on
filetype plugin indent on
