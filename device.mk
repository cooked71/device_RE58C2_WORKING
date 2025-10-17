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
# filters
# =============================================

# FIRST: Filter out LineageOS packages we're replacing




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
# Recovery Configuration - MULTI-DEVICE DUAL CPIO
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
# ADB & Fastboot Configuration
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

# Recovery fstab
#PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/recoveryx/recovery/etc/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/etc/recovery.fstab

# ===========================
# Kernel modules - SEPARATE for normal vs recovery
# ===========================

# Modules for NORMAL boot (ramdisk.cpio)
#PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard   $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/*.ko),\
    $(file):$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/$(notdir $(file))) \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.alias:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.alias \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.dep:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.dep \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.load:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.load

# Modules for RECOVERY boot (recovery.cpio)
#PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard   $(LOCAL_PATH)/recoveryx/recovery/lib/modules/*.ko),\
    $(file):$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/$(notdir $(file))) \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.alias:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.alias \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.dep:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.dep \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.load:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.load.recovery:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load.recovery

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
# CRITICAL FIRMWARE FILES
# ===========================

# GPU/Display Firmware (MOST CRITICAL)
#PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/firmware/libGLES_mali.so:$(TARGET_COPY_OUT_VENDOR)/firmware/libGLES_mali.so

# WiFi/BT Regulatory Database
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/firmware/regulatory.db:$(TARGET_COPY_OUT_VENDOR)/firmware/regulatory.db \
    vendor/realme/RE58C2/proprietary/vendor/firmware/regulatory.db.p7s:$(TARGET_COPY_OUT_VENDOR)/firmware/regulatory.db.p7s

# Baseband/Modem Firmware
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/firmware/sipa.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/sipa.bin

# TrustZone/Security Firmware
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/firmware/faceid.elf:$(TARGET_COPY_OUT_VENDOR)/firmware/faceid.elf \
    vendor/realme/RE58C2/proprietary/vendor/firmware/soter.elf:$(TARGET_COPY_OUT_VENDOR)/firmware/soter.elf \
    vendor/realme/RE58C2/proprietary/vendor/firmware/hdcp.elf:$(TARGET_COPY_OUT_VENDOR)/firmware/hdcp.elf

# Touchscreen Firmware
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/firmware/chipone_firmware.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/chipone_firmware.bin \
    vendor/realme/RE58C2/proprietary/vendor/firmware/focaltech_ts_fw_.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/focaltech_ts_fw_.bin

# Essential Camera Firmware (at least config files)
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/firmware/ov50d40_shine/cfg.xml:$(TARGET_COPY_OUT_VENDOR)/firmware/ov50d40_shine/cfg.xml \
    vendor/realme/RE58C2/proprietary/vendor/firmware/ov8856_front_ly/cfg.xml:$(TARGET_COPY_OUT_VENDOR)/firmware/ov8856_front_ly/cfg.xml

# ===========================
# GPU LIBRARIES (CRITICAL)
# ===========================

# Mali GPU Libraries
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/lib/egl/libGLES_mali.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLES_mali.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/egl/libGLES_mali.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLES_mali.so

# OpenCL/Vulkan
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/lib/libOpenCL.so:$(TARGET_COPY_OUT_VENDOR)/lib/libOpenCL.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/libOpenCL.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libOpenCL.so

# ===========================
# MISSING VENDOR SERVICES
# ===========================

# Additional critical services
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.connmgr@1.0-service \
    vendor.sprd.hardware.wcn@1.0-service \
    vendor.sprd.hardware.trusty-service \
    android.hardware.bluetooth@1.1-service.unisoc \
    android.hardware.wifi@1.0-service \
    hostapd \
    wpa_supplicant

# Sensor services
PRODUCT_PACKAGES += \
    sensors.unisoc \
    android.hardware.sensors-service.multihal

# ===========================
# VENDOR CONFIGURATION FILES
# ===========================

# Audio configuration
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/etc/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml

# Media codecs
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/etc/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# SELinux policies
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/etc/selinux/vendor_sepolicy.cil:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/vendor_sepolicy.cil \
    vendor/realme/RE58C2/proprietary/vendor/etc/selinux/vendor_file_contexts:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/vendor_file_contexts

# ===========================
# INIT SCRIPTS
# ===========================

# Vendor init scripts
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/etc/init/hw/init.ums9230_hulk.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.ums9230_hulk.rc \
    vendor/realme/RE58C2/proprietary/vendor/etc/init/hw/init.ums9230_hulk.usb.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.ums9230_hulk.usb.rc \
    vendor/realme/RE58C2/proprietary/vendor/etc/init/android.hardware.graphics.composer@2.4-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.graphics.composer@2.4-service.rc

# ===========================
# PERMISSIONS
# ===========================

PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/etc/permissions/android.hardware.vulkan.version-1_3.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_3.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/permissions/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

# ===========================
# INHERIT VENDOR FILES
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
    vendor/realme/RE58C2/proprietary/system_ext/lib64/libunisocvold.so:system/system_ext/lib64/libunisocvold.so \
    vendor/realme/RE58C2/proprietary/system_ext/lib64/libphoenix_native.so:system/system_ext/lib64/libphoenix_native.so \
    vendor/realme/RE58C2/proprietary/system_ext/lib/libphoenix_native.so:system/system_ext/lib/libphoenix_native.so

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
