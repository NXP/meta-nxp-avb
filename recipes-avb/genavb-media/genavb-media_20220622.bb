SUMMARY = "GenAVB media sample files"

LICENSE = "CC-BY-3.0"
LIC_FILES_CHKSUM = "file://${WORKDIR}/CC-BY-3.0;md5=dfa02b5755629022e267f10b9c0a2ab7"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

S = "${WORKDIR}/gen_avb_medias-${PV}"

FILES:${PN} = "/home/media"

SRC_URI = "file://gen_avb_medias-${PV}.tar.xz \
	file://CC-BY-3.0 \
"

SRC_URI[md5sum] = "5c12f78f6776ed46dd0ea6bc6fb3a227"
SRC_URI[sha256sum] = "16e5d89e828b181ba49d4666b76d70657b612ea98522990ce799bfda120f8f86"

do_configure[noexec] = "1"
do_patch[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
	install -d ${D}/home/media
	install -m ug+rw ${S}/*.* ${D}/home/media/
}

