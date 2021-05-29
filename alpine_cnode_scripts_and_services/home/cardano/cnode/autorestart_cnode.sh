#!/bin/bash

# This script monitors the cardano-node program and restarts in intervals definded in ~/cnode_env

source /home/cardano/cnode_env

if [ $RUNTIME = 0 ]; then 

return 0

else

	for (( ; ; ))

	do

	sleep $RUNTIME

		rc-service cardano-node restart

	done
fi
