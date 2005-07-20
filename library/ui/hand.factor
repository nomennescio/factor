! Copyright (C) 2005 Slava Pestov.
! See http://factor.sf.net/license.txt for BSD license.
IN: gadgets
USING: alien generic io kernel lists math matrices namespaces
prettyprint sdl sequences vectors ;

: (pick-up) ( point gadget -- gadget )
    gadget-children reverse-slice [
        dup gadget-visible? [ inside? ] [ 2drop f ] ifte
    ] find-with nip ;

: pick-up ( point gadget -- gadget )
    #! The logic is thus. If the point is definately outside the
    #! box, return f. Otherwise, see if the point is contained
    #! in any subgadget. If not, see if it is contained in the
    #! box delegate.
    dup gadget-visible? >r 2dup inside? r> drop [
        [ rectangle-loc v- ] keep 2dup
        (pick-up) [ pick-up ] [ nip ] ?ifte
    ] [
        2drop f
    ] ifte ;

! The hand is a special gadget that holds mouse position and
! mouse button click state. The hand's parent is the world, but
! it is special in that the world does not list it as part of
! its contents. Some comments on the slots:
! - hand-gadget is the gadget under the mouse position
! - hand-clicked is the most recently clicked gadget
! - hand-focus is the gadget holding keyboard focus
TUPLE: hand click-loc click-rel clicked buttons gadget focus ;

C: hand ( world -- hand )
    <gadget> over set-delegate
    [ set-gadget-parent ] 2keep
    [ set-hand-gadget ] keep ;

: hand world get world-hand ;

: button/ ( n hand -- )
    dup hand-gadget over set-hand-clicked
    dup screen-loc over set-hand-click-loc
    dup hand-gadget over relative over set-hand-click-rel
    [ hand-buttons unique ] keep set-hand-buttons ;

: button\ ( n hand -- )
    [ hand-buttons remove ] keep set-hand-buttons ;

: drag-gesture ( hand gadget gesture -- )
    #! Send a gesture like [ drag 2 ].
    rot hand-buttons car add swap handle-gesture drop ;

: fire-motion ( hand -- )
    #! Fire a motion gesture to the gadget underneath the hand,
    #! and if a mouse button is down, fire a drag gesture to the
    #! gadget that was clicked.
    [ motion ] over hand-gadget handle-gesture drop
    dup hand-buttons
    [ dup hand-clicked [ drag ] drag-gesture ] [ drop ] ifte ;

: drop-prefix ( l1 l2 -- l1 l2 )
    2dup and [ 2dup 2car eq? [ 2cdr drop-prefix ] when ] when ;

: each-gesture ( gesture seq -- )
    [ handle-gesture* drop ] each-with ;

: hand-gestures ( hand new old -- )
    drop-prefix
    reverse [ mouse-leave ] swap each-gesture
    swap fire-motion
    [ mouse-enter ] swap each-gesture ;

: move-hand ( loc hand -- )
    dup hand-gadget parents-down >r
    2dup set-rectangle-loc
    [ >r world get pick-up r> set-hand-gadget ] keep
    dup hand-gadget parents-down r> hand-gestures ;

: update-hand ( hand -- )
    #! Called when a gadget is removed or added.
    dup rectangle-loc swap move-hand ;

: focus-gestures ( new old -- )
    drop-prefix
    reverse [ lose-focus ] swap each-gesture
    [ gain-focus ] swap each-gesture ;

: request-focus ( gadget -- )
    focusable-child
    hand dup hand-focus parents-down >r
    dupd set-hand-focus parents-down r> focus-gestures ;
