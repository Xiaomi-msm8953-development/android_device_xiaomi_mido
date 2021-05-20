#!/bin/bash
#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in

    # Remove goodix dependencies
    vendor/bin/gx_fpd)
        "${PATCHELF}" --remove-needed "fakelogprint.so" "${2}"
        "${PATCHELF}" --remove-needed "libshims_gxfpd.so" "${2}"
        "${PATCHELF}" --remove-needed "libunwind.so" "${2}"
        "${PATCHELF}" --remove-needed "libbacktrace.so" "${2}"
        ;;

    vendor/lib64/hw/fingerprint.goodix.so)
        "${PATCHELF}" --remove-needed "fakelogprint.so" "${2}"
        ;;

    vendor/lib64/hw/gxfingerprint.default.so)
        "${PATCHELF}" --remove-needed "fakelogprint.so" "${2}"
        ;;

    # Hax libmmcamera2_sensor_modules.so to load cam configs from vendor
    vendor/lib/libmmcamera2_sensor_modules.so)
        sed -i 's|/system/etc/camera|/vendor/etc/camera|g' "${2}"
        ;;

    # Hex edit libmmcamera_dbg.so
    vendor/lib/libmmcamera_dbg.so)
        sed -i 's|persist.camera.debug.logfile|persist.vendor.camera.dbglog|g' "${2}"
        ;;

    # Camera socket
    vendor/bin/mm-qcamera-daemon)
        sed -i 's|/data/misc/camera/cam_socket|/data/vendor/qcam/cam_socket|g' "${2}"
        ;;

    # Camera data
    vendor/lib/libmmcamera2_cpp_module.so|vendor/lib/libmmcamera2_dcrf.so|vendor/lib/libmmcamera2_iface_modules.so|vendor/lib/libmmcamera2_imglib_modules.so|vendor/lib/libmmcamera2_mct.so|vendor/lib/libmmcamera2_pproc_modules.so|vendor/lib/libmmcamera2_q3a_core.so|vendor/lib/libmmcamera2_sensor_modules.so|vendor/lib/libmmcamera2_stats_algorithm.so|vendor/lib/libmmcamera2_stats_modules.so|vendor/lib/libmmcamera_dbg.so|vendor/lib/libmmcamera_imglib.so|vendor/lib/libmmcamera_pdafcamif.so|vendor/lib/libmmcamera_pdaf.so|vendor/lib/libmmcamera_tintless_algo.so|vendor/lib/libmmcamera_tintless_bg_pca_algo.so|vendor/lib/libmmcamera_tuning.so)
        sed -i 's|/data/misc/camera/|/data/vendor/qcam/|g' "${2}"
        ;;

    # Camera shim
    vendor/lib/libmmcamera_ppeiscore.so)
        "${PATCHELF}" --add-needed "libui_shim.so" "${2}"
        ;;

    vendor/lib/libmmcamera2_stats_modules.so)
        sed -i 's|libandroid.so|libcamshim.so|g' "${2}"
        ;;

    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

# Required
export DEVICE=mido
export DEVICE_COMMON=msm8953-common
export VENDOR=xiaomi

export DEVICE_BRINGUP_YEAR=2020

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
