# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# ===========================
# ABSOLUTE MINIMAL CONFIGURATION
# ===========================

# Dalvik VM Configuration
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Essential for A/B updates
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Core product (add these)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)


PRODUCT_SHIPPING_API_LEVEL := 33
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Soong Configuration
SOONG_CONFIG_NAMESPACES += realme_RE58C2
SOONG_CONFIG_realme_RE58C2 += use_vendor_bp
SOONG_CONFIG_realme_RE58C2_use_vendor_bp := true

PRODUCT_SOONG_NAMESPACES += \
    device/realme/RE58C2 \
    vendor/realme/RE58C2 \


# disable usb temp for debug
# PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.sys.usb.config=adb \
    sys.usb.configfs=0 \
    ro.vendor.usb.use_configfs=0


# Enable root access
# PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0



# =============================================
# BOOT & A/B UPDATE PACKAGES
# =============================================
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

# =============================================
# HEALTH HAL
# =============================================
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health-service.example

# =============================================
# A/B UPDATE ENGINE
# =============================================
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    checkpoint_gc \
    otapreopt_script

# =============================================
# FASTBOOT
# =============================================
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd



# ===========================
# VINTF CONFIGURATION - MINIMAL
# ===========================
DEVICE_MANIFEST_FILE += device/realme/RE58C2/manifest.xml
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# KEEP ONLY WORKING MANIFESTS - REMOVE FAILING ONES
# 10-11-25 DEVICE_MANIFEST_FILE += \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.drm-service.clearkey.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi.hostapd.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi.supplicant.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/lights.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vibrator.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.gatekeeper@1.0-service.trusty.xml\
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.health-service.example.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor-power-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.security.keymint@2.0-unisoc.service.trusty.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor.sprd.hardware.boot@1.2.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.thermal@2.0-service.xml  


  #  vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.biometrics.fingerprint@2.1-service.xml \


# ===========================
# RECOVERY CONFIGURATION
# ===========================
PRODUCT_PACKAGES += \
    adbd.recovery \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# ===========================
# ADB & Fastboot Configuration
# ===========================
# PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.usb.config=adb \
    sys.usb.controller=ffs-umc \
    sys.usb.configfs=1 \
    sys.usb.ffs.ready=1



PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# ===========================
# VENDOR BLOBS
# ===========================
$(call inherit-product, vendor/realme/RE58C2/RE58C2-vendor.mk)

# ===========================
# DEVICE TREE BLOBS
# ===========================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilts/dtb.img:$(TARGET_COPY_OUT)/dtb.img

# ===========================
# PLATFORM CONFIGURATION
# ===========================
ifneq ($(TARGET_BOARD_PLATFORM),)
PRODUCT_PLATFORM := ums9230
endif


# ===========================
# TEMPORARY SELINUX PERMISSIVE
# ===========================
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
PRODUCT_PROPERTY_OVERRIDES += ro.boot.selinux=permissive


# Rootdir
PRODUCT_PACKAGES += \
    log_to_csv.sh \
    loading.sh \
    para.sh \
    total.sh \
    create_splloader_dual_slot_byname_path.sh \
    engineer_vendor_shell.sh \
    idlefast.sh \
    init.insmod.sh \
    zramwb.sh \

PRODUCT_PACKAGES += \
    fstab.ums9230_4h10 \
    init.RMX3624.rc \
    init.RMX3624.usb.rc \
    init.cali.rc \
    init.module.rc \
    init.module.usb.rc \
    init.ram.gms.rc \
    init.ram.native.rc \
    init.ram.rc \
    init.storage.rc \
    init.ums9230_1h10.rc \
    init.ums9230_1h10.usb.rc \
    init.ums9230_1h10_go.rc \
    init.ums9230_1h10_go.usb.rc \
    init.ums9230_4h10.rc \
    init.ums9230_4h10.usb.rc \
    init.ums9230_4h10_go.rc \
    init.ums9230_4h10_go.usb.rc \
    init.ums9230_6h10.rc \
    init.ums9230_6h10.usb.rc \
    init.ums9230_7h10.rc \
    init.ums9230_7h10.usb.rc \
    init.ums9230_haps.rc \
    init.ums9230_haps.usb.rc \
    init.ums9230_hulk.rc \
    init.ums9230_hulk.usb.rc \
    init.ums9230_nico.rc \
    init.ums9230_nico.usb.rc \
    init.ums9230_zebu.rc \
    init.ums9230_zebu.usb.rc \
    init.zramwb.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_hulk:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.ums9230_hulk
