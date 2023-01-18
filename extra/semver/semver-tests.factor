! Copyright (C) 2020 Doug Coleman.
! See http://factorcode.org/license.txt for BSD license.
USING: assocs kernel math.order semver sequences
sequences.extras tools.test ;
IN: semver.tests

CONSTANT: semver-ranges {
    { "1.0.0 - 2.0.0" ">=1.0.0 <=2.0.0" }
    { "1.0.0 - 2.0.0" ">=1.0.0-0 <2.0.1-0" }
    { "1 - 2" ">=1.0.0 <3.0.0-0" }
    { "1 - 2" ">=1.0.0-0 <3.0.0-0" }
    { "1.0 - 2.0" ">=1.0.0 <2.1.0-0" }
    { "1.0 - 2.0" ">=1.0.0-0 <2.1.0-0" }
    { "1.0.0" "1.0.0" }
    { ">=*" "*" }
    ! { "" "*" }
    { "*" "*" }
    { "*" "*" }
    { ">=1.0.0" ">=1.0.0" }
    { ">1.0.0" ">1.0.0" }
    { "<=2.0.0" "<=2.0.0" }
    { "1" ">=1.0.0 <2.0.0-0" }
    { "<=2.0.0" "<=2.0.0" }
    { "<=2.0.0" "<=2.0.0" }
    { "<2.0.0" "<2.0.0" }
    { "<2.0.0" "<2.0.0" }
    { ">= 1.0.0" ">=1.0.0" }
    { ">=  1.0.0" ">=1.0.0" }
    { ">=   1.0.0" ">=1.0.0" }
    { "> 1.0.0" ">1.0.0" }
    { ">  1.0.0" ">1.0.0" }
    { "<=   2.0.0" "<=2.0.0" }
    { "<= 2.0.0" "<=2.0.0" }
    { "<=  2.0.0" "<=2.0.0" }
    { "<    2.0.0" "<2.0.0" }
    { "<\t2.0.0" "<2.0.0" }
    { ">=0.1.97" ">=0.1.97" }
    { ">=0.1.97" ">=0.1.97" }
    { "0.1.20 || 1.2.4" "0.1.20||1.2.4" }
    { ">=0.2.3 || <0.0.1" ">=0.2.3||<0.0.1" }
    { ">=0.2.3 || <0.0.1" ">=0.2.3||<0.0.1" }
    { ">=0.2.3 || <0.0.1" ">=0.2.3||<0.0.1" }
    { "||" "*" }
    { "2.x.x" ">=2.0.0 <3.0.0-0" }
    { "1.2.x" ">=1.2.0 <1.3.0-0" }
    { "1.2.x || 2.x" ">=1.2.0 <1.3.0-0||>=2.0.0 <3.0.0-0" }
    { "1.2.x || 2.x" ">=1.2.0 <1.3.0-0||>=2.0.0 <3.0.0-0" }
    { "x" "*" }
    { "2.*.*" ">=2.0.0 <3.0.0-0" }
    { "1.2.*" ">=1.2.0 <1.3.0-0" }
    { "1.2.* || 2.*" ">=1.2.0 <1.3.0-0||>=2.0.0 <3.0.0-0" }
    { "*" "*" }
    { "2" ">=2.0.0 <3.0.0-0" }
    { "2.3" ">=2.3.0 <2.4.0-0" }
    { "~2.4" ">=2.4.0 <2.5.0-0" }
    { "~2.4" ">=2.4.0 <2.5.0-0" }
    { "~>3.2.1" ">=3.2.1 <3.3.0-0" }
    { "~1" ">=1.0.0 <2.0.0-0" }
    { "~>1" ">=1.0.0 <2.0.0-0" }
    { "~> 1" ">=1.0.0 <2.0.0-0" }
    { "~1.0" ">=1.0.0 <1.1.0-0" }
    { "~ 1.0" ">=1.0.0 <1.1.0-0" }
    { "^0" "<1.0.0-0" }
    { "^ 1" ">=1.0.0 <2.0.0-0" }
    { "^0.1" ">=0.1.0 <0.2.0-0" }
    { "^1.0" ">=1.0.0 <2.0.0-0" }
    { "^1.2" ">=1.2.0 <2.0.0-0" }
    { "^0.0.1" ">=0.0.1 <0.0.2-0" }
    { "^0.0.1-beta" ">=0.0.1-beta <0.0.2-0" }
    { "^0.1.2" ">=0.1.2 <0.2.0-0" }
    { "^1.2.3" ">=1.2.3 <2.0.0-0" }
    { "^1.2.3-beta.4" ">=1.2.3-beta.4 <2.0.0-0" }
    { "<1" "<1.0.0-0" }
    { "< 1" "<1.0.0-0" }
    { ">=1" ">=1.0.0" }
    { ">= 1" ">=1.0.0" }
    { "<1.2" "<1.2.0-0" }
    { "< 1.2" "<1.2.0-0" }
    { "1" ">=1.0.0 <2.0.0-0" }
    { ">01.02.03" ">1.2.3" }
    ! { ">01.02.03" null" }
    ! { "~1.2.3beta" ">=1.2.3-beta <1.3.0-0" }
    ! { "~1.2.3beta" null" }
    { "^ 1.2 ^ 1" ">=1.2.0 <2.0.0-0 >=1.0.0" }
    { "1.2 - 3.4.5" ">=1.2.0 <=3.4.5" }
    { "1.2.3 - 3.4" ">=1.2.3 <3.5.0-0" }
    { "1.2 - 3.4" ">=1.2.0 <3.5.0-0" }
    { ">1" ">=2.0.0" }
    { ">1.2" ">=1.3.0" }
    { ">X" "<0.0.0-0" }
    { "<X" "<0.0.0-0" }
    { "<x <* || >* 2.x" "<0.0.0-0" }
    { ">x 2.x || * || <x" "*" }
}


! first > second
CONSTANT: semver-gt-comparisons {
    { "0.0.0" "0.0.0-foo" }
    { "0.0.1" "0.0.0" }
    { "1.0.0" "0.9.9" }
    { "0.10.0" "0.9.0" }
    { "0.99.0" "0.10.0" }
    { "2.0.0" "1.2.3" }
    ! { "v0.0.0" "0.0.0-oo" }
    ! { "v0.0.1" "0.0.0" }
    ! { "v1.0.0" "0.9.9" }
    ! { "v0.10.0" "0.9.0" }
    ! { "v0.99.0" "0.10.0" }
    ! { "v2.0.0" "1.2.3" }
    ! { "0.0.0" "v0.0.0-fo" }
    ! { "0.0.1" "v0.0.0" }
    ! { "1.0.0" "v0.9.9" }
    ! { "0.10.0" "v0.9.0" }
    ! { "0.99.0" "v0.10.0" }
    ! { "2.0.0" "v1.2.3" }
    { "1.2.3" "1.2.3-asf" }
    { "1.2.3" "1.2.3-4" }
    { "1.2.3" "1.2.3-4-fo" }
    { "1.2.3-5-foo" "1.2.3-5" }
    { "1.2.3-5" "1.2.3-4" }
    { "1.2.3-5-foo" "1.2.3-5-Foo" }
    { "3.0.0" "2.7.2+asdf" }
    { "1.2.3-a.10" "1.2.3-a.5" }
    { "1.2.3-a.b" "1.2.3-a.5" }
    { "1.2.3-a.b" "1.2.3-a" }
    ! { "1.2.3-a.b.c.10.d.5" ".2.3-a.b.c.5.d.100" }
    { "1.2.3-r2" "1.2.3-r100" }
    { "1.2.3-r100" "1.2.3-R2" }
}

{ t } [
    semver-gt-comparisons
    [ first2 [ parse-semver ] bi@ <=> ] zip-with
    values [ +gt+ = ] all?
] unit-test

{ t } [
    semver-gt-comparisons
    [ first2 swap [ parse-semver ] bi@ <=> ] zip-with
    values [ +lt+ = ] all?
] unit-test

{ "1.2.4-dev.0" } [ "1.2.3" <semver> semver-inc-prepatch semver>string ] unit-test
{ "1.2.4" } [ "1.2.3" <semver> semver-inc-patch semver>string ] unit-test

{ "1.3.0-dev.0" } [ "1.2.3" <semver> semver-inc-preminor semver>string ] unit-test
{ "1.3.0" } [ "1.2.3" <semver> semver-inc-minor semver>string ] unit-test

{ "2.0.0-dev.0" } [ "1.2.3" <semver> semver-inc-premajor semver>string ] unit-test
{ "2.0.0-dev.1" } [ "1.2.3" <semver> semver-inc-premajor semver-inc-prerelease semver>string ] unit-test
{ "2.0.0" } [ "1.2.3" <semver> semver-inc-major semver>string ] unit-test

{ "1.2.3-erg.0" } [ "1.2.3" <semver> "erg" semver-inc-prerelease-id semver>string ] unit-test

{ T{ semver f 2 7 2 "pre" "build" } } [ "2.7.2-pre+build" parse-semver ] unit-test
{ T{ semver f 2 7 2 "pre" f } } [ "2.7.2-pre" parse-semver ] unit-test
{ T{ semver f 2 7 2 f "build" } } [ "2.7.2+build" parse-semver ] unit-test

[ "2.7.2.1+build" parse-semver ] [ malformed-semver? ] must-fail-with
[ "2.7.2.+build" parse-semver ] [ malformed-semver? ] must-fail-with
[ "2.7.2." parse-semver ] [ malformed-semver? ] must-fail-with
