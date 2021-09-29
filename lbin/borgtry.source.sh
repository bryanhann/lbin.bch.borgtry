#!/source/this/sh

borgtry_pushd   () { 
    [ -d "$1" ] || return 66
    > /dev/null 2> /dev/null pushd $1 || return 67
}
borgtry_popd    () { 
    > /dev/null 2> /dev/null popd || return 66 
}

borgtry_withcd  () { 
    borgtry_pushd $1 || return 
    shift ; $* ; local err=$?
    borgtry_pop || return
    return $err
}

borgtry_insitu  () { 
    local root=$1 ; shift
    [ -d "$root" ] || return 66
    borgtry_withcd ${root}/.insitu $*
    return $?
}

