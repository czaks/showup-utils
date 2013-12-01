#!/bin/bash
# Usage: ./suurl.sh nickname
# ---------------------------
# Returns rtmp url of selected transmission
DATA=`curl -b "accept_rules=true" "http://showup.tv/$1" 2>/dev/null \
  | egrep 'startChildBug|srvE' \
  | ruby -e "puts gets.split(/'/)[3]; puts gets.split(/'/)[1]"`

SUSRV=`echo $DATA | cut -d' ' -f1`
SURTMP=`echo $DATA | cut -d' ' -f2`

echo "$SURTMP/$(./suproto.rb $SUSRV $1)"
