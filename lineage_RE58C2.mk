#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# =============================================
# AOSP CORE INHERITANCE (WORKING PATTERN)
# =============================================
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# =============================================
# LINEAGEOS INHERITANCE
# =============================================
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# =============================================
# DEVICE INHERITANCE
# =============================================

# =============================================
# Super partition forcing
# =============================================

PRODUCT_BUILD_SUPER_PARTITION := true
OVERRIDE_TARGET_FLATTEN_APEX := true

# =============================================
# DEVICE IDENTIFICATION
# =============================================

PRODUCT_DEVICE := RE58C2
PRODUCT_NAME := lineage_RE58C2
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX3760
PRODUCT_MANUFACTURER := realme

# HARDWARE PLATFORM
TARGET_BOARD_PLATFORM := qogirl6
TARGET_BOOTLOADER_BOARD_NAME := ums9230_hulk

# GMS CONFIGURATION
PRODUCT_GMS_CLIENTID_BASE := android-oppo

# BUILD FINGERPRINT (CRITICAL FOR BOOT)
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="RMX3760-user 13 TP1A.220624.014 1063 release-keys"

BUILD_FINGERPRINT := realme/RMX3760/RE58C2:13/TP1A.220624.014/T.R4T2.1720264765:user/release-keys
