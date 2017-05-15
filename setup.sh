#!/bin/bash

set -e

if [[ -n "$(dirname $0)" ]]; then
    cd "$(dirname $0)"
fi

grep -q Ubuntu /etc/lsb-release && sudo apt-get install curl -y

pushd generic >/dev/null
source ./setup.sh
popd >/dev/null

[[ -f /etc/arch-release ]] && exec arch/setup.sh $@
grep -q Ubuntu /etc/lsb-release && exec ubuntu/setup.sh $@

