# AlpineOS-Cardano-RPi

## Initial Setup:

1. Download the AlpineOS for RPi 4 aarch64 here: 
https://dl-cdn.alpinelinux.org/alpine/v3.13/releases/aarch64/alpine-rpi-3.13.5-aarch64.tar.gz

2. Decompress the .tar.gz file and copy it's contents into an SSD/SD card

3. Plug in a keyboard and monitor.

4. Login with username 'root'. It should prompt you for a new password on first log in.

5. Run the command 'setup-alpine' and follow the instructions.

6. Install sudo via the command 'apk add sudo'

7. Add a new user called cardano via the command 'adduser cardano' and its password as instructed.

8.  Run the following commands to grant the new user root privileges
```
apk add sudo 
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel 
adduser cardano wheel
```
9. Either exit or reboot and login to cardano

10. sudo apk add bash
