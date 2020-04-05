setup raspberry pi

Config raspberry pi
https://www.raspberrypi.org/downloads/raspbian/

Download image

Erase and format the disk drive
`diskutil eraseDisk FAT32 BOOT /dev/disk2`

Unmount the disk
`diskutil unmountdisk /dev/disk2`

Unzip the os zip 
`unzip /Users/anelavelly/Downloads/2020-02-13-raspbian-buster\ \(1\).zip`

Copying the image to the SD card
`sudo dd bs=4m if=Users/anelavelly/Downloads/2020-02-13-raspbian-buster.img of=/dev/rdisk2 `

Setting up wireless networking

`cd /volume/BOOT/`

`vim wpa_supplicant.conf`

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=<Insert country code here>

network={
 ssid="<Name of your WiFi>"
 psk="<Password for your WiFi>"
}
```
Enabling SSH

`touch ssh`

`cd /`

`diskutil unmountdisk /dev/disk2`

`diskutil eject /dev/disk2`

insert the SD card into the raspberry pi

it will connect to your internet and use `arp -a` command to detect its IP address

test using `telnet {ip} 22`

`ssh pi@xx.xx.xx.xx` password is `raspberry`

change pis' config by running

Understanding registers resistance concept - https://www.youtube.com/watch?v=NfcgA1axPLo

install with dataplity Agent in the raspberry pi

setup api in raspberry pi
https://docs.dataplicity.com/docs/control-gpios-using-rest-api

create the service from the file smartGarage.service in this repo
`sudo vim /etc/systemd/system/smartGarage.service`

reload the daemon
`sudo systemctl daemon-reload`

start the service
`sudo systemctl start smartGarage.service`

enable the service
`sudo systemctl enable smartGarage.service`