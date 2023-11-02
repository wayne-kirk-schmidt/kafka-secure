#!/usr/bin/env bash
#
# Exaplanation: secure files and directories within a Unix build
# 
# Usage:
#    $ bash  secure_permissions.bash
#
# Style:
#    Google Bash Style Guide:
#    https://google.github.io/styleguide/shellguide.html
#
#    @name           secure_permissions.bash
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

### Setup the exclude file location and run the find for directories
DIRECTORY_EXCLUDE_CFG="$ETCDIR/directory-excludes.txt"
[ -f "$DIRECTORY_EXCLUDE_CFG" ] && {
    find / -type d \( -perm -020 -o -perm -002 \) -exec ls -1d {} + 2>/dev/null | \
        grep -E -v --file="$DIRECTORY_EXCLUDE_CFG" | \
        while read -r targetdir ; do chmod g-w,o-w "$targetdir" ; done
}

### Setup the exclude file location and run the find for files
FILE_EXCLUDE_CFG="$ETCDIR/file-excludes.txt"
[ -f "$FILE_EXCLUDE_CFG" ] && {
    find / -type f \( -perm -4000 -o -perm -2000 -o -perm -6000 \) -exec ls -1d {} + 2>/dev/null | \
        grep -E -v --file="$FILE_EXCLUDE_CFG" | \
        while read -r targetfile ; do chmod u-s,g-s,o-s "$targetfile" ; done
}
