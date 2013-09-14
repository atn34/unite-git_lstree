function! unite#sources#git_lstree#define()
    return s:source
endfunction

let s:source = {
			\ 'name'            : 'git_lstree',
			\ 'hooks'           : {},
			\ }

function! s:source.hooks.on_init(args, context)
	if !unite#sources#git_lstree#check()
		call unite#util#print_error('Not a Git repository.')
	endif
endfunction

function! unite#sources#git_lstree#check()
	call unite#util#system('git rev-parse')
	return (unite#util#get_last_status() == 0)? 1 : 0
endfunction

function! s:source.gather_candidates(args, context)
	let l:result = unite#util#system('git ls-tree -r --name-only HEAD')
	let l:matches = split(l:result, '\n')
  return map(l:matches,
    \ '{
    \   "word"        : v:val,
    \   "source"      : "git_lstree",
    \   "kind"        : "file",
    \   "action__path": v:val,
    \ }')
endfunction
