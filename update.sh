#!/bin/bash

pushd src

wget -N https://publicsuffix.org/list/effective_tld_names.dat

perl parse_rules.pl > publicsuffix.erl

popd
