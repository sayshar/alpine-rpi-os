Hi. This is an Alpine OS build for running the cardano-node.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To run as relay.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1) Edit the file ~/cnode/files/mainnet-topology.json to add
   the relays closest to you. About 10 pool relays are
   recommmended. Do not forget to add your BP node. Do not
   exceed 16 entries as best practice.

2) Execute start_stop_cnode_service.sh when ready. No 
   additional settings needed as relay mode is default.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To run as a block producer (BP)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1) Place the following files within ~/cnode/bp-keys
   poolname.vrf.skey
   poolname.kes.skey and 
   poolname.opcert

2) Edit the file ~/cnode/files/mainnet-topology.json to add
   your relays only. The relay nodes should also have your
   BP node within their respective topology files.

3) Edit the run mode within cnode_env. It should look like
   export CARDANO_RUN_MODE=2

4) Execute start_stop_cnode_service.sh when ready.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Prometheus and node-export for prometheus configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1) You may edit the web listen address for prometheus and
   node export via editing the relevant variables within 
   the ~/cnode_env file.

2) You may then start the services via the commands:
	sudo rc-service node-exporter start
	sudo rc-service prometheus start

3) If you want to ensure prometheus and node-exporter work
   on boot, run the following commands.
	sudo rc-update add node-exporter
	sudo rc-update add prometheus

4) If you wish to disable prometheus and node-exporter
   services on boot, run the following commands.
        sudo rc-update del node-exporter
        sudo rc-update del prometheus

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
General info
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*) Copy db folder into ~/cnode for faster syncing

*) Tested with cardano-node/cardano-cli version 1.27.0

*) You may monitor your cardano node via the command
	tail -f ~/cnode/logs/cardano-node.json

*) You may delete the backup run logs for cardano-node
   within ~/cnode/logs.

*) It was found that gLiveView currently does not work. Use
   prometheus to ensure that the cardano-node is running
   well.

*) Check on the services you have started using the command
	rc-status
   
   The services you should look out for are
   
   cardano-node
   node-exporter
   prometheus

*) The cardano-node service is written such that it can
   report a wide range of reasons in case of failure.
   Check the cnode_env file in the $HOME directory if
   any issues should arise.
