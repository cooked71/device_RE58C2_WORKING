# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Dalvik VM Configuration
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Inherit virtual_ab_ota product
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Allow userspace reboots
$(call inherit-product, $(SRC_TARGET_DIR)/product/userspace_reboot.mk)

# =============================================
# DEVICE-SPECIFIC CONFIGURATION
# =============================================

PRODUCT_SHIPPING_API_LEVEL := 33
PRODUCT_ENFORCE_VINTF_MANIFEST := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_CHARACTERISTICS := default

# Soong Configuration
SOONG_CONFIG_NAMESPACES += realme_RE58C2
SOONG_CONFIG_realme_RE58C2 += use_vendor_bp
SOONG_CONFIG_realme_RE58C2_use_vendor_bp := true

PRODUCT_SOONG_NAMESPACES += \
    device/realme/RE58C2 \
    vendor/realme/RE58C2

# ===========================
# BOOT PROPERTIES
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    ro.boot.selinux=permissive \
    ro.debuggable=1 \
    ro.hardware.egl=mali \
    ro.hardware.vulkan=mali \
    ro.hardware.gpu=mali \
    ro.hardware.hwcomposer=unisoc \
    ro.hardware.gralloc=RE58C2 \
    ro.hardware.bootctrl=default \
    ro.odsign.disabled=true \
    odsign.verification.disabled=true \
    ro.apex.updatable=false \
    persist.sys.usb.config=adb \
    ro.fastbootd.available=true

# ===========================
# MISSING BOOT STACK SERVICES - ADD THESE
# ===========================

# CRITICAL: Boot services from stock boot log
PRODUCT_PACKAGES += \
    keystore2 \
    odsign \
    odrefresh \
    installd \
    wificond \
    ylog

# CRITICAL: Missing libraries for boot services
PRODUCT_PACKAGES += \
    libkeystore2_aaid \
    libkeystore2_apc_compat \
    libkeystore2_crypto \
    libkm_compat_service \
    lib_android_keymaster_keymint_utils \
    libcppbor_external \
    libwifi-system-iface \
    libwifi-hal

# UNCOMMENT: These should be active
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.lights-service \
    android.hardware.cas@1.2-service

# ===========================
# EXISTING SERVICES (KEEP THESE)
# ===========================

# Boot services
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.boot@1.2-service

# Graphics services
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.4-service \
    android.hardware.graphics.allocator@4.0-service \
    hwcomposer.unisoc \
    gralloc.RE58C2

# Audio services
PRODUCT_PACKAGES += \
    android.hardware.audio.service

# RIL services
PRODUCT_PACKAGES += \
    urild

# Core HAL services
PRODUCT_PACKAGES += \
    android.hardware.health-service.example \
    android.hardware.sensors-service.multihal \
    android.hardware.usb-service.example

# Power management
PRODUCT_PACKAGES += \
    vendor.unisoc.hardware.power-service

# Security services
PRODUCT_PACKAGES += \
    android.hardware.security.keymint@2.0-unisoc.service.trusty \
    android.hardware.gatekeeper@1.0-service.trusty

# ===========================
# REMOVE AOSP DUPLICATES - ADD THESE FILTERS
# ===========================

PRODUCT_PACKAGES := $(filter-out vold,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out netd,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out surfaceflinger,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out keystore2,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out installd,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out wificond,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out odsign,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out odrefresh,$(PRODUCT_PACKAGES))

# ===========================
# POWER & THERMAL SERVICES (KEEP EXISTING)
# ===========================

PRODUCT_PACKAGES += \
    android.hardware.power.stats-service.example \
    vendor.sprd.hardware.thermal@2.0-service \
    thermald \
    power.default \
    power.sprd \
    vendor.unisoc.hardware.power-V1-ndk \
    thermal.default \
    vendor.sprd.hardware.thermal@2.0 \
    vendor.sprd.hardware.thermal@2.0-impl

# ===========================
# VINTF MANIFEST FRAGMENTS (KEEP EXISTING)
# ===========================

PRODUCT_PACKAGES += \
    vendor.sprd.hardware.thermal@2.0-service.xml \
    vendor-power-default.xml \
    power.stats-default.xml \
    android.hardware.thermal@2.0-service.xml

# ===========================
# RECOVERY CONFIGURATION (KEEP EXISTING)
# ===========================

PRODUCT_PACKAGES += \
    adbd.recovery \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    shell_and_utilities_vendor_ramdisk \
    tune2fs.vendor_ramdisk

# ===========================
# ADDITIONAL VENDOR SERVICES (KEEP EXISTING)
# ===========================

PRODUCT_PACKAGES += \
    vendor.sprd.hardware.connmgr@1.0-service \
    vendor.sprd.hardware.wcn@1.0-service \
    vendor.sprd.hardware.trusty-service \
    android.hardware.bluetooth@1.1-service.unisoc \
    android.hardware.wifi@1.0-service \
    hostapd \
    wpa_supplicant \
    sensors.unisoc

# ===========================
# A/B OTA CONFIGURATION (KEEP EXISTING)
# ===========================

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    otapreopt_script \
    checkpoint_gc

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    POSTINSTALL_OPTIONAL_vendor=true

# ===========================
# UNISOC Framework (KEEP EXISTING)
# ===========================

PRODUCT_PACKAGES += \
    unisoc_overlay_frameworks_res

# ===========================
# INHERIT VENDOR FILES (KEEP EXISTING)
# ===========================

$(call inherit-product, vendor/realme/RE58C2/RE58C2-vendor.mk)


# ===========================
# VOLD STOCK AND DEPS
# ===========================


#PRODUCT_PACKAGES += \
    vold \
    vold_prepare_subdirs \
    libunisocvold \
    libphoenix_native \
    android.hardware.health.storage@1.0 \
    android.hardware.health.storage-V1-ndk

# Skip all BP complexity, just copy files directly
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/bin/vold:system/bin/vold \
    vendor/realme/RE58C2/proprietary/etc/init/vold.rc:system/etc/init/vold.rc \
    vendor/realme/RE58C2/proprietary/bin/vold_prepare_subdirs:system/bin/vold_prepare_subdirs \
    vendor/realme/RE58C2/proprietary/system_ext/lib64/libunisocvold.so:system_ext/lib64/libunisocvold.so \
    vendor/realme/RE58C2/proprietary/system_ext/lib64/libphoenix_native.so:system_ext/lib64/libphoenix_native.so \
    vendor/realme/RE58C2/proprietary/system_ext/lib/libphoenix_native.so:system_ext/lib/libphoenix_native.so

PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/lib64/android.hardware.health.storage@1.0.so:system/lib64/android.hardware.health.storage@1.0.so \
    vendor/realme/RE58C2/proprietary/system/lib64/android.hardware.health.storage-V1-ndk.so:system/lib64/android.hardware.health.storage-V1-ndk.so 


# Make sure AOSP doesn't build vold
PRODUCT_PACKAGES := $(filter-out vold vold_prepare_subdirs libvold, $(PRODUCT_PACKAGES))




# =============================================
# UNISOC Framework Files - Direct copy (no signing needed)
# =============================================

PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system_ext/framework/unisoc-framework.jar:$(TARGET_COPY_OUT_SYSTEM_EXT)/framework/unisoc-framework.jar \
    vendor/realme/RE58C2/proprietary/system_ext/framework/unipnp-framework.jar:$(TARGET_COPY_OUT_SYSTEM_EXT)/framework/unipnp-framework.jar \

PRODUCT_PACKAGES += \
    unisoc_overlay_frameworks_res

# In vendor.mk - copy preoptimized dex files
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unisoc-framework.oat:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unisoc-framework.oat \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unisoc-framework.vdex:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unisoc-framework.vdex \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unisoc-framework.art:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unisoc-framework.art \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unipnp-framework.oat:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unipnp-framework.oat \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unipnp-framework.vdex:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unipnp-framework.vdex \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unipnp-framework.art:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unipnp-framework.art

# For 32-bit if needed
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/framework/arm/boot-unisoc-framework.oat:$(TARGET_COPY_OUT_SYSTEM)/framework/arm/boot-unisoc-framework.oat \
    vendor/realme/RE58C2/proprietary/system/framework/arm/boot-unisoc-framework.vdex:$(TARGET_COPY_OUT_SYSTEM)/framework/arm/boot-unisoc-framework.vdex \
    vendor/realme/RE58C2/proprietary/system/framework/arm/boot-unisoc-framework.art:$(TARGET_COPY_OUT_SYSTEM)/framework/arm/boot-unisoc-framework.art \
    vendor/realme/RE58C2/proprietary/system/framework/arm/boot-unipnp-framework.oat:$(TARGET_COPY_OUT_SYSTEM)/framework/arm/boot-unipnp-framework.oat \
    vendor/realme/RE58C2/proprietary/system/framework/arm/boot-unipnp-framework.vdex:$(TARGET_COPY_OUT_SYSTEM)/framework/arm/boot-unipnp-framework.vdex \
    vendor/realme/RE58C2/proprietary/system/framework/arm/boot-unipnp-framework.art:$(TARGET_COPY_OUT_SYSTEM)/framework/arm/boot-unipnp-framework.art

# ===========================
# OVERRIDES
# ===========================

PRODUCT_ENFORCE_RRO_TARGETS := *
