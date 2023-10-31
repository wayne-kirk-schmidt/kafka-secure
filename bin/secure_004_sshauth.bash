#!/usr/bin/env bash
#
# Exaplanation: secure SSH configuration file
# 
# Usage:
#    $ bash  secure_sshauth.bash
#
# Style:
#    Google Bash Style Guide:
#    https://google.github.io/styleguide/shellguide.html
#
#    @name           secure_sshauth.bash
#    @version        1.00
#    @author-name    Wayne Kirk Schmidt
#    @author-email   wayne.kirk.schmidt@changeis.co.jp
#

umask 022

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"

### Define the bin and the etc directory as related to the running script
BINDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
ETCDIR=$( realpath "$BINDIR"/../etc )

DSTSSHCFG="/etc/ssh/sshd_config.d/10-general-security.conf"
SRCSSHCFG="$ETCDIR/ssh.security.conf"
cp "$SRCSSHCFG" "$DSTSSHCFG"
