#!/bin/bash
echo ""
echo "Welcome to the cnode service management script for OpenRC"
echo ""
echo "What would you like to do?"
echo ""
echo "Start/Stop cardano-node service == 1"
echo ""
echo "Add/Remove cardano-node service at boot == 2"
echo ""
read option

if [ $option = 1 ]; then
	if [ -f "/var/run/cardano-node.pid" ]; then
		sudo rc-service cardano-node stop
	else
		sudo rc-service cardano-node start
	fi
	
	else if [ $option = 2 ]; then
		if [ -f "/etc/runlevels/default/cardano-node" ]; then
			sudo rc-update del cardano-node
		else
			sudo rc-update add cardano-node
		fi
	fi
fi
			

