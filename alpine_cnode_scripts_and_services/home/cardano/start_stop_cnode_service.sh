#!/bin/bash
source /etc/profile

if [ -z $USER ]; then
	echo ""
	echo "Detecting and storing username in /etc/profile"
	echo ""
	export USER=$(whoami)
	chown $USER ~/cnode/db/*/*
	chgrp $USER ~/cnode/db/*/*
	chown $USER ~/cnode/*/*
	chgrp $USER ~/cnode/*/*
	sudo ash -c "echo 'export USER=$USER' >> /etc/profile"
	source /etc/profile
fi

if [ "$USER" != "$(whoami)" ]; then
        echo ""
        echo "Detecting and storing new username in /etc/profile"
        echo ""
	sudo sed -i "s/export USER=$USER/export USER=$(whoami)/g" /etc/profile
	source /etc/profile
        chown $USER ~/cnode/db/*/*
        chgrp $USER ~/cnode/db/*/*
        chown $USER ~/cnode/*/*
        chgrp $USER ~/cnode/*/*
fi

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
			

