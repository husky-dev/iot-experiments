PORT=/dev/cu.usbserial-0001
BAUDRATE=115200

check-port: FORCE
	ls /dev/cu.usbserial-*

upload: FORCE
	rshell -b ${BAUDRATE} -p ${PORT} rsync ./firmware /pyboard

download: FORCE
	rshell -b ${BAUDRATE} -p ${PORT} rsync /pyboard ./firmware

rshell: FORCE
	rshell -b ${BAUDRATE} -p ${PORT}

repl: FORCE
	rshell -b ${BAUDRATE} -p ${PORT} repl

erase: FORCE
	esptool.py --port ${PORT} erase_flash

firmware: FORCE
	esptool.py \
	  --port ${PORT} \
	  --chip esp32 \
	  --baud 460800 \
	  write_flash -z 0x1000 \
	  ./bin/esp32-idf3-20200902-v1.13.bin

FORCE: ;
