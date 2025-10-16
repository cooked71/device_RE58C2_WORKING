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
    vendor/realme/RE58C2 \
    external/mesa3d


# ===========================
# BOOT PROPERTIES
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    # Critical boot properties
    ro.boot.selinux=permissive \
    ro.debuggable=1 \
    
    # Use vendor graphics stack
    ro.hardware.egl=mali \
    ro.hardware.vulkan=mali \
    ro.hardware.gpu=mali \
    ro.hardware.hwcomposer=unisoc \
    ro.hardware.gralloc=RE58C2 \
    
    # Use vendor boot stack
    ro.hardware.bootctrl=default \
    
    # Disable verification for initial boot
    ro.odsign.disabled=true \
    odsign.verification.disabled=true \
    ro.apex.updatable=false \
    
    # ADB
    persist.sys.usb.config=adb \
    ro.fastbootd.available=true

# ===========================
# ESSENTIAL VENDOR PACKAGES
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
# POWER & THERMAL SERVICES
# ===========================

# Power services
PRODUCT_PACKAGES += \
    vendor.unisoc.hardware.power-service \
    android.hardware.power.stats-service.example

# Thermal services
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.thermal@2.0-service \
    thermald

# Power HAL implementation
PRODUCT_PACKAGES += \
    power.default \
    power.sprd \
    vendor.unisoc.hardware.power-V1-ndk

# Thermal HAL implementation
PRODUCT_PACKAGES += \
    thermal.default \
    vendor.sprd.hardware.thermal@2.0 \
    vendor.sprd.hardware.thermal@2.0-impl

# ===========================
# VINTF MANIFEST FRAGMENTS
# ===========================

PRODUCT_PACKAGES += \
    vendor.sprd.hardware.thermal@2.0-service.xml \
    vendor-power-default.xml \
    power.stats-default.xml \
    android.hardware.thermal@2.0-service.xml

# ===========================
# RECOVERY CONFIGURATION
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
# DUAL CPIO - NORMAL BOOT (ramdisk.cpio)
# ===========================

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.module.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.module.rc \
    $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.RE58C2.rc \
    $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_hulk.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_hulk.rc \
    $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.module:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.module \
    $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.RE58C2:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.RE58C2 \
    $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_hulk:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_hulk

# ===========================
# DUAL CPIO - RECOVERY BOOT (recovery.cpio)
# ===========================

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recoveryx/recovery/init.recovery.common.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.common.rc \
    $(LOCAL_PATH)/recoveryx/recovery/init.recovery.ums9230_hulk.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.ums9230_hulk.rc \
    $(LOCAL_PATH)/recoveryx/recovery/ueventd.module.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.module.rc \
    $(LOCAL_PATH)/recoveryx/recovery/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.RE58C2.rc \
    $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_hulk.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_hulk.rc

# ===========================
# KERNEL MODULES
# ===========================

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.load:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.load \
    $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.load:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load

# ===========================
# A/B OTA CONFIGURATION
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
# INHERIT VENDOR FILES
# ===========================

$(call inherit-product, vendor/realme/RE58C2/RE58C2-vendor.mk)

# ===========================
# OVERRIDES
# ===========================

PRODUCT_ENFORCE_RRO_TARGETS := *