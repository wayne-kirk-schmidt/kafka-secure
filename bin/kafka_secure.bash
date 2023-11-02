#!/usr/bin/env bash

### Set up basic path and permissions to assist the script
umask 022
export PATH="/usr/bin:/usr/local/bin:/sbin:/usr/sbin:$PATH"

### Define the bin and the etc directory as related to the running script
BINDIR=$(dirname "$(realpath "$0")")
ETCDIR=$( realpath "$BINDIR"/../etc )

### Setup apt-get and following scripts to be non-interactive
export DEBIAN_FRONTEND=noninteractive

### Setup up all of the secure scripts to run on the target machine
SECURESCRIPTLIST=$( ls -1d $BINDIR/secure_???_* )
for SECURESCRIPT in ${SECURESCRIPTLIST}
do
	SECUREACTION=$( basename "$SECURESCRIPT" )
	echo "### ${SECUREACTION} ###"
	bash "${SECURESCRIPT}"
done
