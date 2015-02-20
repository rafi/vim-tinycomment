
" vim-tinycomment - Robust light-weight commenting for Vim
" Maintainer: Rafael Bodill <justrafi at gmail dot com>
" Version:    0.9
"---------------------------------------------------------

" Ensure loading request {{{
if ! exists('g:loaded_tinycomment')
  finish
endif

" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim

" }}}
" cmd: tinycomment {{{
augroup tinycomment
	autocmd!
	autocmd FileType * unlet! b:commentblockstring

	autocmd FileType ave,basic,elf,lscript,vb  setlocal commentstring='%s
	autocmd FileType css,less,patran           setlocal commentstring=/*%s*/
	autocmd FileType mustache                  setlocal commentstring={{!%s}}
	autocmd FileType gsp,jsp                   setlocal commentstring=<%--%s--%>
	autocmd FileType haml                      setlocal commentstring=-#%s
	autocmd FileType mail,mkd                  setlocal commentstring=>\ %s
	autocmd FileType man                       setlocal commentstring=.\"%s
	autocmd FileType vim,st,vimperator         setlocal commentstring=\"%s

	autocmd FileType python
		\ setlocal commentstring=#%s | let b:commentblockstring = '"""%s"""'

	autocmd FileType lisp,scheme
		\ setlocal commentstring=;%s | let b:commentblockstring = '#|%s|#'

	autocmd FileType lua
		\ setlocal commentstring=--%s | let b:commentblockstring = '--[[%s]]'

	autocmd FileType ahk
		\ setlocal commentstring=;%s | let b:commentblockstring = '/*%s*/'

	autocmd FileType applescript
		\ setlocal commentstring=--%s | let b:commentblockstring = '(*%s*)'

	autocmd FileType aspvbs
		\ setlocal commentstring=''%s | let b:commentblockstring = '<!--%s-->'

	autocmd FileType plsql,sql,sqlforms,sqlj
		\ setlocal commentstring=--\ %s | let b:commentblockstring = '/*%s*/'

	autocmd FileType django,genshi,htmldjango,twig
		\ setlocal commentstring=<!--\ %s\ --> | let b:commentblockstring = '{#%s#}'

	autocmd FileType inform,rgb,sqr,uil,xdefaults,xpm2
		\ setlocal commentstring=!%s

	autocmd FileType caos,cterm,form,foxpro,gams,sicad,snobol4
		\ setlocal commentstring=*%s

	autocmd FileType docbk,eruby,genshi,html,html.handlebars,html.mustache
		\ setlocal commentstring=<!--\ %s\ -->

	autocmd FileType jgraph,lotos,mma,moduala,modula2,modula3,ocaml,omlet,pascal,
		\sml
		\ setlocal commentstring=(*%s*)

	autocmd FileType asciidoc,asy,calibre,fsharp,jade,openroad,ox,pfmain,scilab,
		\specman,spectre,xkb
		\ setlocal commentstring=//%s

	autocmd FileType ada,ahdl,asn,cabal,catalog,csp,eiffel,gdmo,haskell,lace,mib,
		\occam,sa,sather,stp,vhdl
		\ setlocal commentstring=--%s

	autocmd FileType amiga,armasm,asm68k,asm,asterisk,autohotkey,autoit,bindzone,
		\clojure,def,dns,dosini,dracula,dsl,gitconfig,idlang,iss,jess,kix,llvm,masm,
		\monk,nasm,ncf,newlisp,omnimark,pic,povini,rebol,registry,samba,scsh,skill,
		\smith,tags,tasm,tf,winbatch,wvdial,z8a
		\ setlocal commentstring=;%s

	autocmd FileType abc,bbx,bib,bst,context,erlang,ist,lilypond,lprolog,lytex,
		\map,matlab,pdf,postscr,ppd,prolog,simula,slang,slrnrc,texmf,virata
		\ setlocal commentstring=%%s

	autocmd FileType acedb,actionscript,c,cg,ch,clean,clipper,cpp,cuda,cs,d,dot,
		\dylan,fx,go,groovy,h,haxe,hercules,idl,ishd,java,javacc,javascript,kscript,
		\mel,named,objc,objcpp,objj,pccts,php,pike,pilrc,plm,pov,processing,rc,sass,
		\scala,scss,slice,supercollider,systemverilog,tads,tsalt,uc,vala,vera,
		\verilog,verilog_systemverilog
		\ setlocal commentstring=//%s | let b:commentblockstring = '/*%s*/'

	autocmd FileType aap,ansible,apache,apachestyle,awk,bc,cfg,cl,cmake,coffee,
		\conkyrc,crontab,cucumber,dakota,debcontrol,debsources,desktop,dhcpd,diff,
		\ebuild,ecd,eclass,elmfilt,expect,exports,fancy,fgl,fstab,fvwm,gdb,gentoo,
		\gitcommit,gitrebase,gnuplot,gtkrc,hb,hog,hxml,ia64,icon,inittab,
		\jproperties,ldif,lilo,lout,lss,lynx,maple,mirah,make,mush,nginx,nimrod,
		\nsis,ntp,ooc,ora,pcap,perl,pine,po,ps1,psf,ptcap,puppet,radiance,
		\ratpoison,r,remind,resolv,rib,robots,rspec,ruby,scons,sed,sh,sm,snnsnet,
		\snnspat,snnsres,spec,ssh,squid,tcl,tidy,tli,tmux,tsscl,vgrindefs,vrml,
		\wget,wml,xmath
		\ setlocal commentstring=#%s

augroup END

" }}}
" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}

" vim: set ts=2 sw=2 tw=80 noet :
