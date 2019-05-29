
" Neomake
" ---------
"
let s:default_settings = {
	\ 'ignore_filetypes': ['startify', 'javascript'],
	\ }

let g:neomake = get(g:, 'neomake', {})
let g:neomake.automake = get(g:neomake, 'automake', {})
call extend(g:neomake.automake, s:default_settings, 'keep')

let g:neomake_open_list = 0
let g:neomake_verbose = 1

if ! empty(g:python3_host_prog)
	let g:neomake_python_python_exe = g:python3_host_prog
endif

let g:neomake_python_flake8_maker = {
		\ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202',  '--format=default'],
		\ 'errorformat':
				\ '%E%f:%l: could not compile,%-Z%p^,' .
				\ '%A%f:%l:%c: %t%n %m,' .
				\ '%A%f:%l: %t%n %m,' .
				\ '%-G%.%#',
		\ }

let g:neomake_python_enabled_makers = ['pylint', 'flake8', 'pycodestyle', 'pyflakes' ,'pep8']

" YAML / ANSIBLE
let g:neomake_yaml_enabled_makers = ['yamllint']
let g:neomake_ansible_enabled_makers = ['yamllint']
let g:neomake_ansible_yamllint_maker = neomake#makers#ft#yaml#yamllint()

" SHELL
let g:neomake_shellcheck_args = ['-fgcc']

" JAVASCRIPT / JSX
function! s:set_javascript_exe()
	" Set buffer makers to ESLint or Flow, if executables exist.
	let g:neomake_javascript_enabled_makers = []
	for item in ['eslint', 'flow']
		let l:exe = s:find_node_executable(item)
		if ! empty(l:exe)
			call add(g:neomake_javascript_enabled_makers, item)
			let b:neomake_javascript_{item}_exe = l:exe
		endif
	endfor
	let g:neomake_jsx_enabled_makers = g:neomake_javascript_enabled_makers
endfunction

function! s:find_node_executable(cmd)
	" Find locally-installed NodeJS executable.
	" Credits: https://github.com/jaawerth/nrun.vim
	let l:cwd = expand('%:p:h')
	let l:rp = fnamemodify('/', ':p')
	let l:hp = fnamemodify('~/', ':p')
	while l:cwd != l:hp && l:cwd != l:rp
		if filereadable(resolve(l:cwd . '/package.json'))
			let l:execPath = fnamemodify(l:cwd . '/node_modules/.bin/' . a:cmd, ':p')
			if executable(l:execPath)
				return l:execPath
			endif
		endif
		let l:cwd = resolve(l:cwd . '/..')
	endwhile
	return ''
endfunction

autocmd MyAutoCmd BufWritePre *.js call s:set_javascript_exe()
call s:set_javascript_exe()

" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
