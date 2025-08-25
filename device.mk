#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Kernel
PRODUCT_ENABLE_UFFD_GC := false

# Compatibility matrices
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE := \
    device/realme/RE58C2/product/compatibility_matrix.xml

DEVICE_VENDOR_COMPATIBILITY_MATRIX_FILE := \
    device/realme/RE58C2/compatibility_matrix.device.xml

# Manifest files
DEVICE_MANIFEST_FILES := \
    device/realme/RE58C2/manifest.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest.xml

# VINTF manifests from vendor
PRODUCT_ENFORCE_VINTF_MANIFEST_OVERRIDE := true
PRODUCT_PACKAGES += \
    manifest_oplus_performance.xml \
    manifest_dualsim.xml \
    manifest_media_c2_V1_1_unisoc.xml

# Hardware-specific manifests
HARDWARE_MANIFESTS := \
    ai_engine-default \
    android.hardware.biometrics.fingerprint@2.1-service \
    android.hardware.cas@1.2-service \
    android.hardware.drm-service.clearkey \
    android.hardware.gatekeeper@1.0-service.trusty \
    android.hardware.health-service.example \
    android.hardware.security.keymint@2.0-unisoc.service.trusty \
    android.hardware.sensors-multihal \
    android.hardware.thermal@2.0-service \
    android.hardware.usb-service.example \
    android.hardware.wifi@1.0-service \
    android.hardware.wifi.hostapd \
    android.hardware.wifi.supplicant \
    bluetooth_audio \
    cplog_svc-default \
    face-default \
    hdcp-default \
    lights \
    memtrack \
    network-default \
    power.stats-default \
    rebootescrow-default \
    soter_default \
    trusty-default \
    tui-default \
    vendor-fingerprintmmi-default \
    vendor-log-default \
    vendor-oemlock-default \
    vendor-power-default \
    vendor.sprd.hardware.boot@1.2 \
    vendor.sprd.hardware.commondcs@1.0-service \
    vendor.sprd.hardware.gnss@2.2-service \
    vendor.sprd.hardware.thermal@2.0-service \
    vibrator

DEVICE_MANIFEST_FILES += $(foreach manifest,$(HARDWARE_MANIFESTS),\
   vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/$(manifest).xml)


# ===========================
# Recovery configuration
# ===========================

# recovery.fstab → recovery ramdisk (vendor_boot)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/etc/recovery.fstab

# init.recovery.mount.rc → root of recovery ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.mount.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mount.rc



# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    vendor.sprd.hardware.boot@1.2-impl \
    vendor.sprd.hardware.boot@1.2-impl.recovery \
    bootctrl \
    bootctrl.recovery \
    bootctrl.ums9230

# Recovery tools
PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    tune2fs.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    linker.recovery \
    shell_and_utilities_recovery \
    adbd.recovery \
    fastbootd \
    android.hardware.fastboot@1.0-impl-mock

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    checkpoint_gc \
    otapreopt_script

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

# API levels
PRODUCT_SHIPPING_API_LEVEL := 34

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Rootdir scripts
ROOTDIR_SCRIPTS := \
    log_to_csv.sh \
    loading.sh \
    para.sh \
    total.sh \
    create_splloader_dual_slot_byname_path.sh \
    engineer_vendor_shell.sh \
    idlefast.sh \
    init.insmod.sh \
    zramwb.sh

PRODUCT_PACKAGES += $(ROOTDIR_SCRIPTS)

# NFC packages
NFC_PACKAGES := \
    vendor.nxp.eventprocessor@1.0 \
    vendor.nxp.nxpnfclegacy@1.0 \
    librpmbclient \
    libteeproduction \
    libsecrpmbdata

PRODUCT_PACKAGES += $(NFC_PACKAGES)





# Init scripts
INIT_RC_FILES := \
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
    init.RE58C2.rc \
    init.RE58C2.usb.rc \
    init.ums9230_nico.rc \
    init.ums9230_nico.usb.rc \
    init.ums9230_zebu.rc \
    init.ums9230_zebu.usb.rc \
    init.zramwb.rc

PRODUCT_PACKAGES += $(INIT_RC_FILES)

# Device tree blobs
PRODUCT_PREBUILT_DTBO_IMAGE := $(TARGET_PREBUILT_DTBO)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilts/dtb.img:$(TARGET_COPY_OUT)/dtb.img \
    $(LOCAL_PATH)/prebuilts/dtbo.img:dtbo.img

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    vendor/realme/RE58C2




# Platform-specific configurations
ifneq ($(TARGET_BOARD_PLATFORM),)
PRODUCT_PLATFORM := ums9230
endif

# Recovery modules
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/stuff/modules,$(TARGET_COPY_OUT_VENDOR_RECOVERY)/root/lib/modules)

# Inherit the proprietary files
$(call inherit-product, vendor/realme/RE58C2/RE58C2-vendor.mk)

# ---------------------------------------------
# ✅ ADD CORE AOSP/LINEAGE APPS FOR A FULL SYSTEM
# ---------------------------------------------

PRODUCT_PACKAGES += \
    SystemUI \
    Settings \
    SettingsIntelligence \
    Launcher3QuickStep \
    DocumentsUI \
    TeleService \
    Phone \
    Contacts \
    MmsService \
    Messaging \
    Gallery2 \
    Calculator \
    Calendar \
    Music \
    Browser2 \
    Terminal \
    Updater \
    LatinIME
