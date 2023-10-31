#!/usr/bin/env bash
#
# Exaplanation: applies app armor profiles to main software running on the server
# 
# Usage:
#    $ bash  secure_applications.bash
#
# Style:
#    Google Bash Style Guide:
#    https://google.github.io/styleguide/shellguide.html
#
#    @name           secure_applications.bash
#    @version        1.00
#    @author-name    Wayne Kirk Schmidt
#    @author-email   wayne.kirk.schmidt@changeis.co.jp
#

umask 022

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"

### Define the bin and the etc directory as related to the running script
BINDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
ETCDIR=$( realpath "$BINDIR"/../etc )

sudo apt-get update -y
sudo apt-get install -y apparmor apparmor-utils

APPARMOURSVCLIST="logstash zookeeper kafka"

APPARMOURDIR="/etc/apparmor.d/profile"

RCLOCALFILE="/etc/rc.local"

for APPARMOURSVC in "$APPARMOURSVCLIST"
do
	SRCARMOURFILE="$ETCDIR/apparmour.$APPARMOURSVC.txt"
	DSTARMOURFILE="$APPARMOURDIR/$APPARMOURSVC"
	cp "$SRCARMOURFILE" "$DSTARMOURFILE"
	apparmor_parser -r "$DSTARMOURFILE"
	### apparmor_parser -r "$DSTARMOURFILE" >> "$RCLOCALFILE"
	### systemctl restart "$APPARMOURSVC"
done
