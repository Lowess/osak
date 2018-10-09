#!/usr/bin/env bash

function _osaka_find_dirname() {
    # Try to find the role's root repository
    local path="$1"
    local root="$2"

    if [[ "${path}" != '/' ]];
    then
        if [[ $(/usr/bin/basename $path) =~ $root ]];
        then
            echo $path
        else
            _osaka_find_dirname $(/usr/bin/dirname $path)
        fi
    fi
}

function _osaka_hugo_find_dirname() {
    # Find a Hugo root repository
    local path="$1"

    if [[ "${path}" != '/' ]];
    then
        if [[ -f $path/config.toml ]];
        then
            echo $path
        else
            _osaka_hugo_find_dirname $(/usr/bin/dirname $path)
        fi
    fi
}

function _osaka_hugo() {
    local EXEC_DIR
    local EXEC_DIR_NAME

    # Grab the role's root folder if any...
    EXEC_DIR=$(_osaka_hugo_find_dirname "$(pwd)")
    #... otherwise default to the current PWD
    if [[ -z "${EXEC_DIR}" ]]; then
        EXEC_DIR=$(pwd)
    fi

    EXEC_DIR_NAME=$(/usr/bin/basename "${EXEC_DIR}")

    local ENVS=()

    case "${1}" in
        server|serve)
            CMD="hugo ${1} --bind 0.0.0.0 -w ${@:2}"
            ENVS+=("-p" "1313:1313")
            ;;
        *)
            CMD="hugo ${1} ${@:2}"
            ;;
    esac

    docker run --rm -it \
        -v ${EXEC_DIR}:/src \
        -u hugo \
        ${ENVS} \
        jguyomard/hugo-builder $(echo "${CMD}")
}

function osaka() {
    case "$1" in
        ## Documentation
        hugo)
            _osaka_hugo "${@:2}"
            ;;

        ## Config management
        terraform)
            _osaka "${@}"
            ;;

        ansible)
            _osaka "${@}"
            ;;

        molecule)
            _osaka "${@}"
            ;;

        *)
            echo $@
            ;;
    esac
}
