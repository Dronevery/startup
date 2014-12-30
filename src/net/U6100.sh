#!/bin/bash

function init_U6100()
{
	debug_msg "U6100(ppp) starting..."
	local DEV="$1"
	while [ ! $ip ];do
		debug_msg "U6100 try to connecting..."
    	local ip=$(ip addr show dev ppp0 | awk '{if($1=="inet") print $2}' | awk 'BEGIN{FS="/"}{print $1}' | head -n 1)
    	if [ `ps aux | grep pppd | wc -l` = 1 ];then
    		debug_msg "U6100 call pppd"
	        /usr/sbin/pppd "${DEV}" connect "chat -v -f /srv/DTR-3G/chatscript "
	    fi
    	sleep 3
	done;
	
	export UNICOM_IFACE="ppp0"
	export UNICOM_IP=$ip
}