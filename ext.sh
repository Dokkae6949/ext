#!/usr/bin/env bash

function show_help() {
    echo "Usage: $0 <file>"
    echo "Extract various archive types."
    echo
    echo "Supported file types:"
    echo "  *.tar.bz2, *.tar.gz, *.bz2, *.rar, *.gz, *.tar,"
    echo "  *.tbz2, *.tgz, *.zip, *.Z, *.7z"
}

function extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "Error: '$1' compression type not supported." ;;
        esac
    else
        echo "Error: '$1' is not a valid file."
    fi
}

if [ "$#" -ne 1 ]; then
    show_help
    exit 1
fi

extract $1
