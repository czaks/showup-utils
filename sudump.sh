#!/bin/sh
# Usage: ./sudump.sh nickname > dump.flv
# -----------------------------------
# Dumps selected transmission to stdout
rtmpdump -r `./suurl.sh "$1"` -b 0
