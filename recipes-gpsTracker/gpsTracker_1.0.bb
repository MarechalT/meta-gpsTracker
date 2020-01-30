DESCRIPTION="Simple test application to retrieve the gps position using libgpsd"

LICENCE = "CLOSED"
inherit update-rc pkgconfig cmake

DEPENDS += "gpsd \
	  json-c \
"
RDEPENDS_${PN} += " gpsd \
json-c \
"

SRC_URI = "git://github.com/MarechalT/GPSManager"
SRCREV = "master"

INITSCRIPT_PARAMS = "default 95"
INITSCRIPT_NAME = "gps_start"
CONFFILES_${PN} += "${sysconfdir}/init.d/gps_start"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 gpsManager ${D}${bindir}
	install gps_init ${D}${sysconfdir}/init.d/
}
