#!/bin/sh
HERE=${PWD}
teardown () {
    echo "[$name]" >>  ~/out
}
. ../lbin/borgtry.source.sh

_pwd () { echo ${PWD}${1} ; }
_name () { export name=None ; $* ; echo $name ; }
@test "verifying exit codes of pushd" {
    run =0 borgtry_pushd ~
    run =1 borgtry_pushd
    run =2 borgtry_pushd /dev/null
}

@test "verying popd pushd " { 
    run =1 borgtry_popd
    borgtry_pushd /dev  ; [ ${PWD} = /dev ] ;
    borgtry_pushd /bin  ; [ ${PWD} = /bin ] ;
    borgtry_popd        ; [ ${PWD} = /dev ] ;
}

@test "withcd" { 
    run borgtry_withcd /dev _pwd -ok
    [ "$output" = "/dev-ok" ]
    borgtry_withcd /dev _pwd -ok
}

@test "withcd call  A 1" { run borgtry_withcd A   ./apple     ; [ "$output" = "I am apple"  ] ; }
@test "withcd call  A 2" { run borgtry_withcd A   ./B/banana  ; [ "$output" = "I am banana" ] ; }
@test "withcd call  B 1" { run borgtry_withcd A/B ./banana    ; [ "$output" = "I am banana" ] ; }

@test "withcd foo 1  " { run borgtry_withcd A         . ./foo           ; [ "$output"  = "A"        ] ; }
@test "withcd foo 2  " { run borgtry_withcd A         . ./.insitu/foo   ; [ "$output"  = "A"        ] ; }
@test "withcd foo 3  " { run borgtry_withcd A/.insitu . ./foo           ; [ "$output"  = ".insitu"  ] ; }



