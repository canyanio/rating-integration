#!/bin/bash
date

while [ "$DEV" -gt "0" ];
  do
    echo "DEVELOPMENT mode ON"
    sleep 30
  done

# check config file for errors
/usr/sbin/opensips -c

# skip syslog and run opensips at stderr
/usr/sbin/opensips -FDE -f /etc/opensips/opensips.cfg
