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
        ;;

    vendor/lib64/hw/fingerprint.goodix.so)
        "${PATCHELF}" --remove-needed "fakelogprint.so" "${2}"
        ;;

    vendor/lib64/hw/gxfingerprint.default.so)
        "${PATCHELF}" --remove-needed "fakelogprint.so" "${2}"
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
