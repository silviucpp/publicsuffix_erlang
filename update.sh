#!/bin/bash

cleanup()
{
    rm public_suffix_list.dat
    rm publicsuffix_temp.erl
}

fail_check()
{
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        cleanup
        echo "error with $1" >&2
        exit 1
    fi
}

pushd src

if [ -f "publicsuffix.erl" ]; then
    echo "module already exist. remove publicsuffix.erl for a fresh generation ..."
else
    fail_check wget -N https://publicsuffix.org/list/public_suffix_list.dat
    fail_check perl ../parse_rules.pl > publicsuffix_temp.erl
    fail_check mv publicsuffix_temp.erl publicsuffix.erl
    fail_check rm public_suffix_list.dat
fi

popd
