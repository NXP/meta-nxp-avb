IMX_UP_CONFIG ?= ""
IMX_UP_CONFIG:mx6ull-nxp-bsp = "imx_up.config"

DELTA_KERNEL_DEFCONFIG:append:real-time-edge = " imx_avb.config ${IMX_UP_CONFIG}"

# Since we are applying custom patches, remove adding kernel commit ID into
# the kernel release version.
# Everytime the patches are applied, a new commit ID is generated and having a sha pointing to nowhere
# in the kernel version does not make much sense. Also, it causes multiple issues when building external kernel
# modules and using sstate.
# NOTE: .scmversion support has been removed in linux > v6.3, so keep this assignement to avoid useless processing in
# do_kernel_localversion() and use it to force removal of the kernel CONFIG_LOCALVERSION_AUTO configuration in
# kernel configure phase below.
SCMVERSION = "n"

do_configure:prepend() {
    if [ "${SCMVERSION}" = "n" ]; then
        sed -i -e "/CONFIG_LOCALVERSION_AUTO[ =]/d" ${B}/.config
        echo "# CONFIG_LOCALVERSION_AUTO is not set" >> ${B}/.config
    fi
}
