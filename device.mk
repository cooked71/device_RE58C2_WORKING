#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Kernel
PRODUCT_ENABLE_UFFD_GC := false

PRODUCT_SHIPPING_API_LEVEL := 33
#TARGET_PRODUCT_SHIPPING_API_LEVEL := 33
PRODUCT_ENFORCE_VINTF_MANIFEST := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_CHARACTERISTICS := default


SOONG_CONFIG_NAMESPACES += realme_RE58C2
SOONG_CONFIG_realme_RE58C2 += use_vendor_bp
SOONG_CONFIG_realme_RE58C2_use_vendor_bp := true

PRODUCT_SOONG_NAMESPACES += external/mesa3d

# ===========================
# Graphics - Remove AOSP conflicts
# ===========================

# Remove AOSP graphics packages that conflict with vendor prebuilts
PRODUCT_PACKAGES := $(filter-out gralloc.default,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out libGLES_mesa,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out android.hardware.graphics.allocator@2.0-service,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out android.hardware.graphics.mapper@2.0-impl,$(PRODUCT_PACKAGES))

# Set Mali as default GPU

PRODUCT_SYSTEM_PROPERTIES += \
    ro.hardware.egl=mali \
    ro.hardware.vulkan=mali \
    ro.hardware.gpu=mali \
    ro.hardware.gralloc=re58c2 \
    ro.hardware.hwcomposer=unisoc \
    persist.graphics.egl=libGLES_mali.so


# Prevent AOSP gralloc from building
#BOARD_NO_GRALLOC := true
#BOARD_USES_VENDOR_GRALLOC := true

# Hardware-specific manifests
#HARDWARE_MANIFESTS := \
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
    android.hardware.wifi.hostapd \
    android.hardware.wifi.supplicant \
    android.hardware.wifi@1.0-service \
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

#DEVICE_MANIFEST_FILES += $(foreach manifest,$(HARDWARE_MANIFESTS),\
   vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/$(manifest).xml)


# ===========================
# Recovery configuration
# ===========================

# recovery.fstab → recovery ramdisk (vendor_boot)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/etc/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/etc/recovery.fstab

# init.recovery.mount.rc → root of recovery ramdisk
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.mount.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mount.rc



# =============================================================================
# Boot HAL Configuration for RE58C2
# =============================================================================

# ===== Boot HAL packages =====
#PRODUCT_PACKAGES += \
#    android.hardware.boot@1.2-impl \
#    android.hardware.boot@1.2-impl.recovery \
#    android.hardware.boot@1.2-service \
#    bootctrl.default \
#    unisoc.bootctrl \

PROPRIETARY_PATH := vendor/realme/RE58C2/proprietary



# ===== VINTF MANIFEST CONFIGURATION =====
#DEVICE_MANIFEST_FILE += device/realme/RE58C2/manifest_boot.xml

# ===== BUILD PROPERTIES =====
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.bootctrl=android.hardware.boot@1.2-impl


# System properties to match assertion

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/product/etc/fstab.postinstall:$(TARGET_COPY_OUT_PRODUCT)/etc/fstab.postinstall \
    $(LOCAL_PATH)/product/etc/fstab.postinstall:recovery/root/product/etc/fstab.postinstall

PRODUCT_COPY_FILES += \
     $(LOCAL_PATH)/stuff/rcfiles/init.recovery.metadata.rc:recovery/root/init.recovery.metadata.rc

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier


# Recovery tools
PRODUCT_PACKAGES += \
    adbd.recovery \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd \
    linker.recovery \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    shell_and_utilities_recovery \
    tune2fs.vendor_ramdisk

#==================================================
# SELinux Policy (ABSOLUTELY CRITICAL)
#PRODUCT_PACKAGES += \
    plat_sepolicy_vers.txt.vendor \
    vendor_file_contexts.vendor \
    vendor_hwservice_contexts.vendor \
    vendor_property_contexts.vendor \
    vendor_service_contexts.vendor \
    vendor_sepolicy.cil.vendor \
    vndservice_contexts.vendor

# Essential HAL Services
#PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service \
    android.hardware.gatekeeper@1.0-service.trusty \
    android.hardware.graphics.composer@2.4-service \
    android.hardware.health-service.example \
    android.hardware.security.keymint@2.0-unisoc.service.trusty \
    vendor.unisoc.hardware.power-service

# Keymint Shared Libraries
#PRODUCT_PACKAGES += \
    android.hardware.security.keymint-V1-ndk.realme \
    lib_android_keymaster_keymint_utils \
    libkeymaster_messages \
    libkeymaster_portable \
    libkeymint \
    libpuresoftkeymasterdevice

# Graphics Libraries (For Splash Screen)
PRODUCT_PACKAGES += \
    hwcomposer.unisoc \
    libGLES_mali

# Power Management
#PRODUCT_PACKAGES += \
    power.default \
    power.sprd \
    vendor.unisoc.hardware.power-V1-ndk

# Boot Components
#PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl

# Init Scripts
#PRODUCT_PACKAGES += \
    init_RE58C2 \
    init_ram

# VINTF Manifests
#PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.trusty.manifest \
    android.hardware.health-service.example.manifest \
    android.hardware.security.keymint.manifest \
    manifest_vendor.unisoc.power \
    vendor-power-default.manifest

# Gralloc (Graphics Memory Allocation)
#PRODUCT_PACKAGES += \
    gralloc.default \
    gralloc_config \
    libgralloctypes

# Gatekeeper Library
#PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0

#=================================================

# Update engine
PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
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

# Device libraries (install on Android device)
PRODUCT_PACKAGES += \
    dmctl 

PRODUCT_RECOVERY_PACKAGES += \
    dmctl




# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := default

# Rootdir scripts
ROOTDIR_SCRIPTS := \
    create_splloader_dual_slot_byname_path.sh \
    engineer_vendor_shell.sh \
    idlefast.sh \
    init.insmod.sh \
    loading.sh \
    log_to_csv.sh \
    para.sh \
    total.sh \
    zramwb.sh

PRODUCT_PACKAGES += $(ROOTDIR_SCRIPTS)

# NFC packages
# NFC_PACKAGES := \
#    librpmbclient \
#    libsecrpmbdata \
#    libteeproduction \
#    vendor.nxp.eventprocessor@1.0 \
#    vendor.nxp.nxpnfclegacy@1.0

PRODUCT_PACKAGES += $(NFC_PACKAGES)

# Init scripts
INIT_RC_FILES := \
    init.RMX3624.rc \
    init.RMX3624.usb.rc \
    init.RE58C2.rc \
    init.RE58C2.usb.rc \
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
    init.zramwb.rc

PRODUCT_PACKAGES += $(INIT_RC_FILES)

# Device tree blobs
#PRODUCT_PREBUILT_DTBO_IMAGE := $(TARGET_PREBUILT_DTBO)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilts/dtb.img:$(TARGET_COPY_OUT)/dtb.img

# PRODUCT_COPY_FILES += \
#    $(LOCAL_PATH)/prebuilts/dtbo.img:dtbo.img

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_4h10:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.ums9230_4h10

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    device/realme/RE58C2 \
    vendor/realme/RE58C2



# =============================================
# ESSENTIAL VENDOR RAMDISK FILES
# =============================================

# Ueventd rules - CRITICAL for hardware initialization
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor_boot_ramdisk/ueventd.ums9230_zebu.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_zebu.rc \
    $(LOCAL_PATH)/vendor_boot_ramdisk/ueventd.module.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.module.rc \
    $(LOCAL_PATH)/vendor_boot_ramdisk/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.RE58C2.rc \
    $(LOCAL_PATH)/vendor_boot_ramdisk/ueventd.ums9230_hulk.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.ums9230_hulk.rc

# First-stage ramdisk - CRITICAL for dynamic partitions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/fstab.ums9230_hulk:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.ums9230_hulk \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/fstab.RE58C2:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.RE58C2 \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/fstab.module:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.module

# First-stage binaries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/bin/linker64:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/bin/linker64 \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/bin/snapuserd:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/bin/snapuserd \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/bin/fsck.f2fs:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/bin/fsck.f2fs

# First-stage libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/lib64/ld-android.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/lib64/ld-android.so \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/lib64/libbase.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/lib64/libbase.so \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/lib64/libc.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/lib64/libc.so \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/lib64/libdl.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/lib64/libdl.so \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/lib64/liblog.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/lib64/liblog.so \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/lib64/libm.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/lib64/libm.so \
    $(LOCAL_PATH)/vendor_boot_ramdisk/first_stage_ramdisk/system/lib64/libz.so:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/system/lib64/libz.so

# Kernel module metadata - CRITICAL for module loading
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor_boot_ramdisk/lib/modules/modules.alias:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.alias \
    $(LOCAL_PATH)/vendor_boot_ramdisk/lib/modules/modules.dep:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.dep \
    $(LOCAL_PATH)/vendor_boot_ramdisk/lib/modules/modules.load:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.load \
    $(LOCAL_PATH)/vendor_boot_ramdisk/lib/modules/modules.load.recovery:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.load.recovery

# SELinux contexts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor_boot_ramdisk/plat_file_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/plat_file_contexts \
    $(LOCAL_PATH)/vendor_boot_ramdisk/vendor_file_contexts:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor_file_contexts \
    $(LOCAL_PATH)/vendor_boot_ramdisk/sepolicy:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/sepolicy

# Property file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor_boot_ramdisk/prop.default:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/prop.default




# Platform-specific configurations
ifneq ($(TARGET_BOARD_PLATFORM),)
PRODUCT_PLATFORM := ums9230
endif

# Recovery modules
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/stuff/modules,$(TARGET_COPY_OUT_VENDOR_RECOVERY)/root/lib/modules) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/vendor_boot_ramdisk/lib/modules/,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules)

# Inherit the proprietary files
$(call inherit-product, vendor/realme/RE58C2/RE58C2-vendor.mk)


# ---------------------------------------------
# ✅ ADD CORE AOSP/LINEAGE APPS FOR A FULL SYSTEM
# ---------------------------------------------

PRODUCT_PACKAGES += \
    Browser2 \
    Calendar \
    Contacts \
    DocumentsUI \
    Gallery2 \
    Launcher3QuickStep \
    LatinIME \
    Music \
    MmsService \
    Settings \
    SettingsIntelligence \
    SystemUI \
    TeleService \
    Updater

# offending packages
#PRODUCT_PACKAGES += \
    Calculator \
    Messaging \
    Phone \
    Terminal \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.thermal@2.0-service \
    bootctrl \
    bootctrl.recovery \
    bootctrl.ums9230 \
    manifest_dualsim.xml \
    manifest_media_c2_V1_1_unisoc.xml \
    manifest_oplus_performance.xml \
    vendor.sprd.hardware.boot@1.2-impl \
    vendor.sprd.hardware.boot@1.2-impl.recovery \
    vendor.sprd.hardware.thermal@2.0-service
