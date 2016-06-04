USING: accessors alien.c-types alien.syntax classes
classes.struct compiler.units eval io.encodings.ascii kernel
math.constants tools.test ;
FROM: alien.c-types => short ;
in: alien.c-types.tests

CONSTANT: xyz 123

{ 492 } [ { int xyz } heap-size ] unit-test

UNION-STRUCT: foo
    { a int }
    { b int } ;

{ t } [ pointer: void lookup-c-type void* lookup-c-type = ] unit-test
{ t } [ pointer: int  lookup-c-type void* lookup-c-type = ] unit-test
{ t } [ pointer: int* lookup-c-type void* lookup-c-type = ] unit-test
{ f } [ pointer: foo  lookup-c-type void* lookup-c-type = ] unit-test
{ t } [ pointer: foo* lookup-c-type void* lookup-c-type = ] unit-test

{ t } [ c-string lookup-c-type c-string lookup-c-type = ] unit-test

{ t } [ foo heap-size int heap-size = ] unit-test

TYPEDEF: int MyInt

{ t } [ int   lookup-c-type          MyInt lookup-c-type = ] unit-test
{ t } [ void* lookup-c-type pointer: MyInt lookup-c-type = ] unit-test

{ 32 } [ { int 8 } heap-size ] unit-test

{ } [ pointer: { int 8 } heap-size pointer: void heap-size assert= ] unit-test

TYPEDEF: char MyChar

{ t } [ pointer: void lookup-c-type pointer: MyChar lookup-c-type = ] unit-test

TYPEDEF: { c-string ascii } MyFunkyString

{ { c-string ascii } } [ MyFunkyString lookup-c-type ] unit-test

TYPEDEF: c-string MyString

{ t } [ c-string lookup-c-type MyString          lookup-c-type = ] unit-test
{ t } [ void* lookup-c-type pointer: MyString lookup-c-type = ] unit-test

TYPEDEF: int* MyIntArray

{ t } [ void* lookup-c-type MyIntArray lookup-c-type = ] unit-test

{ 0 } [ -10 uchar c-type-clamp ] unit-test
{ 12 } [ 12 uchar c-type-clamp ] unit-test
{ -10 } [ -10 char c-type-clamp ] unit-test
{ 127 } [ 230 char c-type-clamp ] unit-test
{ t } [ pi dup float c-type-clamp = ] unit-test

C-TYPE: opaque

{ t } [ void* lookup-c-type pointer: opaque lookup-c-type = ] unit-test
[ opaque lookup-c-type ] [ no-c-type? ] must-fail-with

[ "
    USING: alien.syntax ;
    in: alien.c-types.tests
    FUNCTION: opaque return_opaque ( ) ;
" eval( -- ) ] [ no-c-type? ] must-fail-with

C-TYPE: forward
STRUCT: backward { x forward* } ;
STRUCT: forward { x backward* } ;

{ t } [ forward lookup-c-type struct-c-type? ] unit-test
{ t } [ backward lookup-c-type struct-c-type? ] unit-test

DEFER: struct-redefined

{ f }
[

    "
    USING: alien.c-types classes.struct ;
    in: alien.c-types.tests

    STRUCT: struct-redefined { x int } ;
    " eval( -- )

    "
    USING: alien.syntax ;
    in: alien.c-types.tests

    C-TYPE: struct-redefined
    " eval( -- )

    \ struct-redefined class?
] unit-test

[
    "in: alien.c-types.tests
    use: alien.syntax
    use: alien.c-types
    TYPEDEF: int type-redefinition-test
    TYPEDEF: int type-redefinition-test" eval( -- )
]
[ error>> error>> redefine-error? ]
must-fail-with

[
    "in: alien.c-types.tests
    use: alien.syntax
    use: alien.c-types
    CALLBACK: void cb987 ( ) ;
    CALLBACK: void cb987 ( ) ;" eval( -- )
]
[ error>> error>> redefine-error? ]
must-fail-with

[
    "in: alien.c-types.tests
    use: alien.syntax
    use: alien.c-types
    FUNCTION: void func987 ( ) ;
    FUNCTION: void func987 ( ) ;" eval( -- )
]
[ error>> error>> redefine-error? ]
must-fail-with

! generic -> callback
"in: alien.c-types.tests
use: alien.syntax
use: alien.c-types
GENERIC: foo-func ( x -- ) ;
" eval( -- )

"in: alien.c-types.tests
use: alien.syntax
use: alien.c-types
CALLBACK: void foo-func ( ) ;
" eval( -- )

! generic -> typedef
"in: alien.c-types.tests
use: alien.syntax
use: alien.c-types
GENERIC: foo-func ( x -- ) ;
" eval( -- )

"in: alien.c-types.tests
use: alien.syntax
use: alien.c-types
TYPEDEF: void* foo-func
" eval( -- )
