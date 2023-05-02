# rename-interfaces


The script is designed to rename network interfaces on a Linux machine using systemd-networkd. It is intended for situations where the default names assigned to network interfaces by the kernel are not suitable, and the administrator needs to assign more descriptive names, like eth0, wlan0


Script Usage:

git clone https://github.com/fconidi/rename-interfaces.git

cd rename-interfaces/

chmod +x rename-interfaces.sh

sudo ./rename-interfaces.sh

sudo reboot
