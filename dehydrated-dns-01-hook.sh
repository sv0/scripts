#!/bin/sh
# Source: https://github.com/sv0/scripts/dehydrated-dns-01-hook.sh
# This is dns-01 challenge hook used in dehydrated[1]
# to get wildcard Let's Encrypt[2] certificate.
# This assumes that you have Knot[3] DNS server up and running on the same host.

# Usage:
#    dehydrated --domain example.com \
#       --challenge dns-01 \
#       --hook /etc/dehydrated/dehydrated-dns-01-hook.sh \
#       --cron

# This script is licensed under The WTFPL (see LICENCE for more information).

# [1] https://github.com/dehydrated-io/dehydrated
# [2] https://letsencrypt.org
# [3] https://www.knot-dns.cz

set -e
set -u

case "$1" in
    "deploy_challenge")
        printf "Adding '_acme-challenge' record to the zone %s... " "$2"
        knotc zone-begin  "$2"
        knotc zone-set    "$2" _acme-challenge 3600 TXT "$4"
        knotc zone-commit "$2"
    ;;
    "clean_challenge")
        printf "Removing '_acme-challenge' record from the zone %s... " "$2"
        knotc zone-begin  "$2"
        knotc zone-unset  "$2" _acme-challenge TXT "$4"
        knotc zone-commit "$2"
    ;;
    "deploy_cert")
        # optional:
        # /path/to/deploy_cert.sh "$@"
    ;;
    "unchanged_cert")
        # do nothing for now
    ;;
    "startup_hook")
        # do nothing for now
    ;;
    "exit_hook")
        # do nothing for now
    ;;
esac

exit 0
