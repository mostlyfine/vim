compiler ruby

" RSpecのテスト実行
function! Specrun()
  let rails_spec_pat = 'spec/\(models\|controllers\|views\|helpers\)/.*_spec\.rb$'
  if expand('%:p') =~ rails_spec_pat
    exe '!./script/spec -cfs -l '.line('.').' '.expand('%:p')
  else
    :!spec -cfs %
  endif
endfunction
autocmd BufRead,BufNewFile *_spec.rb :command! Specrun :call Specrun()

function! s:RunRspec (opts)
  let rails_spec_path_re = '\<spec/\(models\|controllers\|views\|helpers\)/.*_spec\.rb$'

  if( expand('%') =~ rails_spec_path_re && filereadable('script/spec') )
"let command = '!ruby script/spec '
    let spec_command = '!spec '
    if filereadable('tmp/pids/spec_server.pid')
      let spec_command = spec_command . ' --drb '
    endif
  else
    let spec_command = '!spec '
  endif
  exe spec_command . a:opts . ' ' . expand('%:p')
endfunction

function! s:RunCucumber (feature)
  if( filereadable('Rakefile') )
    let command = '!rake features FEATURE='
  elseif( filereadable('script/cucumber') )
    let command = '!script/cucumber --language ja '
  else
    let command = '!cucumber --language ja '
  endif
  exe command . a:feature
endfunction

function! <SID>RunBehavior ()
  call s:RunRspec('--format=n --color')
endfunction

function! <SID>RunExample ()
  call s:RunRspec('--format=n --color --line ' . line('.'))
endfunction

function! <SID>RunScinario ()
  call s:RunCucumber(expand('%:p') . ':' . line('.'))
endfunction

function! <SID>RunFeature ()
  call s:RunCucumber(expand('%:p'))
endfunction

function! s:SetupCucumberVim ()
  command! RunFeature call <SID>RunFeature()
  command! RunScinario call <SID>RunScinario()

  nnoremap -fe :RunFeature<CR>
  nnoremap -sc :RunScinario<CR>
endfunction

function! s:SetupRspecVim()
  command! RunExample call <SID>RunExample()
  command! RunBehavior call <SID>RunBehavior()

  nnoremap -ex :RunExample<CR>
  nnoremap -bh :RunBehavior<CR>
endfunction

autocmd BufRead,BufEnter *_spec.rb call s:SetupRspecVim()
autocmd BufRead,BufEnter *.feature call s:SetupCucumberVim()

" config -----------------------------------------------------------
set tabstop=2
set shiftwidth=2
set makeprg=ruby\ -c\ %
set errorformat=%m\ in\ %f\ on\ line\ %l
set dictionary=$HOME/.vim/dict/ruby187.dict
"
" keybind ----------------------------------------------------------
nnoremap <Leader>r <ESC>:!ruby %<CR>

iab _ruby #!/usr/bin/env ruby<CR><BS><CR>
iab ## # -*- coding: utf-8 -*-
