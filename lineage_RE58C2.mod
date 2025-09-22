#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# First inherit all system and lineage stuff
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_system.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# THEN include device specific settings WITHOUT inherit-product
include device/realme/RE58C2/device.mk


PRODUCT_DEVICE := RE58C2
PRODUCT_NAME := lineage_RE58C2
PRODUCT_BRAND := realme
PRODUCT_MODEL := ums9230_hulk_Natv
PRODUCT_MANUFACTURER := realme

PRODUCT_GMS_CLIENTID_BASE := android-oppo

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="ums9230_hulk_Natv-user 13 TP1A.220624.014 1063 release-keys"

BUILD_FINGERPRINT := realme/RMX3760/RE58C2:13/TP1A.220624.014/T.R4T2.1720264765:user/release-keys
