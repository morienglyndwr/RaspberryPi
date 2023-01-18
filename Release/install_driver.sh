#!/bin/bash
echo "Installing ARDUCAM-PIVARIETY-V4L2-DRIVER..."
echo "--------------------------------------"
uname=$(uname -r)
sudo install -p -m 755 ./arducam_camera_selector.sh /usr/bin/
sudo install -p -m 644 ./bin/$uname/arducam.ko.xz /lib/modules/$uname/kernel/drivers/media/i2c/
sudo install -p -m 644 ./bin/$uname/arducam.dtbo /boot/overlays/
sudo /sbin/depmod -a $(uname -r)

awk 'BEGIN{ count=0 }       \
{                           \
    if($1 == "dtoverlay=arducam"){       \
        count++;            \
    }                       \
}END{                       \
    if(count <= 0){         \
        system("sudo sh -c '\''echo dtoverlay=arducam >> /boot/config.txt'\''"); \
    }                       \
}' /boot/config.txt
