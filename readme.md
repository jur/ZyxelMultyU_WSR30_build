# Build firmware for Zyxel WSR30 MultyU AC2100

## Install packages
```sudo apt-get update || exit $?
sudo apt-get install -y gcc-mips-linux-gnu sispmctl picocom make tftp || exit $?```
Install docker as described on:
https://docs.docker.com/engine/install/
Docker needs to be installed for the user which is used for building.

## Start docker
```sudo systemctl start docker```

## Automatic build
```./docker/build-firmware.sh```

## Manually build
* Start docker container: ```./docker/run-docker.sh```
* Prepare build:
~~~
    cd 100ABMY13C0/rtl819x
    export TERM=xterm1
    export TERMINFO=/usr/share/terminfo
~~~
* Modify startup script as needed: ```vim ./users/zyxel/release_file/etc/init.d/rcS```
* Build firmware image: ```make```

## Serial Interface
The serial interface is available at jumper J18:

Pin  |Description
-----|-----------
Pin 1|3.3V
Pin 2|UART TX
Pin 3|UART RX
Pin 4|0V ???
Pin 5|GND

A serial to USB converter with 3.3V can be used.

## Flash Firmware Update
### Manual Flash Update
* Connect 192.168.1.0 network to WAN port (near reset button).
* Connect serial line and terminal emulation program:
```picocom -b 38400 /dev/ttyUSB0```

* Power on target and press ESC to stop boot.

* Upload firmware via TFTP:

~~~
tftp 192.168.1.6
binary
put fw.bin
~~~

* Login with root user, no password.

### Automatic Flash Update
```./updateflash.sh```
