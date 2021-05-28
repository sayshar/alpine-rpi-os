# AlpineOS-Cardano-RPi
If you have decided to use AlpineOS for your Cardano stake pool operations, you may find this collection of script and services useful.

To install the scripts and services correctly,
1)  Extract alpine_cnode_scripts_and_services.tar.gz using the command

    `mkdir alpine_cnode_scripts_and_services`
    
    `tar -xzf alpine_cnode_scripts_and_services.tar.gz -C alpine_cnode_scripts_and_services`
    
2)  Run the following commands to then install cnode, scripts and services into the correct folders

    `mv alpine_cnode_scripts_and_services/home/cardano/* ~/`
    
    `mv alpine_cnode_scripts_and_services/etc/init.d/* /etc/init.d/`
    
3)  Follow the guide written in README.txt contained in the $HOME directory after installing cnode, scripts and services.

If you plan on using prometheus and node exporter, do the following
1)  Download prometheus and node-exporter into the home directory
    
    `wget -O ~/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.27.1/prometheus-2.27.1.linux-arm64.tar.gz`
    
    `wget -O ~/node_exporter.tar.gz https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-arm64.tar.gz`

2)  Rename the folders with the following commands

    `mv prometheus-2.27.1.linux-arm64 prometheus`
    
    `mv node_exporter-1.1.2.linux-arm64 node_exporter`
3)  Follow the guide written in README.txt contained in the $HOME directory after installing cnode, scripts and services to start the services accordingly.
