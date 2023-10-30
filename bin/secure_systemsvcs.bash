#!/usr/bin/env bash
#
# Exaplanation: disable all services not explicitly required by the appliance
# 
# Usage:
#    $ bash  secure_systemsvcs.bash
#
# Style:
#    Google Bash Style Guide:
#    https://google.github.io/styleguide/shellguide.html
#
#    @name           secure_systemsvcs.bash
#    @version        1.00
#    @author-name    Wayne Kirk Schmidt
#    @author-email   wayne.kirk.schmidt@changeis.co.jp
#

umask 022

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"

### Define the bin and the etc directory as related to the running script
BINDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
ETCDIR=$( realpath "$BINDIR"/../etc )

### Explicitly disable services
SVCSEXCLUDE="$ETCDIR/etc/systemctl.exclude.svcs.txt"
cat $SVCSEXCLUDE | while read servicename ; do systemctl disable "$servicename"; done

### Explicitly enable services
SVCSINCLUDE="$ETCDIR/etc/systemctl.include.svcs.txt"
cat $SVCSINCLUDE | while read servicename ; do systemctl enable "$servicename"; done

