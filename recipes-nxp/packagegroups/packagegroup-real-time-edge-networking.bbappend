# Extend the genavb-tsn recipe to all configurations supporting real-time-edge-avb
RDEPENDS:${PN}:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'real-time-edge-avb', 'genavb-tsn', '', d)} "
