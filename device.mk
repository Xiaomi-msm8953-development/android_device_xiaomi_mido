#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from msm8953-common
$(call inherit-product, device/xiaomi/msm8953-common/msm8953.mk)

# Inherit proprietary files
$(call inherit-product-if-exists, vendor/xiaomi/mido/mido-vendor.mk)
