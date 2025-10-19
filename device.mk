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
# DEVICE-SPECIFIC CONFIGURATION v
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
# SELINUX POLICIES
# ===========================

# Include vendor sepolicy
# SELinux policy
BOARD_VENDOR_SEPOLICY_DIRS += \
    device/realme/RE58C2/sepolicy/vendor

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
   device/realme/RE58C2/sepolicy/private

# ===========================
# BOOT PROPERTIES v
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
    ro.hardware.keystore=trusty \
    ro.hardware.gatekeeper=trusty \
    ro.hardware.keymaster=trusty \
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
    installd \
    wificond \
    ylog

# CRITICAL: Missing libraries for boot services
#PRODUCT_PACKAGES += \
    libkeystore2_aaid \
    libkeystore2_apc_compat \
    libkeystore2_crypto \
    libkm_compat_service \
    lib_android_keymaster_keymint_utils \
    libcppbor_external \
    libwifi-system-iface \
    libwifi-hal

# UNCOMMENT: These should be active
# PRODUCT_PACKAGES += \
    android.hardware.cas@1.2-service 
   # vendor.sprd.hardware.lights-service 


# ===========================
# EXISTING SERVICES (KEEP THESE) v
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
    tee_rpc
    #android.hardware.gatekeeper@1.0-service.trusty

# ===========================
# REMOVE AOSP DUPLICATES - ADD THESE FILTERS
# ===========================

# Remove AOSP duplicates
PRODUCT_PACKAGES := $(filter-out keystore2,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out installd,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out wificond,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out odsign,$(PRODUCT_PACKAGES))

# ===========================
# POWER & THERMAL SERVICES (KEEP EXISTING) v 
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
# VINTF MANIFEST FRAGMENTS (KEEP EXISTING) v
# ===========================

#PRODUCT_PACKAGES += \
    vendor.sprd.hardware.thermal@2.0-service.xml \
    vendor-power-default.xml \
    power.stats-default.xml \
    vendor.sprd.hardware.thermal@2.0-service.xml \
    android.hardware.thermal@2.0-service.xml

# ===========================
# RECOVERY CONFIGURATION (KEEP EXISTING) v
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
# ADB & Fastboot Configuration v
# ===========================

# ADB Properties - REMOVED CONFLICTING PROPERTIES
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.usb.config=adb \
    sys.usb.controller=ffs-umc \
    sys.usb.configfs=1 \
    sys.usb.ffs.ready=1

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.usb.config=adb


# FastbootD support
PRODUCT_SYSTEM_PROPERTIES += \
    ro.fastbootd.available=true




# ===========================
# VNDK CONFIGURATION
# ===========================

# Acknowledge VNDK variant differences for light HAL
PRODUCT_PACKAGES += \
    android.hardware.light-V2-ndk.vendor

# VNDK properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.vndk.version=33 \
    ro.vndk.lite=false

# Disable VNDK enforcement for light HAL (temporary workaround)
PRODUCT_SYSTEM_PROPERTIES += \
    ro.vndk.version=33

# Add to VNDK exception list via product variables
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.vndk.version=33


# ===========================
# Files for NORMAL boot (ramdisk.cpio)
# ===========================

# ===========================
# VENDOR RAMDISK - COMPLETE SETUP
# ===========================

# Copy entire system folder with all files
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/realme/RE58C2/recoveryx/ramdisk/system,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system)


# Vendor HALs for normal boot
PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/ramdisk/system/lib64/vendor.sprd.hardware.boot@1.2.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system/lib64/vendor.sprd.hardware.boot@1.2.so \
      $(LOCAL_PATH)/recoveryx/ramdisk/system/lib64/vendor.sprd.hardware.production@1.0.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system/lib64/vendor.sprd.hardware.production@1.0.so \
      $(LOCAL_PATH)/recoveryx/ramdisk/system/lib64/hw/android.hardware.boot@1.0-impl-1.2.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system/lib64/hw/android.hardware.boot@1.0-impl-1.2.so \
      $(LOCAL_PATH)/recoveryx/ramdisk/system/lib64/hw/android.hardware.health@2.0-impl-default.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system/lib64/hw/android.hardware.health@2.0-impl-default.so

# Essential modules for normal boot
NORMAL_MODULES := $(wildcard   $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/*.ko)
PRODUCT_COPY_FILES += $(foreach file,$(NORMAL_MODULES),\
    $(file):$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/$(notdir $(file)))

PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.alias:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.alias \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.dep:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.dep \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.load:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.load \


# All ueventd files for ramdisk.cpio
PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.module.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.module.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.RE58C2.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.RMX3624.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.RMX3624.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_1h10.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_1h10.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_1h10_go.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_1h10_go.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_4h10.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_4h10.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_4h10_go.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_4h10_go.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_6h10.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_6h10.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_7h10.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_7h10.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_haps.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_haps.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_hulk.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_hulk.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_nico.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_nico.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.ums9230_zebu.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_zebu.rc

# All fstab files for first stage ramdisk
PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.module:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.module \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.RE58C2:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.RE58C2 \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.RMX3624:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.RMX3624 \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_1h10:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_1h10 \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_1h10_go:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_1h10_go \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_4h10:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_4h10 \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_4h10_go:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_4h10_go \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_6h10:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_6h10 \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_7h10:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_7h10 \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_haps:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_haps \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_hulk:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_hulk \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_nico:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_nico \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.ums9230_zebu:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_zebu

# ===========================
# Files for RECOVERY boot (recovery.cpio)
# ===========================
# Recovery init script

# Vendor HALs for recovery
PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/recovery/system/lib64/vendor.sprd.hardware.boot@1.2.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/vendor.sprd.hardware.boot@1.2.so \
      $(LOCAL_PATH)/recoveryx/recovery/system/lib64/vendor.sprd.hardware.production@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/vendor.sprd.hardware.production@1.0.so \
      $(LOCAL_PATH)/recoveryx/recovery/system/lib64/hw/android.hardware.boot@1.0-impl-1.2.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/hw/android.hardware.boot@1.0-impl-1.2.so \
      $(LOCAL_PATH)/recoveryx/recovery/system/lib64/hw/android.hardware.health@2.0-impl-default.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/hw/android.hardware.health@2.0-impl-default.so

# All modules for recovery
RECOVERY_MODULES := $(wildcard   $(LOCAL_PATH)/recoveryx/recovery/lib/modules/*.ko)
PRODUCT_COPY_FILES += $(foreach file,$(RECOVERY_MODULES),\
    $(file):$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/$(notdir $(file)))

PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.alias:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.alias \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.dep:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.dep \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.load:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.load.recovery:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load.recovery \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.module.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.module.rc

# Vendor HALs for recovery
PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/recovery/system/lib64/vendor.sprd.hardware.boot@1.2.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/vendor.sprd.hardware.boot@1.2.so \
      $(LOCAL_PATH)/recoveryx/recovery/system/lib64/vendor.sprd.hardware.production@1.0.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/vendor.sprd.hardware.production@1.0.so \
      $(LOCAL_PATH)/recoveryx/recovery/system/lib64/hw/android.hardware.boot@1.0-impl-1.2.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/hw/android.hardware.boot@1.0-impl-1.2.so \
      $(LOCAL_PATH)/recoveryx/recovery/system/lib64/hw/android.hardware.health@2.0-impl-default.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/hw/android.hardware.health@2.0-impl-default.so

# All modules for recovery
RECOVERY_MODULES := $(wildcard   $(LOCAL_PATH)/recoveryx/recovery/lib/modules/*.ko)
PRODUCT_COPY_FILES += $(foreach file,$(RECOVERY_MODULES),\
    $(file):$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/$(notdir $(file)))


PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/recovery/init.recovery.common.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.common.rc \
      $(LOCAL_PATH)/recoveryx/recovery/init.recovery.ums9230_hulk.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.ums9230_hulk.rc

# All ueventd files for recovery.cpio
PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.module.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.module.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.RE58C2.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.RMX3624.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.RMX3624.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_1h10.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_1h10.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_1h10_go.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_1h10_go.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_4h10.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_4h10.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_4h10_go.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_4h10_go.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_6h10.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_6h10.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_7h10.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_7h10.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_haps.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_haps.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_hulk.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_hulk.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_nico.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_nico.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.ums9230_zebu.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_zebu.rc



# ===========================
# ADDITIONAL VENDOR SERVICES (KEEP EXISTING)
# ===========================

PRODUCT_PACKAGES += \
    vendor.sprd.hardware.connmgr@1.0-service \
    vendor.sprd.hardware.wcn@1.0-service \
    vendor.sprd.hardware.trusty-service \
    android.hardware.bluetooth@1.1-service.unisoc \
    hostapd \
    wpa_supplicant \
    sensors.unisoc  
    #android.hardware.wifi@1.0-service \


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

# ==================================================
# UNISOC-SPECIFIC CONFIGURATION nuovo
#  ==================================================
# ===========================
# SYSTEM SERVICES FROM STOCK
# ===========================

# Use LineageOS libkeystore2, stock credstore
PRODUCT_PACKAGES += \
    credstore


# Use stock system binaries (NOT vendor)
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/bin/credstore:$(TARGET_COPY_OUT_SYSTEM)/bin/credstore \
    vendor/realme/RE58C2/proprietary/system/bin/keystore2:$(TARGET_COPY_OUT_SYSTEM)/bin/keystore2 \
    vendor/realme/RE58C2/proprietary/system/bin/installd:$(TARGET_COPY_OUT_SYSTEM)/bin/installd \
    vendor/realme/RE58C2/proprietary/system/bin/odsign:$(TARGET_COPY_OUT_SYSTEM)/bin/odsign \
    vendor/realme/RE58C2/proprietary/system/bin/wificond:$(TARGET_COPY_OUT_SYSTEM)/bin/wificond

# Remove from PRODUCT_PACKAGES to avoid conflicts
PRODUCT_PACKAGES := $(filter-out credstore keystore2 installd odsign wificond,$(PRODUCT_PACKAGES))

# Add to your BOOT PROPERTIES section:
PRODUCT_SYSTEM_PROPERTIES += \
    # Graphics fixes
    ro.hardware.egl=mali \
    ro.board.platform=ums9230 \
    # Service timeouts
    init.svc.surfaceflinger.timeout=60000 \
    # Temporary workarounds
    config.disable_keymint=true

# ===========================
# CRITICAL FIXES FOR UNISOC BOOT
# ===========================

# SELinux contexts for vendor services
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sepolicy/vendor_service_contexts:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/vendor_service_contexts

# Create missing directories
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilts/init.create_dirs.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.create_dirs.rc

# Stock system services
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/bin/credstore:$(TARGET_COPY_OUT_SYSTEM)/bin/credstore \
    vendor/realme/RE58C2/proprietary/system/bin/keystore2:$(TARGET_COPY_OUT_SYSTEM)/bin/keystore2

