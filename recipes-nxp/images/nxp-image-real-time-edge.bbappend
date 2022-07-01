# Include Qt tools in the SDK
inherit ${@bb.utils.contains('DISTRO_FEATURES', 'real-time-edge-avb', 'populate_sdk_qt6_base', '', d)}

TOOLCHAIN_HOST_TASK:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'real-time-edge-avb', 'nativesdk-packagegroup-qt6-toolchain-host', '', d)}"
TOOLCHAIN_TARGET_TASK:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'real-time-edge-avb', 'packagegroup-qt6-modules', '', d)}"
