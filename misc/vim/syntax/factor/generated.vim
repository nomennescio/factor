" Vim syntax file
" Language: Factor
" Maintainer: Alex Chapman <chapman.alex@gmail.com>
" Last Change: 2022 Aug 06
" Minimum Version: 600
" To regenerate: USE: editors.vim.generate-syntax generate-vim-syntax

if exists('b:factorsyn_no_generated')
  finish
endif

command -nargs=+ -bar HiLink hi def link <args>
function s:syn_keyword_factor_word(group, ...)
  execute 'HiLink' a:group 'factorWord'
  execute 'syn' 'cluster' 'factorWord' 'add=' . a:group
endfunction
command -nargs=+ -bar SynKeywordFactorWord
      \ call s:syn_keyword_factor_word(<f-args>)

SynKeywordFactorWord factorWord_alien | syn keyword factorWord_alien contained <alien> <bad-alien> <callback> <displaced-alien> >c-ptr abi abi? alien alien-address alien-assembly alien-callback alien-indirect alien-invoke alien? binary-object byte-length c-ptr c-ptr? callee-cleanup? callsite-not-compiled callsite-not-compiled? cdecl cdecl? dll dll? element-size expired? fastcall fastcall? free-callback initialize-alien mingw mingw? pinned-alien pinned-alien? pinned-c-ptr pinned-c-ptr? stdcall stdcall? thiscall thiscall? unregister-and-free-callback with-callback
SynKeywordFactorWord factorWord_arrays | syn keyword factorWord_arrays contained 1array 2array 3array 4array <array> >array array array? pair pair? resize-array
SynKeywordFactorWord factorWord_assocs | syn keyword factorWord_assocs contained 2cache <enumerated> >alist ?at ?change-at ?delete-at ?of ?value-at assoc assoc-all? assoc-any? assoc-clone-like assoc-diff assoc-diff! assoc-differ assoc-each assoc-empty? assoc-filter assoc-filter! assoc-filter-as assoc-find assoc-hashcode assoc-intersect assoc-intersect-all assoc-like assoc-map assoc-map-as assoc-partition assoc-reject assoc-reject! assoc-reject-as assoc-size assoc-stack assoc-subset? assoc-union assoc-union! assoc-union-all assoc-union-as assoc= assoc>map assoc? at at* at+ cache change-at clear-assoc collect-by delete-at delete-at* enumerated enumerated? extract-keys harvest-keys harvest-values inc-at key? keys map>alist map>assoc maybe-set-at new-assoc of push-at rename-at set-at sift-keys sift-values substitute unzip value-at value-at* value? values zip zip-as zip-index zip-index-as zip-with zip-with-as
SynKeywordFactorWord factorWord_byte__arrays | syn keyword factorWord_byte__arrays contained (byte-array) 1byte-array 2byte-array 3byte-array 4byte-array <byte-array> >byte-array byte-array byte-array? byte-sequence byte-sequence? resize-byte-array
SynKeywordFactorWord factorWord_classes | syn keyword factorWord_classes contained all-contained-classes bad-inheritance bad-inheritance? check-instance class class-members class-of class-participants class-usage class-usages class-uses class? classes classoid classoid? contained-classes create-predicate-word define-predicate defining-class defining-class? forget-class implementors instance? not-an-instance not-an-instance? predicate predicate-def predicate-word predicate? subclass-of? superclass-of superclass-of? superclasses-of
SynKeywordFactorWord factorWord_classes_maybe | syn keyword factorWord_classes_maybe contained <maybe> maybe maybe-class-or maybe?
SynKeywordFactorWord factorWord_combinators | syn keyword factorWord_combinators contained 2cleave 2cleave>quot 3cleave 3cleave>quot 4cleave 4cleave>quot alist>quot call-effect case case-find case>quot cleave cleave>quot cond cond>quot deep-spread>quot execute-effect linear-case-quot no-case no-case? no-cond no-cond? shallow-spread>quot spread to-fixed-point wrong-values wrong-values?
SynKeywordFactorWord factorWord_continuations | syn keyword factorWord_continuations contained <condition> <continuation> <restart> attempt-all attempt-all-error attempt-all-error? callback-error-hook callcc0 callcc1 cleanup compute-restarts condition condition? continuation continuation? continue continue-restart continue-with current-continuation error error-continuation error-in-thread error-thread finally ifcc ignore-error ignore-error/f ignore-errors in-callback? no-op-restart no-op-restart? original-error recover restart restart? restarts rethrow rethrow-restarts return return-continuation thread-error-hook throw-continue throw-restarts with-datastack with-return
SynKeywordFactorWord factorWord_definitions | syn keyword factorWord_definitions contained add-to-unit changed-conditionally changed-definition changed-definitions changed-effects definer definition definition-mixin definition-mixin? forget forget* forget-all forgotten-definition forgotten-definitions maybe-changed new-word new-words no-compilation-unit no-compilation-unit? outdated-generics set-where where
SynKeywordFactorWord factorWord_destructors | syn keyword factorWord_destructors contained &dispose already-disposed already-disposed? already-unregistered already-unregistered? check-disposed debug-leaks? disposable disposable? disposables dispose dispose* dispose-each dispose-to new-disposable unless-disposed with-destructors with-disposal \|dispose
SynKeywordFactorWord factorWord_generic | syn keyword factorWord_generic contained (call-next-method) <default-method> <method> ?lookup-method check-combination-effect check-method check-method-error check-method-error? create-method default-method default-method? define-default-method define-generic effective-method generic generic? implementor-classes lookup-method make-default-method make-generic method method-classes method-for-class method-lookup-failed method-lookup-failed? method-word-name method-word-props method? nearest-class next-method next-method-class next-method-quot next-method-quot* no-next-method no-next-method? order perform-combination remake-generic remake-generics reveal-method update-generic with-implementors with-methods
SynKeywordFactorWord factorWord_growable | syn keyword factorWord_growable contained capacity contract ensure expand growable growable? new-size
SynKeywordFactorWord factorWord_io | syn keyword factorWord_io contained (each-stream-block) (each-stream-block-slice) (stream-contents-by-block) (stream-contents-by-element) (stream-contents-by-length) (stream-contents-by-length-or-block) +byte+ +character+ bad-seek-type bad-seek-type? bl each-block each-block-size each-block-slice each-line each-stream-block each-stream-block-slice each-stream-line error-stream flush input-stream input-stream? invalid-read-buffer invalid-read-buffer? nl output-stream output-stream? print read read-contents read-into read-lines read-partial read-partial-into read-until read1 readln seek-absolute seek-absolute? seek-end seek-end? seek-input seek-output seek-relative seek-relative? stream-bl stream-contents stream-contents* stream-copy stream-copy* stream-element-type stream-flush stream-length stream-lines stream-nl stream-print stream-read stream-read-into stream-read-partial stream-read-partial-into stream-read-partial-unsafe stream-read-unsafe stream-read-until stream-read1 stream-readln stream-seek stream-seekable? stream-tell stream-write stream-write1 tell-input tell-output with-error-stream with-error-stream* with-error>output with-input-output+error-streams with-input-output+error-streams* with-input-stream with-input-stream* with-output+error-stream with-output+error-stream* with-output-stream with-output-stream* with-output>error with-streams with-streams* write write1
SynKeywordFactorWord factorWord_io_encodings | syn keyword factorWord_io_encodings contained (decode-until) <decoder> <encoder> decode-char decode-error decode-error? decode-input decode-until decoder decoder? encode-char encode-error encode-error? encode-output encode-string encoder encoder? guess-decoded-length guess-encoded-length re-decode re-encode replacement-char with-decoded-input with-encoded-output
SynKeywordFactorWord factorWord_io_encodings_binary | syn keyword factorWord_io_encodings_binary contained binary binary?
SynKeywordFactorWord factorWord_io_encodings_utf8 | syn keyword factorWord_io_encodings_utf8 contained >utf8-index code-point-length code-point-offsets utf8 utf8-index> utf8?
SynKeywordFactorWord factorWord_io_files | syn keyword factorWord_io_files contained (file-appender) (file-reader) (file-writer) +input+ +output+ +retry+ <file-appender> <file-reader> <file-writer> change-file-contents change-file-lines drain file-contents file-exists? file-lines file-reader file-reader? file-writer file-writer? init-resource-path refill set-file-contents set-file-lines wait-for-fd with-file-appender with-file-reader with-file-writer
SynKeywordFactorWord factorWord_kernel | syn keyword factorWord_kernel contained (clone) -roll -rot -rotd 2bi 2bi* 2bi@ 2curry 2dip 2drop 2dup 2keep 2keepd 2nip 2nipd 2over 2tri 2tri* 2tri@ 2with 3bi 3curry 3dip 3drop 3dup 3keep 3nip 3nipd 3tri 4dip 4drop 4dup 4keep 4nip 5drop 5nip <wrapper> = >boolean ? ?if and assert assert= assert? bi bi* bi-curry bi-curry* bi-curry@ bi@ boa boolean boolean? both? build call callstack callstack>array callstack? clear clone compose composed composed? curried curried? curry die dip do drop dup dupd either? eq? equal? execute get-callstack get-datastack get-retainstack hashcode hashcode* identity-hashcode identity-tuple identity-tuple? if if* keep keepd keepdd loop most negate new nip nipd not null object or over overd pick pickd prepose reach recursive-hashcode roll rot rotd same? spin swap swapd throw tri tri* tri-curry tri-curry* tri-curry@ tri@ tuck tuple tuple? unless unless* until when when* while while* with withd wrapper wrapper? xor
SynKeywordFactorWord factorWord_layouts | syn keyword factorWord_layouts contained (first-bignum) (fixnum-bits) (max-array-capacity) 32-bit? 64-bit? bootstrap-cell bootstrap-cell-bits bootstrap-cells bootstrap-first-bignum bootstrap-fixnum-bits bootstrap-max-array-capacity bootstrap-most-negative-fixnum bootstrap-most-positive-fixnum cell cell-bits cells data-alignment first-bignum fixnum-bits hashcode-shift header-bits immediate immediate? leaf-stack-frame-size max-array-capacity mega-cache-size most-negative-fixnum most-positive-fixnum num-types tag-bits tag-fixnum tag-header tag-mask type-number type-numbers untag-fixnum
SynKeywordFactorWord factorWord_make | syn keyword factorWord_make contained % %% , ,+ ,, building make
SynKeywordFactorWord factorWord_math | syn keyword factorWord_math contained * + - / /f /i /mod 2/ 2^ < <= <fp-nan> > >= >bignum >fixnum >float >fraction >integer >rect ?1+ abs align all-integers-from? all-integers? bignum bignum? bit? bitand bitnot bitor bits>double bits>float bitxor complex complex? denominator double>bits each-integer each-integer-from even? find-integer find-integer-from find-last-integer fixnum fixnum? float float>bits float? fp-bitwise= fp-infinity? fp-nan-payload fp-nan? fp-qnan? fp-sign fp-snan? fp-special? gcd if-zero imaginary-part integer integer>fixnum integer>fixnum-strict integer? log2 log2-expects-positive log2-expects-positive? mod neg neg? next-float next-power-of-2 number number= number? numerator odd? power-of-2? prev-float ratio ratio? rational rational? real real-part real? recip rect> rem sgn shift simple-gcd sq times u< u<= u> u>= unless-zero unordered? until-zero when-zero zero?
SynKeywordFactorWord factorWord_math_order | syn keyword factorWord_math_order contained +eq+ +gt+ +lt+ <=> >=< [-] after=? after? before=? before? between? clamp compare invert-comparison max min
SynKeywordFactorWord factorWord_memory | syn keyword factorWord_memory contained all-instances compact-gc gc instances minor-gc save save-image save-image-and-exit saving-path size
SynKeywordFactorWord factorWord_namespaces | syn keyword factorWord_namespaces contained +@ change change-global counter dec get get-global get-namestack global inc init-namestack initialize namespace off on set set-global set-namestack toggle with-global with-scope with-variable with-variables
SynKeywordFactorWord factorWord_sequences | syn keyword factorWord_sequences contained 1sequence 1surround 1surround-as 2all? 2any? 2each 2each-from 2map 2map-as 2map-reduce 2reduce 2selector 2sequence 3append 3append-as 3each 3map 3map-as 3sequence 4sequence <iota> <repetition> <reversed> <slice> >slice< ?first ?last ?nth ?second ?set-nth accumulate accumulate! accumulate* accumulate*! accumulate*-as accumulate-as all? any? append append! append-as assert-sequence assert-sequence= assert-sequence? binary-reduce bounds-check bounds-check? bounds-error bounds-error? but-last but-last-slice cartesian-each cartesian-find cartesian-map cartesian-product cartesian-product-as change-nth check-slice clone-like collapse-slice collector collector-as collector-for collector-for-as concat concat-as copy count cut cut* cut-slice cut-slice* delete-all delete-slice drop-prefix each each-from each-index empty? exchange filter filter! filter-as find find-from find-index find-index-from find-last find-last-from first first2 first3 first4 flip follow fourth from-tail glue glue-as halves harvest head head* head-slice head-slice* head-to-index head? if-empty immutable immutable-sequence immutable-sequence? immutable? index index-from index-of-last index-or-length index-to-tail indices infimum infimum-by insert-nth interleave iota iota? join join-as last last-index last-index-from length lengthen like longer longer? longest map map! map-as map-find map-find-last map-index map-index-as map-integers map-integers-as map-reduce map-sum max-length member-eq? member? midpoint@ min-length mismatch move new-like new-resizable new-sequence non-negative-integer-expected non-negative-integer-expected? none? nth nths pad-head pad-tail partition pop pop* prefix prepend prepend-as produce produce-as product push push-all push-either push-if reduce reduce-index reject reject! reject-as remove remove! remove-eq remove-eq! remove-nth remove-nth! repetition repetition? replace-slice replicate replicate-as rest rest-slice reverse reverse! reversed reversed? second selector selector-as sequence sequence-hashcode sequence= sequence? set-first set-fourth set-last set-length set-nth set-second set-third shorten shorter shorter? shortest sift slice slice-error slice-error? slice? snip snip-slice subseq subseq-as subseq-index subseq-index-from subseq-of? subseq-start subseq-start-from subseq-starts-at? subseq? suffix suffix! sum sum-lengths supremum supremum-by surround surround-as tail tail* tail-slice tail-slice* tail? third trim trim-head trim-head-slice trim-slice trim-tail trim-tail-slice unclip unclip-last unclip-last-slice unclip-slice unless-empty virtual-exemplar virtual-sequence virtual-sequence? virtual@ when-empty
SynKeywordFactorWord factorWord_sets | syn keyword factorWord_sets contained ?adjoin ?delete adjoin adjoin-all adjoin-at all-unique? cardinality clear-set delete diff diff! duplicates fast-set gather in? intersect intersect! intersect-all intersects? members null? set set-like set= set? subset? union union! union-all within without
SynKeywordFactorWord factorWord_sorting | syn keyword factorWord_sorting contained compare-with inv-sort-with natural-sort sort sort-keys sort-pair sort-values sort-with
SynKeywordFactorWord factorWord_splitting | syn keyword factorWord_splitting contained ?head ?head-slice ?snip ?snip-slice ?tail ?tail-slice join-lines join-lines-as join-words join-words-as replace split split-indices split-lines split-slice split-subseq split-when split-when-slice split-words split1 split1-last split1-last-slice split1-slice split1-when split1-when-slice string-lines subseq-range
SynKeywordFactorWord factorWord_strings | syn keyword factorWord_strings contained 1string <string> >string resize-string string string?
SynKeywordFactorWord factorWord_strings_parser | syn keyword factorWord_strings_parser contained bad-escape bad-escape? escape name>char-hook parse-string unescape-string
SynKeywordFactorWord factorWord_syntax | syn keyword factorWord_syntax contained " 'HS{ 'H{ '[ '{ ( : :: :> ; << <<<<<< <<<<<<< <PRIVATE ====== ======= >> >>>>>> >>>>>>> @ ALIAS: B B: BUILTIN: BV{ B{ C: CHAR: CONSTANT: CS{ C{ DEFER: ERROR: EXCLUDE: FORGET: FROM: GENERIC#: GENERIC: HOOK: HS{ H{ IDENTITY-MEMO: IDENTITY-MEMO:: IH{ IN: INITIALIZE: INSTANCE: INTERSECTION: M: M:: MACRO: MACRO:: MAIN: MATH: MEMO: MEMO:: MIXIN: M\ NAN: P" POSTPONE: PREDICATE: PRIMITIVE: PRIVATE> QUALIFIED-WITH: QUALIFIED: RENAME: REUSE: SBUF" SHUTDOWN-HOOK: SINGLETON: SINGLETONS: SLOT: STARTUP-HOOK: SYMBOL: SYMBOLS: SYNTAX: TUPLE: T{ UNION: UNUSE: USE: USING: V{ W{ [ [let [\| \ ] _ auto-use call( call-next-method delimiter deprecated execute( f final flushable foldable initial: inline intersection{ maybe{ not{ read-only recursive t t? union{ { }
SynKeywordFactorWord factorWord_vectors | syn keyword factorWord_vectors contained 1vector <vector> >vector ?push vector vector?

delcommand HiLink
delcommand SynKeywordFactorWord

let b:factor_syn_no_generated = 1

" vim:set ft=vim sw=2:
