FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}_5.15:"

DELTA_KERNEL_DEFCONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'real-time-edge-avb', 'imx_avb.config', '', d)}"
DELTA_KERNEL_DEFCONFIG:append:mx6ull = " ${@bb.utils.contains('DISTRO_FEATURES', 'real-time-edge-avb', 'imx_up.config', '', d)}"

SRC_URI:remove:real-time-edge-avb = " \
      file://linux-fec.config \
"

LOCALVERSION:real-time-edge-avb = "-real-time-edge-avb"

# Since we are applying custom patches, remove adding kernel commit ID into
# the kernel release version.
# Everytime the patches are applied, a new commit ID is generated and having a sha pointing to nowhere
# in the kernel version does not make much sense. Also, it causes multiple issues when building external kernel
# modules and using sstate.
SCMVERSION:real-time-edge-avb = "n"
