" Theme
<<<<<<< HEAD
" -----

" Enable 256 color terminal
set t_Co=256

" Enable true color
if has('termguicolors')
		set termguicolors
endif

if has('gui_running')
	set background=dark
	set lines=40
	set columns=150
endif

function! s:theme_reload(name)
	let theme_path = $VIMPATH.'/themes/'.a:name.'.vim'
	if filereadable(theme_path)
		execute 'source' fnameescape(theme_path)
=======
" ---
"
" Autoloads theme according to user selected colorschemes

function! s:theme_init()
	" Load cached colorscheme or hybrid by default
	let l:default = 'hybrid'
	let l:cache = s:theme_cache_file()
	if ! exists('g:colors_name')
		set background=dark
		let l:scheme = filereadable(l:cache) ? readfile(l:cache)[0] : l:default
		silent! execute 'colorscheme' l:scheme
	endif
endfunction

function! s:theme_autoload()
	if exists('g:colors_name')
		let theme_path = $VIM_PATH . '/themes/' . g:colors_name . '.vim'
		if filereadable(theme_path)
			execute 'source' fnameescape(theme_path)
		endif
>>>>>>> 2e124338d076cb66bd08a8b0d121c5b66935a1ef
		" Persist theme
		call writefile([g:colors_name], s:theme_cache_file())
	endif
endfunction

<<<<<<< HEAD
" THEME NAME
let g:theme_name = 'gotham'
autocmd MyAutoCmd ColorScheme * call s:theme_reload(g:theme_name)

" COLORSCHEME NAME
let s:cache = $VARPATH.'/theme.txt'
if ! exists('g:colors_name')
	set background=dark
	execute 'colorscheme'
		\ filereadable(s:cache) ? readfile(s:cache)[0] : 'hybrid'
endif
=======
function! s:theme_cache_file()
	return $DATA_PATH . '/theme.txt'
endfunction

function! s:theme_cached_scheme(default)
	let l:cache_file = s:theme_cache_file()
	return filereadable(l:cache_file) ? readfile(l:cache_file)[0] : a:default
endfunction

function! s:theme_cleanup()
	if ! exists('g:colors_name')
		return
	endif
	highlight clear
endfunction

augroup user_theme
	autocmd!
	autocmd ColorScheme * call s:theme_autoload()
	if has('patch-8.0.1781') || has('nvim-0.3.2')
		autocmd ColorSchemePre * call s:theme_cleanup()
	endif
augroup END

call s:theme_init()
>>>>>>> 2e124338d076cb66bd08a8b0d121c5b66935a1ef

" vim: set ts=2 sw=2 tw=80 noet :
