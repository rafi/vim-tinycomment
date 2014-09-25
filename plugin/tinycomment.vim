
" vim-tinycomment - Robust light-weight commenting for Vim
" Maintainer: Rafael Bodill <justrafi at gmail dot com>
" Version:    0.9
"---------------------------------------------------------

" Disable reload {{{
if exists('g:loaded_tinycomment') && g:loaded_tinycomment
	finish
endif
let g:loaded_tinycomment = 1

" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" Commands {{{
command! -nargs=* TinyCommentLines :call tinycomment#lines(<f-args>)
command! -nargs=? TinyCommentBlock :call tinycomment#block(<f-args>)

" }}}
" Mappings {{{
if get(g:, 'tinycomment_disable_keymaps', 1)
	nmap  <leader>v  :call tinycomment#lines()<CR>zvj
	vmap  <leader>v  :call tinycomment#lines()<CR>zvj
	vmap  <leader>V  :<C-u>call tinycomment#block()<CR>zvj
endif
" }}}

" tinycomment#lines(string [commentstr], string [eol]) "{{{
" Toggle comment on current or selected lines
" Uses &commentstring or a pattern as first argument.
" If a second argument is given, it will be used to
" separate lines on a block comment.
"
" Examples:
"   call tinycomment#lines()  " Uses Vim's &commentstring
"   call tinycomment#lines('/*%s*/', '\r')
"   call tinycomment#lines('//%s')
"
function! tinycomment#lines(...)
	let cms   = a:0 > 0 ? a:1 : &commentstring
	let parts = split(cms, '%s')
	let total = len(parts)
	if total == 0
		call tinycomment#error('Invalid commentstring value ('.cms.').')
		return
	elseif a:0 > 1 && total < 2
		call tinycomment#error('Filetype `'.&ft.'` does not support block comments.')
		return
	elseif total > 2
		call tinycomment#error('Invalid commentstring ('.cms.'), only one %s is allowed.')
		return
	endif

	" Escape slashes in both parts
	let parts[0] = escape(parts[0], '\/')
	if total > 1
		let parts[1] = escape(parts[1], '\/')
	endif

	if getline('.') =~ '^\V'.parts[0]
		if a:0 > 1 && total > 1
			" Block: Un-wrap text and new lines in selected lines
			silent execute 's/\V'.parts[0].'\s\*\_s\(\_.\*\)\_s\+'.parts[1].'\s\*\%V/\1/e'
		else
			" Lines: Remove comment string from each line
			silent execute 's/^\V'.parts[0].'//ge'
			if total > 1
				silent execute 's/\V'.parts[1].'\$//ge'
			endif
		endif
	else
		if a:0 > 1 && total > 1
			" Block: Wrap all text and new lines in selected lines
			silent execute 's/^\(\_.*\)\%V/'.parts[0].a:2.'\1'.a:2.parts[1].'/e'
		else
			" Lines: Add comment string to each line
			silent execute 's/^/'.parts[0].'/ge'
			if total > 1
				silent execute 's/$/'.parts[1].'/ge'
			endif
		endif
	endif
	" Clear the last used search pattern
	let @/=''
endfunction

" }}}
" tinycomment#block(string [eol]) "{{{
" Shortcut to block mode
function! tinycomment#block(...)
	if  exists('b:commentblockstring')
		let commentstring = b:commentblockstring
	else
		let commentstring = &commentstring
	endif

	call tinycomment#lines(commentstring, a:0 > 0 ? a:1 : '\r')
endfunction

" }}}
" tinycomment#error(string <msg>) "{{{
" Helper function to display an error in cmdwin
function! tinycomment#error(msg)
	echohl WarningMsg | echomsg a:msg | echohl None
endfunction
" }}}

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}

" vim: set ts=2 sw=2 tw=80 noet :
