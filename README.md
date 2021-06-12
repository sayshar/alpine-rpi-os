# AlpineOS-Cardano-RPi

## Why use AlpineOS on the Raspberry Pi? Here are some reasons:
1) Very low memory consumption (~50MB utilised during idle vs ~350MB for Ubuntu 20.04).
2) Lower CPU overhead (27 tasks/ 31 threads active for Alpine vs 57 tasks / 111 threads for Ubuntu when cardano-node is running).
3) Cooler Pi 😎 (Literally, CPU runs cooler because of the lower CPU overhead).
4) And finally, why not? If you're gonna use static binaries, might as well take advantage of AlpineOS 😜

### Initial Setup for AlpineOS on Raspberry Pi 4B 8GB:
1) Download the AlpineOS for RPi 4 aarch64 here: https://dl-cdn.alpinelinux.org/alpine/v3.13/releases/aarch64/alpine-rpi-3.13.5-aarch64.tar.gz

2) Decompress the .tar.gz file and copy it's contents into an SSD/SD card.

3) Plug in a keyboard and monitor.

4) Login with username 'root'.

5) Run the command `setup-alpine` and follow the instructions.

6) At the last step of `setup-alpine`, you will be prompted to choose the system disk. In case you have missed it, run the command `setup-disk` and create the partition for `sys`. You may have to retry and erase the entire disk.

7) Reboot.

8) Add a new user called cardano via the command `adduser cardano` and its password as instructed. (For username other than **cardano**, refer to **General Troubleshooting**)

9) Run the following commands to grant the new user full root privileges.
```
apk add sudo
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
addgroup cardano wheel
addgroup cardano sys
addgroup cardano adm
addgroup cardano root
addgroup cardano bin
addgroup cardano daemon
addgroup cardano disk
addgroup cardano floppy
addgroup cardano dialout
addgroup cardano tape
addgroup cardano video
```

10) Either exit root via the command `exit` or reboot and login to cardano. You may continue the next steps via SSH for easy copy and paste 😁.

11) Install bash to ensure bash script compatibility.

    ```
    sudo apk add bash
    ```
    
11) Also install git, nano and wget, we will need it later.

    ```
    sudo apk add git nano wget
    ```

## Installing the 'cardano-node' and 'cardano-cli' static binaries (AlpineOS uses static binaries almost exclusively so you should avoid non-static builds)

#### You can obtain the static binaries for version 1.27.0 via the link [https://ci.zw3rk.com/build/1758] courtesy of Moritz Angermann, the SPO of ZW3RK. You can follow the following commands to install the binaries into the correct folder:
1)  Download the binaries.

    ```
    wget -O ~/aarch64-unknown-linux-musl-cardano-node-1.27.0.zip https://ci.zw3rk.com/build/1758/download/1/aarch64-unknown-linux-musl-cardano-node-1.27.0.zip
    ```
2)  Unzip and install the binaries via the commands.

    ```
    unzip -d ~/ aarch64-unknown-linux-musl-cardano-node-1.27.0.zip
    
    sudo mv ~/cardano-node/* /usr/local/bin/
    ```
    

## If you have decided to use AlpineOS for your Cardano stake pool operations, you may find this collection of script and services useful.
### To install the scripts and services correctly:
1)  Clone this repo to obtain the neccessary folder and scripts to quickly start your cardano node. Use the command:
    
    ```
    git clone https://github.com/armada-alliance/alpine-rpi-os
    ```
            
2)  Run the following commands to then install the cnode folder, scripts and services into the correct folders. The **cnode** folder contains everything a cardano-node needs to start as a functional relay node:

    ```        
    cp -r alpine-rpi-os/alpine_cnode_scripts_and_services/home/cardano/* ~/
    ```
    ```
    sudo cp alpine-rpi-os/alpine_cnode_scripts_and_services/etc/init.d/* /etc/init.d/
    ```
    ```
    chmod +x ~/start_stop_cnode_service.sh ~/cnode/autorestart_cnode.sh
    ```
    ```
    sudo chmod +x /etc/init.d/cardano-node /etc/init.d/prometheus /etc/init.d/node-exporter
    ```
3)  For faster syncing, consider this optional command for downloading the latest db folder hosted by one of our Alliance members.
    
    ```
    wget -r -np -nH -R "index.html*" -e robots=off https://db.adamantium.online/db/ -P ~/cnode
    ```
    
4)  Follow the guide written in **README.txt** contained in the $HOME directory after installing cnode, scripts and services.
    
    ```
    more ~/README.txt
    ```

### If you plan on using prometheus and node exporter, do the following:
1)  Download prometheus and node-exporter into the home directory.
    
    ```
    wget -O ~/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.27.1/prometheus-2.27.1.linux-arm64.tar.gz
    ``` 
    ```
    wget -O ~/node_exporter.tar.gz https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-arm64.tar.gz
    ```
2)  Extract the tarballs.
    ```
    tar -xzvf prometheus.tar.gz
    ``` 
    ```
    tar -xzvf node_exporter.tar.gz
    ```

3)  Rename the folders with the following commands.

    ```
    mv prometheus-2.27.1.linux-arm64 prometheus
    ```
    ```
    mv node_exporter-1.1.2.linux-arm64 node_exporter
    ```

4)  Follow the guide written in README.txt contained in the $HOME directory after installing cnode, scripts and services to start the services accordingly.
    
    ```
    more ~/README.txt
    ```

### General Troubleshooting

1)  If you happen to use a \<username\> other than cardano, do use the following commands and replace \<username\> with your chosen username.

    ```
    sed -i 's@/home/cardano@/home/<username>@g' ~/cnode_env
    ```
    ```
    sudo sed -i 's@/home/cardano@/home/<username>@g' /etc/init.d/cardano-node
    ```
    ```
    sudo sed -i 's@/home/cardano@/home/<username>@g' /etc/init.d/prometheus
    ```
    ```
    sudo sed -i 's@/home/cardano@/home/<username>@g' /etc/init.d/node-export
    ```
2)  If you have trouble with port forwarding via SSH, run the following command
    
    ```
    sudo nano /etc/ssh/sshd_config
    ```
    Then edit the line `AllowTcpForwarding no` to `AllowTcpForwarding yes`. Make sure this line is not commented with `#`.
