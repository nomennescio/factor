USING: editors io.standard-paths kernel make math.parser
namespaces ;
in: editors.emeditor

singleton: emeditor
emeditor editor-class set-global

: emeditor-path ( -- path )
    \ emeditor-path get [
        { "EmEditor" } "emeditor.exe" find-in-applications
        [ "EmEditor.exe" ] unless*
    ] unless* ;

M: emeditor editor-command ( file line -- command )
    [
        emeditor-path , "/l" , number>string , ,
    ] { } make ;
