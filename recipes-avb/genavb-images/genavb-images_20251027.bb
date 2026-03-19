SUMMARY = "GenAVB/TSN images (NXP logo)"

LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${UNPACKDIR}/LICENSE.txt;md5=89c557a3c81ccb02aa5d29667731acea"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

S = "${UNPACKDIR}/gen_avb_images-${PV}"

FILES:${PN} = "/home/images"

SRC_URI = "file://gen_avb_images-${PV}.tar.xz \
	file://LICENSE.txt \
"

SRC_URI[md5sum] = "f12550502a37e0d047b16ce2bfea3103"
SRC_URI[sha256sum] = "3650f36f1c8716fb98bfc8f5d89d1feecb8a9cc1659eade7a24fad2f874ca403"

do_configure[noexec] = "1"
do_patch[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
	install -d ${D}/home/images
	install -m ug+rw ${S}/*.* ${D}/home/images/
}
