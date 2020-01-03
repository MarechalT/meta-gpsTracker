FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://wpa_supplicant.conf.hubska"

do_install_append() {
install -d ${D}${sysconfdir}
install -m 0755 ${WORKDIR}/wpa_supplicant.conf.hubska ${D}${sysconfdir}/wpa_supplicant.conf
}
