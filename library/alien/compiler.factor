! Copyright (C) 2006 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
IN: alien
USING: arrays compiler-backend generic hashtables kernel
kernel-internals math namespaces sequences words ;

: parameter-size c-size cell align ;

: parameter-sizes ( types -- offsets )
    #! Compute stack frame locations.
    0 [ parameter-size + ] accumulate ;

: stack-space ( parameters -- n )
    0 [ parameter-size + ] reduce ;

: reg-class-full? ( class -- ? )
    dup class get swap fastcall-regs length >= ;

: spill-param ( reg-class -- n reg-class )
    reg-size stack-params dup get -rot +@ T{ stack-params } ;

: fastcall-param ( reg-class -- n reg-class )
    [ dup class get swap inc-reg-class ] keep ;

: alloc-parameter ( parameter -- n reg reg-class )
    #! Allocate a register and stack frame location.
    #! n is a stack location, and the value of the class
    #! variable is a register number.
    c-type "reg-class" swap hash dup reg-class-full?
    [ spill-param ] [ fastcall-param ] if ;

: flatten-value-types ( params -- params )
    #! Convert value type structs to consecutive void*s.
    [
        dup c-struct?
        [ c-size cell / "void*" <array> ] [ 1array ] if
    ] map concat ;

: reverse-each-parameter ( parameters quot -- )
    >r [ parameter-sizes ] keep
    [ reverse-slice ] 2apply r> 2each ; inline

: map-parameters ( parameters quot -- seq )
    >r [ parameter-sizes ] keep r> 2map ; inline

: move-parameters ( params vop -- seq )
    #! Moves values from C stack to registers (if vop is
    #! %stack>freg) and registers to C stack (if vop is
    #! %freg>stack).
    swap [
        flatten-value-types
        0 { int-regs float-regs stack-params } [ set ] each-with
        [ pick >r alloc-parameter r> execute ] map-parameters
        nip
    ] with-scope ; inline

: box-parameter ( stack# type -- node )
    c-type [ "reg-class" get "boxer" get call ] bind ;

: if-void ( type true false -- | false: type -- )
    pick "void" = [ drop nip call ] [ nip call ] if ; inline

: compile-gc ; ! "simple_gc" f %alien-invoke , ;