DESCRIPTION="Simple test application to retrieve the gps position using libgpsd"
LICENSE = "CLOSED"
inherit pkgconfig cmake

inherit update-rc.d

DEPENDS += "gpsd \
	    json-c \
"

RDEPENDS_${PN} += " gpsd \
		    json-c \
		    initscripts \
		    mosquitto \
"

SRC_URI = "\
    git://git@github.com/MarechalT/GPSManager.git;protocol=ssh \
"
SRCREV = "master"

S = "${WORKDIR}/git"

INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME = "start_gps-tracker"

#CONFFILES_${PN} += "${sysconfdir}/init.d/gps_start"

do_install() {
	install -d ${D}${bindir}
	install -d ${D}${sysconfdir}/init.d

	install -m 0755 gpsManager ${D}${bindir}
	install -m 0755 gpsTest ${D}${bindir}
	install -m 0755 ${S}/initscript/start_gps-tracker ${D}${sysconfdir}/init.d/
}
