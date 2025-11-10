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
    external/mesa3d


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
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.usb.config=adb \
    sys.usb.controller=ffs-umc \
    sys.usb.configfs=1 \
    sys.usb.ffs.ready=1

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
# MAIN BOOT RAMDISK FILES - ALL DEVICES
# ===========================
# All init.rc files to ramdisk root
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_hulk.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/init.ums9230_hulk.rc \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_1h10.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.ums9230_1h10.rc \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_1h10_go.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.ums9230_1h10_go.rc \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_4h10.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.ums9230_4h10.rc \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_4h10_go.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.ums9230_4h10_go.rc \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_6h10.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.ums9230_6h10.rc \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_7h10.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.ums9230_7h10.rc \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_haps.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.ums9230_haps.rc \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_nico.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.ums9230_nico.rc \
    $(LOCAL_PATH)/rootdir/etc/init.ums9230_zebu.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.ums9230_zebu.rc \
    $(LOCAL_PATH)/rootdir/etc/init.RMX3624.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.RMX3624.rc \
    $(LOCAL_PATH)/rootdir/system/etc/init/hw/init.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.rc


# All fstab files to ramdisk root
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_hulk:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_hulk \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_1h10:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_1h10 \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_1h10_go:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_1h10_go \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_4h10:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_4h10 \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_4h10_go:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_4h10_go \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_6h10:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_6h10 \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_7h10:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_7h10 \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_haps:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_haps \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_nico:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_nico \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_zebu:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.ums9230_zebu \
    $(LOCAL_PATH)/rootdir/etc/fstab.RMX3624:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.RMX3624

# All ueventd files to ramdisk root
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_hulk.rc:root/ueventd.ums9230_hulk.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_1h10.rc:root/ueventd.ums9230_1h10.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_1h10_go.rc:root/ueventd.ums9230_1h10_go.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_4h10.rc:root/ueventd.ums9230_4h10.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_4h10_go.rc:root/ueventd.ums9230_4h10_go.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_6h10.rc:root/ueventd.ums9230_6h10.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_7h10.rc:root/ueventd.ums9230_7h10.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_haps.rc:root/ueventd.ums9230_haps.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_nico.rc:root/ueventd.ums9230_nico.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_zebu.rc:root/ueventd.ums9230_zebu.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.RMX3624.rc:root/ueventd.RMX3624.rc

# ===========================
# VENDOR FILES FOR MOUNT_ALL - ALL DEVICES
# ===========================
# Copy all fstab files to vendor/etc
PRODUCT_COPY_FILES += $(foreach file,$(wildcard $(LOCAL_PATH)/rootdir/etc/fstab.*),\
    $(file):$(TARGET_COPY_OUT_VENDOR)/etc/$(notdir $(file)))

# Copy all vendor init files
PRODUCT_COPY_FILES += $(foreach file,$(wildcard $(LOCAL_PATH)/rootdir/vendor/etc/init/hw/init.*.rc),\
    $(file):$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/$(notdir $(file)))

# ===========================
# COMMON/PLATFORM FILES
# ===========================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.module.rc:root/init.module.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.module.rc:root/ueventd.module.rc \
    $(LOCAL_PATH)/rootdir/etc/init.module.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.module.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.module.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc

# ===========================
# SYSTEM INIT FILES
# ===========================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/init/hw/init.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.rc \
    $(LOCAL_PATH)/rootdir/system/etc/init/hw/init.usb.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.usb.rc \
    $(LOCAL_PATH)/rootdir/system/etc/init/hw/init.usb.configfs.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.usb.configfs.rc \
    $(LOCAL_PATH)/rootdir/system/etc/init/hw/init.zygote32.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.zygote32.rc \
    $(LOCAL_PATH)/rootdir/system/etc/init/hw/init.zygote64_32.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.zygote64_32.rc

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


# ===========================
# MEDIA CONFIGURATION
# ===========================


# ===========================
# SELINUX POLICIES
# ===========================


# load custom init.rc
#PRODUCT_COPY_FILES += \
    device/realme/RE58C2/rootdir/system/etc/init/hw/init.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/hw/init.rc
