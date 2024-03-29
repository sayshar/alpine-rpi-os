# AlpineOS-Cardano-RPi

## Why use AlpineOS on the Raspberry Pi? Here are some reasons:
1) Very low memory consumption (~50MB utilised during idle vs ~350MB for Ubuntu 20.04).

2) Lower CPU overhead (27 tasks/ 31 threads active for Alpine vs 57 tasks / 111 threads for Ubuntu when cardano-node is running).

3) Cooler Pi 😎 (Literally, CPU runs cooler because of the lower CPU overhead).

4) And finally, why not? If you're gonna use static binaries, might as well take advantage of AlpineOS 😜.

## If you have previously used this guide and intend to update the scripts. Follow these steps. Then follow the rest of the steps outlined in this guide accordingly 🙂. 

1) Update the git local repo.
```
cd ~/alpine-rpi-os
```
```
git fetch --recurse-submodules --tags --all
```
2) Identify the latest tag.
```
git tag
```
3) Replace \<tag\> in this step with the latest tag such as `v1.7.0`.
```
git checkout tags/<tag>
```

### Upgrading to Alpine v3.16 from Alpine v3.15:
1) Update your current version of AlpineOS.
```
sudo apk update
```
```
sudo apk upgrade
```
2) Edit the repository to reflect Alpine v3.17.
```
sudo sed -i 's@v3.16@v3.17@g' /etc/apk/repositories
```
3) Update the package list.
```
sudo apk update
```
4) Upgrading packages to v3.17
```
sudo apk add --upgrade apk-tools
```
```
sudo apk upgrade --available
```
```
sudo sync
```
```
sudo reboot now
```
5) Now you should have AlpineOS upgraded to v3.17 🍷.
```
cat /etc/alpine-release
```

6) To troubleshoot the upgrade, refer to the link: https://wiki.alpinelinux.org/wiki/Upgrading_Alpine

### Initial Setup for AlpineOS on Raspberry Pi 4B 8GB:
1) Download the AlpineOS for RPi 4 aarch64 [here](https://dl-cdn.alpinelinux.org/alpine/v3.17/releases/aarch64/alpine-rpi-3.17.0-aarch64.tar.gz).

2) Decompress the .tar.gz file and copy it's contents into an SSD/SD card.

3) Plug in a keyboard and monitor.

4) Login with username 'root'.

5) Run the command `setup-alpine` and follow the instructions.

6) At the last step of `setup-alpine`, you will be prompted to choose the system disk. In case you have missed it, run the command `setup-disk` and create the partition for `sys`. You may have to retry and erase the entire disk.

7) Reboot.

8) Add a new user called cardano via the command `adduser cardano` and its password as instructed.

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
    
12) Also install git, nano and wget, we will need it later.

    ```
    sudo apk add git nano wget
    ```
13) [Optional] By default, AlpineOS uses the powersave governor which sets CPU frequency at the lowest. To use the ondemand governor which scales CPU frequency according to system load, `cpufreq.start` is included in this repo which should be added to /etc/local.d/. You may run the following commands to do this for you.

    ```
    cd ~
    ```
    ```
    git clone https://github.com/armada-alliance/alpine-rpi-os
    ```
    ```
    cd alpine-rpi-os
    ```    
    ```
    git tag
    ```
    Replace \<tag\> with the latest tag in the next command such as `v1.7.0`.
    ```
    git checkout tags/<tag>
    ```
    ```
    sudo cp alpine-rpi-os/alpine_cnode_scripts_and_services/etc/local.d/cpufreq.start /etc/local.d/
    ```
    ```
    sudo chmod +x /etc/local.d/cpufreq.start
    ```
    ```
    sudo rc-update add local default
    ```
14) [Optional] To alleviate RAM limitation on RPi, ZRAM is recommended to enable RAM compression. Use the following steps to install zram-init and install the scripts. The scripts provided will enable a 50% boost in useable RAM capacity. This step assumes you have followed step 13.

    ```
    sudo apk add zram-init
    ```
    ```
    sudo cp alpine-rpi-os/alpine_cnode_scripts_and_services/etc/local.d/zram.* /etc/local.d/
    ```
    ```
    sudo chmod +x /etc/local.d/zram.*
    ```

15) Reboot the system.

## Installing/Upgrading the 'cardano-node' and 'cardano-cli' static binaries (AlpineOS uses static binaries almost exclusively so avoid non-static builds)

#### You can obtain the static binaries for version [1.35.4](https://github.com/armada-alliance/cardano-node-binaries/blob/main/static-binaries/1_35_4.zip?raw=true) thanks to Moritz Angermann, the SPO of ZW3RK. You can follow the following commands to install the binaries into the correct folder:
1)  Download the binaries.

    ```
    wget -O ~/aarch64-unknown-linux-musl-cardano-node-1.35.4.zip https://github.com/armada-alliance/cardano-node-binaries/blob/main/static-binaries/1_35_4.zip?raw=true
    ```
    
2)  Unzip and install the binaries via the commands.

    ```
    unzip -d ~/ aarch64-unknown-linux-musl-cardano-node-1.35.4.zip
    
    sudo mv ~/cardano-node/* /usr/local/bin/
    
    rm -r ~/cardano-node
    ```
    

## If you have decided to use AlpineOS for your Cardano stake pool operations, you may find this collection of script and services useful.
### To install the scripts and services correctly:
1)  Clone this repo to obtain the neccessary folder and scripts to quickly start your cardano node. You may skip this step if you have already clonned this repo from step 13 when setting up AlpineOS.
    
    ```
    cd ~
    ```
    ```
    git clone https://github.com/armada-alliance/alpine-rpi-os
    ```
    ```
    git tag
    ```
    Replace \<tag\> with the latest tag in the next command.
    ```
    git checkout tags/<tag>
    ```
            
2)  Run the following commands to then install the cnode folder, scripts and services into the correct folders. The **cnode** folder contains everything a cardano-node needs to start as a functional relay node.

    ```
    cd ~
    ```

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
    wget -O ~/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.36.2/prometheus-2.36.2.linux-arm64.tar.gz
    ``` 
    ```
    wget -O ~/node_exporter.tar.gz https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-arm64.tar.gz
    ```
2)  Extract the tarballs.
    ```
    tar -xzvf prometheus.tar.gz
    ``` 
    ```
    tar -xzvf node_exporter.tar.gz
    ```
3)  If you are upgrading from previous versions of prometheus and node-exporter, make a backup. You may delete these folders if they do not contain anything useful.

    ```
    mv prometheus prometheus-bak
    ```
    ```
    mv node_exporter node_exporter-bak
    ```

4)  Rename the folders with the following commands.

    ```
    mv prometheus-2.36.2.linux-arm64 prometheus
    ```
    ```
    mv node_exporter-1.3.1.linux-arm64 node_exporter
    ```

5)  Follow the guide written in README.txt contained in the $HOME directory after installing cnode, scripts and services to start the services accordingly.
    
    ```
    more ~/README.txt
    ```

### General Troubleshooting

1)  If you have trouble with port forwarding via SSH, run the following command
    
    ```
    sudo nano /etc/ssh/sshd_config
    ```
    Then edit the line `AllowTcpForwarding no` to `AllowTcpForwarding yes`. Make sure this line is not commented with `#`.
    
2) If you run into a situation where you get the error:

   > /lib/rc/sh/openrc-run.sh: source: line 10: can't open '/home//cnode_env': No such file or directory

   Do the following:
   
   ```
   export USER=$(whoami)
   sudo ash -c "echo 'export USER=$USER' >> /etc/profile"
   ```
   
   Then reboot:
   
   ```
   sudo reboot
   ```
   

   
