
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
    vendor/realme/RE58C2 \
    external/mesa3d

# ===========================
# SELINUX POLICIES
# ===========================

# Use stock file contexts
BOARD_VENDOR_SEPOLICY_DIRS += device/realme/RE58C2/sepolicy/vendor

# ===========================
# SURFACEFLINGER COMPATIBILITY FIXES - START WITH THIS
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    # SurfaceFlinger compatibility with vendor graphics
    ro.surface_flinger.has_HDR_display=false \
    ro.surface_flinger.has_wide_color_display=false \
    ro.surface_flinger.use_color_management=false \
    ro.surface_flinger.protected_contents=false \
    ro.surface_flinger.supports_background_blur=false \
    
    # Disable advanced features for compatibility
    ro.surface_flinger.set_idle_timer_ms=1000 \
    ro.surface_flinger.set_touch_timer_ms=200 \
    ro.surface_flinger.set_display_power_timer_ms=1000 \
    
    # Workarounds for vendor HWC
    debug.sf.disable_client_composition_cache=1 \
    debug.sf.enable_gl_backpressure=0 \
    debug.sf.predict_hwc_composition_strategy=0

# ===========================
# BOOT PROPERTIES v - FIXED
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    # SELinux & Debug
    ro.boot.selinux=permissive \
    ro.debuggable=1 \
    
    # Graphics - Mali GPU (Spreadtrum) - FIXED
    ro.hardware.egl=mali \
    ro.hardware.vulkan=mali \
    ro.hardware.gpu=mali \
    ro.hardware.hwcomposer=unisoc \
    ro.hardware.gralloc=default \
    ro.board.platform=ums9230 \
    
    # Security - REMOVED Trusty TEE properties
    ro.hardware.bootctrl=default \
    
    # Graphics Debug & Performance
    debug.sf.enable_gl_backpressure=1 \
    debug.sf.enable_hwc_vds=1 \
    debug.sf.hwc.canUseABC=0 \
    init.svc.surfaceflinger.timeout=60000 \
    
    # System Workarounds - KEEP THESE
    ro.odsign.disabled=true \
    odsign.verification.disabled=true \
    ro.apex.updatable=false \
    persist.sys.usb.config=adb \
    ro.fastbootd.available=true
    
# ===========================
# MISSING BOOT STACK SERVICES - ADD THESE
# ===========================

PRODUCT_PACKAGES += \
    keystore2  \
    odsign  \
    installd  \
    wificond  
    # ylog 

# Add Trusty service to packages (only if libraries exist)
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.trusty-V1-ndk  \
    vendor.sprd.hardware.trusty-impl  \
    libtrusty 


# ===========================
# EXISTING SERVICES (KEEP THESE) v - FIXED
# ===========================

PRODUCT_PACKAGES += \
    vendor.sprd.hardware.boot@1.2-service 

PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.4-service  \
    android.hardware.graphics.allocator@4.0-service  \
    hwcomposer.unisoc \
    gralloc.default

# ===========================
# FIX AUDIO SERVICES - USE CORRECT NAMES
# ===========================

PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.0-impl

# Copy audio service and init script
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/bin/hw/android.hardware.audio.service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.audio.service \
    vendor/realme/RE58C2/proprietary/vendor/etc/init/android.hardware.audio.service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.audio.service.rc

# Copy audio HALs
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/proprietary/vendor/lib/hw/audio.*,$(TARGET_COPY_OUT_VENDOR)/lib/hw) \
    $(call find-copy-subdir-files,*,vendor/proprietary/vendor/lib64/hw/audio.*,$(TARGET_COPY_OUT_VENDOR)/lib64/hw)

PRODUCT_SYSTEM_PROPERTIES += \
    # Use whale audio HAL (you have audio.primary.whale.so)
    ro.hardware.audio.primary=whale \
    ro.hardware.audio=whale \
    # Sprd audio configuration
    ro.audio.sprd=1 \
    vendor.audio.use.sw.aps=1


PRODUCT_PACKAGES += \
    urild 

PRODUCT_PACKAGES += \
    android.hardware.health-service.example  \
    android.hardware.sensors-service.multihal  \
    android.hardware.usb-service.example 

# Power management
PRODUCT_PACKAGES += \
    vendor.unisoc.hardware.power-service


PRODUCT_PACKAGES += \
    tee_rpc 

#android.hardware.security.keymint@2.0-unisoc.service.trusty  


# ===========================
# REMOVE AOSP DUPLICATES - ADD THESE FILTERS
# ===========================

# Remove AOSP duplicates
#PRODUCT_PACKAGES := $(filter-out keystore2,$(PRODUCT_PACKAGES))
#PRODUCT_PACKAGES := $(filter-out installd,$(PRODUCT_PACKAGES))
#PRODUCT_PACKAGES := $(filter-out wificond,$(PRODUCT_PACKAGES))
#PRODUCT_PACKAGES := $(filter-out odsign,$(PRODUCT_PACKAGES))

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

PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@4.0-impl-arm \
    libhwc2on1adapter \
    libhwc2onfbadapter \
    libmemion
    # Remove these if AOSP provides them:
    # libgralloctypes


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
    android.hardware.bluetooth@1.1-service.unisoc \
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
# VOLD - COMPLETE BP MODULES
# ===========================

PRODUCT_PACKAGES += \
    vold  \
    vold_prepare_subdirs  \
    android.hardware.health.storage@1.0  \
    libkeymint_support  \
    android.hardware.boot@1.0-impl-1.2  \
    android.hardware.boot@1.0 
    #android.hardware.health.storage-V1-ndk  
    #android.system.keystore2-V2-ndk
    #    libphoenix_native  \
    #    libunisocvold  \




# Remove AOSP vold to prevent conflicts
#PRODUCT_PACKAGES := $(filter-out vold, $(PRODUCT_PACKAGES))
#PRODUCT_PACKAGES := $(filter-out vold_prepare_subdirs, $(PRODUCT_PACKAGES))




# =============================================
# UNISOC Framework Files - Direct copy (no signing needed)
# =============================================

PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system_ext/framework/unisoc-framework.jar:$(TARGET_COPY_OUT_SYSTEM_EXT)/framework/unisoc-framework.jar \
    vendor/realme/RE58C2/proprietary/system_ext/framework/unipnp-framework.jar:$(TARGET_COPY_OUT_SYSTEM_EXT)/framework/unipnp-framework.jar \

PRODUCT_PACKAGES += \
    unisoc_overlay_frameworks_res

# In vendor.mk - copy preoptimized dex files
# PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unisoc-framework.oat:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unisoc-framework.oat \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unisoc-framework.vdex:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unisoc-framework.vdex \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unisoc-framework.art:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unisoc-framework.art \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unipnp-framework.oat:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unipnp-framework.oat \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unipnp-framework.vdex:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unipnp-framework.vdex \
    vendor/realme/RE58C2/proprietary/system/framework/arm64/boot-unipnp-framework.art:$(TARGET_COPY_OUT_SYSTEM)/framework/arm64/boot-unipnp-framework.art

# For 32-bit if needed
#PRODUCT_COPY_FILES += \
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
# ==================================================
# ===========================
# SYSTEM SERVICES FROM STOCK
# ===========================

# Use LineageOS libkeystore2, stock credstore
PRODUCT_PACKAGES += \
    credstore


# Use stock system binaries (NOT vendor)

# Remove from PRODUCT_PACKAGES to avoid conflicts


# ===========================
# CRITICAL FIXES FOR UNISOC BOOT
# ===========================


# Create missing directories
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilts/init.create_dirs.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.create_dirs.rc

PRODUCT_COPY_FILES += \

# ===========================
# MISSING SPRD SERVICES
# ===========================
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.lights-service \
    vendor.sprd.hardware.gnss@2.2-service \
    vendor.sprd.hardware.cplog_svc-service \
    vendor.sprd.hardware.enhance-service \
    vendor.sprd.hardware.hdcp-service \
    vendor.sprd.hardware.memtrack-service \
    vendor.sprd.hardware.network-service \
    vendor.sprd.hardware.oemlock-service \
    vendor.sprd.hardware.log-service \
    vendor.sprd.hardware.broadcastradio@2.0-service \
    vendor.sprd.hardware.commondcs@1.0-service \
    vendor.sprd.hardware.network@1.0-service \
    vendor.sprd.hardware.performance@1.0-service \
    vendor.sprd.hardware.vibrator-service \
    android.hardware.wifi@1.0-service \
    android.hardware.gatekeeper@1.0-service.trusty


# Only add these if prebuilt_etc isn't working
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.boot@1.2.xml \
    android.hardware.gatekeeper@1.0-service.trusty.xml \
    gralloc.xml \
    android.hardware.health-service.example.xml \
    media_codecs.xml \
    vendor-power-default.xml \
    power.stats-default.xml \
    vendor.sprd.hardware.thermal@2.0-service.xml \
    android.hardware.thermal@2.0-service.xml \
    trusty-default.xml 
   # android.hardware.security.keymint@2.0-unisoc.service.trusty.xml

PRODUCT_PACKAGES += \
    android.hardware.security.keymint-service




BASE_PATH := vendor/realme/RE58C2/proprietary/vendor/firmware
FIRMWARE_FILES := $(shell find $(BASE_PATH) -type f)
PRODUCT_COPY_FILES += $(foreach f, $(FIRMWARE_FILES), \
    $(f):$(TARGET_COPY_OUT_VENDOR)/firmware/$(subst $(BASE_PATH)/,,$(f)))

