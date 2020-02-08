
IMAGE_FEATURES += "ssh-server-dropbear"
IMAGE_INSTALL += "gpsd libgps\
		  json-c \
		  gps-tracker \
"

ENABLE_UART = "1"
