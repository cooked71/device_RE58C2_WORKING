    #
    # Copyright (C) 2025 The LineageOS Project
    #
    # SPDX-License-Identifier: Apache-2.0
    #

    # =============================================
    # INHERITANCE (MOST SPECIFIC FIRST)
    # =============================================

    # 1. Inherit from device FIRST (most specific)
    $(call inherit-product, device/realme/RE58C2/device.mk)

    # 2. Inherit core Android components
    $(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
    #$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

    # 3. Enable updating of APEXes
    $(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

    # 4. A/B partitioning
    $(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
    $(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

    # 5. Inherit common LineageOS configurations (LEAST specific)
    $(call inherit-product, vendor/lineage/config/common_full_phone.mk)

    # 1. Inherit from device FIRST (most specific)
    $(call inherit-product, device/realme/RE58C2/device.mk)


    # =============================================
    # Force super image generation despite LineageOS patch
    # =============================================

    PRODUCT_BUILD_SUPER_PARTITION := true
    OVERRIDE_TARGET_FLATTEN_APEX := true


    # =============================================
    # DEVICE-SPECIFIC PROPERTIES (MUST COME AFTER ALL INHERITANCE)
    # =============================================

    # PRODUCT IDENTIFICATION (DEFINE HERE ONLY - REMOVE FROM device.mk)
    PRODUCT_DEVICE := RE58C2
    PRODUCT_NAME := lineage_RE58C2
    PRODUCT_BRAND := realme
    PRODUCT_MODEL := RE58C2  # Changed from ums9230_hulk_Natv to RE58C2 for consistency
    PRODUCT_MANUFACTURER := realme

    # HARDWARE PLATFORM (DEFINE HERE ONLY - REMOVE FROM device.mk)
    TARGET_BOARD_PLATFORM := ums9230
    TARGET_BOOTLOADER_BOARD_NAME := ums9230_hulk

    # GMS CONFIGURATION
    PRODUCT_GMS_CLIENTID_BASE := android-oppo

    # BUILD FINGERPRINT (CRITICAL FOR BOOT - MUST MATCH EXACTLY)
    # PRODUCT_BUILD_PROP_OVERRIDES += \
        PRIVATE_BUILD_DESC="RE58C2-user 13 TP1A.220624.014 1063 release-keys"

    # BUILD_FINGERPRINT := realme/RMX3760/RE58C2:13/TP1A.220624.014/T.R4T2.1720264765:user/release-keys

    # =============================================
    # BUILD FINGERPRINT (CRITICAL FOR BOOT - MUST MATCH EXACTLY)
    # =============================================
    BUILD_FINGERPRINT := realme/RMX3760/RE58C2:13/TP1A.220624.014/T.R4T2.1720264765:user/release-keys
    PRIVATE_BUILD_DESC := RE58C2-user 13 TP1A.220624.014 1063 release-keys

    PRODUCT_BUILD_PROP_OVERRIDES += \
        PRIVATE_BUILD_DESC="$(PRIVATE_BUILD_DESC)" \
        BUILD_FINGERPRINT="$(BUILD_FINGERPRINT)"
