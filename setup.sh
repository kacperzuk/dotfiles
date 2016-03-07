#!/bin/sh

set -e

if [[ -n "$(dirname $0)" ]]; then
    cd "$(dirname $0)"
fi

pushd generic >/dev/null
. setup.sh
popd >/dev/null

[[ -f /etc/arch-release ]] && exec arch/setup.sh $@
grep -q Ubuntu /etc/lsb-release && exec ubuntu/setup.sh $@
