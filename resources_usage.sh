#!/bin/bash
#Script-Name: resources_usage.sh
#Description: This script displays the resources usage by processes for last 10 seconds
ps k-etime h -eocomm,%mem,%cpu,etimes | while read comm mem cpu etime; do [ $etime -lt 10 ] && echo -e "$comm\t\t$mem\t\t$cpu\t\t$etime"; done