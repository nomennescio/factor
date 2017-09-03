! Copyright (C) 2017 Doug Coleman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays assocs io io.encodings.utf8 io.files
io.streams.string kernel modern modern.paths modern.slices
multiline namespaces prettyprint sequences sequences.extras
splitting strings continuations fry ;
IN: modern.out

: trim-before-newline ( seq -- seq' )
    dup [ char: \s = not ] find
    { char: \r char: \n } member?
    [ tail-slice ] [ drop ] if ;

: write-whitespace ( last obj -- )
    swap
    [ swap slice-between ] [ slice-before ] if*
    trim-before-newline io:write ;

GENERIC: write-literal* ( last obj -- last' )
M: slice write-literal* [ write-whitespace ] [ write ] [ ] tri ;
M: array write-literal* [ write-literal* ] each ;
M: string write-literal* [ write-whitespace ] [ write ] [ ] tri ; ! for refactoring



DEFER: map-literals
: (map-literals) ( obj quot: ( obj -- obj' ) -- seq )
    over [ array? ] any? [
        [ call drop ] [ map-literals ] 2bi
    ] [
        over array? [ map-literals ] [ call ] if
    ] if ; inline recursive

: map-literals ( obj quot: ( obj -- obj' ) -- seq )
    '[ _ (map-literals) ] map ; inline recursive



! Start with no slice as ``last``
: write-literal ( obj -- ) f swap write-literal* drop ;

: write-modern-string ( seq -- string )
    [ write-literal ] with-string-writer ; inline

: write-modern-path ( seq path -- )
    utf8 [ write-literal nl ] with-file-writer ; inline

: write-modern-vocab ( seq vocab -- )
    modern-source-path write-modern-path ; inline

: rewrite-path ( path quot: ( obj -- obj' ) -- )
    ! dup print
    '[ [ path>literals _ map-literals ] [ ] bi write-modern-path ]
    [ drop . ] recover ; inline recursive

: rewrite-string ( string quot: ( obj -- obj' ) -- )
    ! dup print
    [ string>literals ] dip map-literals write-modern-string ; inline recursive

: rewrite-paths ( seq quot: ( obj -- obj' ) -- ) '[ _ rewrite-path ] each ; inline recursive

: rewrite-vocab ( vocab quot: ( obj -- obj' ) -- )
    [ [ vocab>literals ] dip map-literals ] 2keep drop write-modern-vocab ; inline recursive

: rewrite-string-exact ( string -- string' )
    string>literals write-modern-string ;

![[
: rewrite-path-exact ( path -- )
    [ path>literals ] [ ] bi write-modern-path ;

: rewrite-vocab-exact ( name -- )
    modern-source-path rewrite-path-exact ;

: rewrite-paths ( paths -- )
    [ rewrite-path-exact ] each ;
]]

: strings-core-to-file ( -- )
    core-bootstrap-vocabs
    [ ".private" ?tail drop modern-source-path utf8 file-contents ] map-zip
    [ "[========[" dup matching-delimiter-string surround ] assoc-map
    [
        first2 [ "VOCAB: " prepend ] dip " " glue
    ] map
    [ "    " prepend ] map "\n\n" join
    "<VOCAB-ROOT: factorcode-core \"https://factorcode.org/git/factor.git\" \"core/\"\n"
    "\n;VOCAB-ROOT>" surround "resource:core-strings.factor" utf8 set-file-contents ;

: parsed-core-to-file ( -- )
    core-bootstrap-vocabs
    [ vocab>literals ] map-zip
    [
        first2 [ "<VOCAB: " prepend ] dip
        >strings
        ! [ 3 head ] [ 3 tail* ] bi [ >strings ] bi@ { "..." } glue
        ";VOCAB>" 3array
    ] map 1array

    { "<VOCAB-ROOT:" "factorcode-core" "https://factorcode.org/git/factor.git" "core/" }
    { ";VOCAB-ROOT>" } surround "resource:core-parsed.factor" utf8 [ ... ] with-file-writer ;
