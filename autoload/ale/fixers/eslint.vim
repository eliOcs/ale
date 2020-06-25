" Author: w0rp <devw0rp@gmail.com>
" Description: Fixing files with eslint.

function! ale#fixers#eslint#Fix(buffer) abort
    return {
    \   'command': ale#handlers#eslint#GetCommand(a:buffer)
    \       . ' --stdin-filename %s --stdin --fix-dry-run --format=json',
    \   'process_with': 'ale#fixers#eslint#ProcessFixDryRunOutput',
    \}
endfunction

function! ale#fixers#eslint#ProcessFixDryRunOutput(buffer, output) abort
    for l:item in ale#util#FuzzyJSONDecode(a:output, [])
        return split(get(l:item, 'output', ''), "\n")
    endfor

    return []
endfunction
