FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://interfaces.hubska"

do_install_append() {
install -d ${D}${sysconfdir}/network
install -m 0755 ${WORKDIR}/interfaces.hubska ${D}${sysconfdir}/network/interfaces
}
