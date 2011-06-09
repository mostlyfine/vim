compiler perl

autocmd BufNewFile,BufRead *.tt,*.cfm setlocal filetype=html
autocmd BufNewFile,BufRead *.pl,*.t,*.cgi,*.psgi setlocal filetype=perl

" config -----------------------------------------------------------
set formatoptions-=r " 挿入モードで改行したときにコメントを自動挿入しない
set formatoptions-=o " ノーマルモードでoしたときにコメントを自動挿入しない
set dictionary=$HOME/.vim/dict/perl_functions.dict

" keybind ----------------------------------------------------------
nnoremap <Leader>pt <ESC>:%! perltidy<CR>
vnoremap <Leader>pt <ESC>:'<,'>! perltidy<CR>

" 選択範囲を整形(perl)
vnoremap pt :<C-v>! perltidy<CR>

" variables --------------------------------------------------------
let perl_no_scope_in_variables=1
let perl_include_pod=1
let perl_extended_vars=1
let perl_perl_sync_dist=250

" Template Toolkit用
iab TT [% %]
iab TIF [% IF %][% END %]
iab TIFE [% ELSIF %]
iab TIFL [% ELSE %]
iab TF [% FOREACH %][% END %]
iab TW [% WHILE %][% END %]
iab TS [% SWITCH %][% CASE %][% END %]
iab Ts [% etc %]
iab TI [% INCLUDE "" %]

iab _perls #!/usr/bin/env perl<CR><BS><CR>use strict;<CR>use warnings;<CR>use utf8;<CR>
