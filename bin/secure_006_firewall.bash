#!/usr/bin/env bash
#
# Exaplanation: applies UFW rules to the server
# 
# Usage:
#    $ bash  secure_firewall.bash
#
# Style:
#    Google Bash Style Guide:
#    https://google.github.io/styleguide/shellguide.html
#
#    @name           secure_firewall.bash
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

apt-get update -y && apt-get install -y ufw iptables

### Load Firewall rules
source "$ETCDIR/firewall.rules.txt"

### Enable firewall logging
ufw logging on

### Enable the Firewall
ufw --force enable
