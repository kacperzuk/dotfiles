#!/bin/sh

set -e

. generic/setup.sh

[[ -f /etc/arch-release ]] && exec arch/setup.sh
grep -q Ubuntu /etc/lsb-release && exec ubuntu/setup.sh
