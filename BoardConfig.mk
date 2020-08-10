#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from msm8953-common
-include device/xiaomi/msm8953-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/mido

# Kernel
TARGET_KERNEL_CONFIG := mido_defconfig

# Inherit the proprietary files
-include vendor/xiaomi/mido/BoardConfigVendor.mk
