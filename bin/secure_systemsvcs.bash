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

systemctl list-units --type=service --no-pager --no-legend | \
awk '{print $1}' | while read servicename ; do echo "systemctl disable $servicename "; done

SVCSLISTFILE="$ETCDIR/etc/systemctl.vitalsvcs.txt"

cat $SVCSLISTFILE | while read servicename ; do echo "systemctl enable $servicename "; done

