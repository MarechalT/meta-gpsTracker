
IMAGE_FEATURES += "ssh-server-dropbear"
IMAGE_INSTALL += "nano \
		  minicom \
		  gpsd gpsd-dev libgps\
		  ppp \
		  json-c \
"

ENABLE_UART = "1"
