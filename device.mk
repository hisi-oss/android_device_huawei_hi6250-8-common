#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/hisi

# Call the proprietary setup
$(call inherit-product, vendor/huawei/prague/prague-vendor.mk)
