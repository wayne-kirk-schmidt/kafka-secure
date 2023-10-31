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

### Define the bin and the etc directory as related to the running script
BINDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
ETCDIR=$( realpath "$BINDIR"/../etc )

apt-get update -y
apt-get install -y ufw

### Allow ICMP
ufw allow proto icmp

### Allow traceroute
ufw allow 33434:33524/udp
ufw allow 33434:33524/tcp

### Allow inbound SSH
ufw allow ssh

### Allow inbound Kafka
ufw allow 9092/tcp
ufw allow 9093/tcp

### Allow inbound zookeeper
ufw allow 2181/tcp

### Allow inbound logstash
ufw allow 5044/tcp


### Allow inbound SNMP traps
ufw allow 162/udp

### Allow incoming SNMP polling
ufw allow 161/udp

### Allow inbound Cisco telemetry
ufw allow 50000:60000/tcp
ufw allow 50000:60000/udp

### Allow inbound Syslog 
ufw allow 514/tcp
ufw allow 514/udp

### Allow outgoing traffic
ufw default allow outgoing

### Deny incoming traffic
ufw default deny incoming

### Enable firewall logging
ufw logging on

### Enable the Firewall
echo "y" | ufw enable
