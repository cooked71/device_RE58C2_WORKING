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
# Graphics Configuration
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    ro.hardware.egl=mali \
    ro.hardware.vulkan=mali \
    ro.hardware.gpu=mali \
    ro.hardware.gralloc=RE58C2 \
    ro.hardware.hwcomposer=unisoc

# ===========================
# Boot & SELinux Configuration
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    ro.boot.selinux=permissive \
    ro.build.selinux=0 \
    ro.fastbootd.available=true

# ===========================
# ADB Configuration
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.usb.config=adb

# ===========================
# Core Product Packages
# ===========================

# Essential HAL Services
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service \
    android.hardware.gatekeeper@1.0-service.trusty \
    android.hardware.health-service.example \
    vendor.unisoc.hardware.power-service \
    android.hardware.biometrics.fingerprint@2.1-service \
    android.hardware.cas@1.2-service \
    android.hardware.sensors-service.multihal \
    android.hardware.usb-service.example \
    android.hardware.audio.service \
    android.hardware.graphics.composer@2.4-service \
    android.hardware.graphics.allocator@4.0-service \
    android.hardware.security.keymint@2.0-unisoc.service.trusty

# Vendor Services
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.commondcs@1.0-service \
    vendor.sprd.hardware.gnss@2.2-service \
    vendor.sprd.hardware.biometrics.face-service \
    vendor.sprd.hardware.memtrack-service \
    vendor.sprd.hardware.vibrator-service

# Graphics
PRODUCT_PACKAGES += \
    libGLES_mali \
    hwcomposer.unisoc \
    gralloc.RE58C2

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.0-impl

# RIL
PRODUCT_PACKAGES += \
    urild \
    libril-private \
    libimpl-ril

# Thermal
PRODUCT_PACKAGES += \
    thermald \
    thermal.default \
    vendor.sprd.hardware.thermal@2.0-service

# ===========================
# Recovery Configuration
# ===========================

PRODUCT_PACKAGES += \
    adbd.recovery \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# ===========================
# A/B OTA Configuration
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

# ===========================
# Essential Stock Binaries
# ===========================

# Copy ONLY the critical stock binaries you need
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/bin/init:$(TARGET_COPY_OUT_SYSTEM)/bin/init \
    vendor/realme/RE58C2/proprietary/system/framework/services.jar:$(TARGET_COPY_OUT_SYSTEM)/framework/services.jar

# ===========================
# Boot Debugging
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    debug.sf.nobootanimation=0 \
    ro.surface_flinger.running_without_sync_framework=true \
    odsign.verification.disabled=true \
    ro.odsign.disabled=true

# ===========================
# Inherit Vendor Files
# ===========================

$(call inherit-product, vendor/realme/RE58C2/RE58C2-vendor.mk)