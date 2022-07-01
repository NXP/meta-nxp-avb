GENAVB_TSN_CONFIG:real-time-edge-avb = "endpoint_avb"

GENAVB_TSN_TARGET:mx8 = "linux_imx8"
GENAVB_TSN_TARGET:mx6 = "linux_imx6"
GENAVB_TSN_TARGET:mx6ull = "linux_imx6ull"

GENAVB_TSN_DEMO_APPS = "1"

inherit ${@bb.utils.contains('DISTRO_FEATURES', 'real-time-edge-avb', \
           bb.utils.contains('GENAVB_TSN_DEMO_APPS', '1', 'qt6-cmake', '', d), \
          '', d)}

DEPENDS:append:real-time-edge-avb = " ${@bb.utils.contains('GENAVB_TSN_DEMO_APPS', '1', 'alsa-lib qtbase gstreamer1.0 gstreamer1.0-plugins-base', ' ', d)}"
DEPENDS:remove:mx6ull = "libbpf"

# AVB script is using alsa amixer and aplay to set the audio soundcards setup.
RDEPENDS:${PN}:append:real-time-edge-avb = " ${@bb.utils.contains('GENAVB_TSN_DEMO_APPS', '1', 'alsa-utils-amixer alsa-utils-aplay', ' ', d)}"

RRECOMMENDS:${PN}:append:real-time-edge-avb = " ${@bb.utils.contains('GENAVB_TSN_DEMO_APPS', '1', 'genavb-media alsa-utils-alsamixer', ' ', d)}"

# Script salsacam-cmd.sh requires /bin/bash
RDEPENDS:${PN}:append:real-time-edge-avb = " ${@bb.utils.contains('GENAVB_TSN_DEMO_APPS', '1', 'bash', ' ', d)}"

SYSTEMD_AUTO_ENABLE:${PN}:real-time-edge-avb = "enable"

do_compile:prepend:real-time-edge-avb() {
	# Needed for apps cmake invocation
	export OE_QMAKE_PATH_EXTERNAL_HOST_BINS=${OE_QMAKE_PATH_EXTERNAL_HOST_BINS}
	export QT_HOST_PATH=${RECIPE_SYSROOT_NATIVE}/${prefix_native}
	export QT_BUILD_TOOLS_WHEN_CROSSCOMPILING=ON
}
