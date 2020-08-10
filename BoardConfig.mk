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

# Partitions
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_USERDATAIMAGE_PARTITION_SIZE := 25765043200 # 25765059584 - 16384
BOARD_VENDORIMAGE_PARTITION_SIZE := 872415232

# Security Patch Level
VENDOR_SECURITY_PATCH := 2020-01-01

# Inherit the proprietary files
-include vendor/xiaomi/mido/BoardConfigVendor.mk
