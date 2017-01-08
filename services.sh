#!/bin/bash

if [ -n "`ufw status | grep "Status: inactive"`" ]; then
	ufw enable
fi
if [ -z "`ufw status | grep "40772"`" ]; then
	ufw allow to any port 40772 from 192.168.35.0/24
fi

if [ ! -s /usr/local/etc/mirakurun/channels.yml ]; then
	cat /usr/local/share/mirakurun/channels.yml > /usr/local/etc/mirakurun/channels.yml
fi
if [ ! -s /usr/local/etc/mirakurun/tuners.yml ]; then
	cat /usr/local/share/mirakurun/tuners.yml > /usr/local/etc/mirakurun/tuners.yml
fi
if [ ! -s /usr/local/etc/mirakurun/server.yml ]; then
	cat /usr/local/share/mirakurun/server.yml > /usr/local/etc/mirakurun/server.yml
fi

/usr/bin/mirakurun start
/usr/bin/mirakurun log server
