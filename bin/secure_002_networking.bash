#!/usr/bin/env bash
#
# Exaplanation: implement network hardening
# 
# Usage:
#    $ bash  secure_networking.bash
#
# Style:
#    Google Bash Style Guide:
#    https://google.github.io/styleguide/shellguide.html
#
#    @name           secure_networking.bash
#    @version        1.00
#    @author-name    Wayne Kirk Schmidt
#    @author-email   wayne.kirk.schmidt@changeis.co.jp
#

umask 022

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"

### Setup apt-get and following scripts to be non-interactive
export DEBIAN_FRONTEND=noninteractive

### Define the bin and the etc directory as related to the running script
BINDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
ETCDIR=$( realpath "$BINDIR"/../etc )

SRCSYSCTLFILE="$ETCDIR/sysctl.network.hardening.txt"
DSTSYSCTLFILE="/etc/sysctl.conf"

cat "$SRCSYSCTLFILE" >> "$DSTSYSCTLFILE"

sysctl -p
