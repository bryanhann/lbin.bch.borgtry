#!/source/this/sh

borgtry_pushd   () {
    [   -z "$1" ] && return 1
    [ ! -d "$1" ] && return 2
    > /dev/null 2> /dev/null pushd $1 || return 3
}
borgtry_popd    () {
    > /dev/null 2> /dev/null popd || return 1
}

borgtry_withcd  () {
    borgtry_pushd $1 || return
    shift ; $* ; local err=$?
    borgtry_popd || return
    return $err
}

borgtry_insitu  () {
    local root=$1 ; shift
    [ -d "$root" ] || return 66
    borgtry_withcd ${root}/.insitu $*
    return $?
}

