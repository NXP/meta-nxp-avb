inherit pkgconfig

GENAVB_TSN_CONFIG:mx6-nxp-bsp = "endpoint_avb"
GENAVB_TSN_CONFIG:mx8-nxp-bsp = "endpoint_avb"
GENAVB_TSN_CONFIG:mx8mp-nxp-bsp = "endpoint_avb_tsn"
GENAVB_TSN_CONFIG:mx93-nxp-bsp = "endpoint_avb_tsn"
GENAVB_TSN_CONFIG:mx8dxl-nxp-bsp = "endpoint_avb_tsn_bridge"

GENAVB_TSN_TARGET:mx8-nxp-bsp = "linux_imx8"
GENAVB_TSN_TARGET:mx93-nxp-bsp = "linux_imx8"
GENAVB_TSN_TARGET:mx6-nxp-bsp = "linux_imx6"
GENAVB_TSN_TARGET:mx6ull-nxp-bsp = "linux_imx6ull"

GENAVB_TSN_DEMO_APPS = "1"

# Add dependencies for AVB endpoint demo apps
ENDPOINT_AVB_APPS_DEPS = "alsa-lib gstreamer1.0 gstreamer1.0-plugins-base"

DEPENDS:append = " ${@bb.utils.contains_any('GENAVB_TSN_CONFIG', 'endpoint_avb endpoint_avb_tsn endpoint_avb_tsn_bridge', \
		      bb.utils.contains('GENAVB_TSN_DEMO_APPS', '1', '${ENDPOINT_AVB_APPS_DEPS}', ' ', d),\
		      '', d)}"

# Add Runtime recommended packages for AVB endpoint demo apps
ENDPOINT_AVB_APPS_RRECOMMENDS = "genavb-media alsa-utils-alsamixer"

RRECOMMENDS:${PN}:append = " ${@bb.utils.contains_any('GENAVB_TSN_CONFIG', 'endpoint_avb endpoint_avb_tsn endpoint_avb_tsn_bridge', \
				bb.utils.contains('GENAVB_TSN_DEMO_APPS', '1', '${ENDPOINT_AVB_APPS_RRECOMMENDS}', ' ', d),\
				'', d)}"

# AVB script is using alsa amixer and aplay to set the audio soundcards setup.
RDEPENDS:${PN}:append = " alsa-utils-amixer alsa-utils-aplay"

# Script salsacam-cmd.sh requires /bin/bash
RDEPENDS:${PN}:append = " ${@bb.utils.contains('GENAVB_TSN_DEMO_APPS', '1', 'bash', ' ', d)}"

do_install:append() {
	# Blacklist genavbtsn_net_avb, don't load genavbtsn_net_avb on boot but rather when starting the stack
	if [ "${@bb.utils.contains_any('GENAVB_TSN_CONFIG', 'endpoint_avb endpoint_avb_tsn endpoint_avb_tsn_bridge', '1', '0', d)}" = "1" ] ; then
    	install -d ${D}${sysconfdir}/modprobe.d

		echo "blacklist genavbtsn_net_avb" > ${D}${sysconfdir}/modprobe.d/genavbtsn.conf
	fi
}
