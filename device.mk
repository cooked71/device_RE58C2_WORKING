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

# Kernel
PRODUCT_ENABLE_UFFD_GC := false

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
    ro.hardware.gralloc=RE58C2 \
    ro.hardware.hwcomposer=unisoc \
    persist.graphics.egl=libGLES_mali.so

PRODUCT_SYSTEM_PROPERTIES += \
    ro.boot.selinux=permissive \
    ro.build.selinux=0


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

# USB init file
# PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recoveryx/recovery/init.recovery.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.usb.rc

# FastbootD support
PRODUCT_SYSTEM_PROPERTIES += \
    ro.fastbootd.available=true

# ===========================
# Files for NORMAL boot (ramdisk.cpio)
# ===========================

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
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard   $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/*.ko),\
    $(file):$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/$(notdir $(file))) \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.alias:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.alias \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.dep:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.dep \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.load:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.load

# Modules for RECOVERY boot (recovery.cpio)
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard   $(LOCAL_PATH)/recoveryx/recovery/lib/modules/*.ko),\
    $(file):$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/$(notdir $(file))) \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.alias:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.alias \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.dep:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.dep \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.load:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.load.recovery:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load.recovery

# ===========================
# NO CHARGER IMAGES - NOT AVAILABLE IN STOCK
# ===========================

## ===========================
# Core Product Packages (MUST MATCH Android.bp)
# ===========================

# Prebuilt APKs
PRODUCT_PACKAGES += \
    SoterService \
    ims

# Prebuilt JARs
PRODUCT_PACKAGES += \
    androidx.camera.extensions.impl

# FIXED: Removed malformed line
PRODUCT_PACKAGES += \
    libstagefright_hdcp

# HAL Services
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
    vendor.oppo.engnative.engineer@1.0-service \
    vendor.sprd.hardware.gnss@2.2-service \
    vendor.sprd.hardware.biometrics.face-service \
    vendor.sprd.hardware.memtrack-service \
    vendor.sprd.hardware.vibrator-service

# Additional Vendor Services
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.broadcastradio@2.0-service \
    vendor.sprd.hardware.fingerprintmmi-service \
    vendor.sprd.hardware.wcn@1.0-service \
    vendor.sprd.hardware.soter-service \
    vendor.sprd.hardware.cplog_svc-service \
    vendor.sprd.hardware.tui-service \
    vendor.sprd.hardware.oemlock-service \
    vendor.sprd.hardware.log-service \
    vendor.sprd.hardware.performance@1.0-service \
    vendor.sprd.hardware.enhance-service \
    vendor.sprd.hardware.connmgr@1.0-service \
    vendor.sprd.hardware.trusty-service \
    vendor.sprd.hardware.network-service \
    vendor.sprd.hardware.hdcp-service

# Shared Libraries (32/64-bit)
PRODUCT_PACKAGES += \
    libois_algorithm_jni \
    libstagefright_bufferpool@2.0.1 \
    libsprdaudiohalv7

# Vendor Interface Libraries
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.commondcs@1.0 \
    vendor.oppo.engnative.engineer@1.0 \
    vendor.sprd.hardware.gnss@1.0 \
    vendor.sprd.hardware.thermal@2.0 \
    vendor.sprd.hardware.face-V1-ndk

# Additional Vendor Libraries
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.boot@1.2 \
    vendor.sprd.hardware.performance@1.0 \
    vendor.sprd.hardware.connmgr@1.0 \
    vendor.sprd.hardware.network@1.0 \
    vendor.sprd.hardware.wcn@1.0 \
    vendor.sprd.hardware.trusty@1.0 \
    vendor.sprd.hardware.tui@1.0 \
    vendor.sprd.hardware.cplog_svc@1.0 \
    vendor.sprd.hardware.enhance-V1-ndk \
    vendor.sprd.hardware.soter-V1-ndk \
    vendor.sprd.hardware.trusty-V1-ndk \
    vendor.sprd.hardware.tui-V1-ndk \
    vendor.sprd.hardware.log-V1-ndk \
    vendor.sprd.hardware.cplog_svc-V2-ndk \
    vendor.sprd.hardware.hdcp-V1-ndk \
    vendor.sprd.hardware.fingerprintmmi-V1-ndk

# Security Libraries
PRODUCT_PACKAGES += \
    libsecrpmbdata \
    librpmbclient \
    libteeproduction

# Trusty Libraries
PRODUCT_PACKAGES += \
    libtrusty \
    libtrustyHalHelper

# NFC Libraries
PRODUCT_PACKAGES += \
    vendor.nxp.nxpnfclegacy@1.0 \
    vendor.nxp.eventprocessor@1.0

# Boot HAL Libraries
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    bootctrl.default \
    unisoc.bootctrl

# Power HAL Libraries
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0 \
    vendor.unisoc.hardware.power-V1-ndk \
    power.default \
    power.sprd

# Vendor-specific Support Libraries
PRODUCT_PACKAGES += \
    libmemion \
    libmediahdrtosdrtransform \
    libpowerhal_cli

# Graphics Libraries
PRODUCT_PACKAGES += \
    libGLES_mali \
    hwcomposer.unisoc \
    gralloc.RE58C2 \
    libremotedisplay

# Audio HAL Implementations
PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.0-impl

# RIL Components
PRODUCT_PACKAGES += \
    urild \
    libril-private \
    libimpl-ril \
    librilutils \
    librilcore \
    unisoc.rild.rc

# Thermal Services (FIXED: Remove duplicate impl)
    

# Complete thermal management stack
PRODUCT_PACKAGES += \
    thermald \
    thermal.default \
    thermal.conf \
    thermald.rc \
    android.hardware.thermal@2.0-service.xml \
    vendor.sprd.hardware.thermal@2.0-service \
    vendor.sprd.hardware.thermal@2.0 \
    vendor.sprd.hardware.thermal@2.0-impl



# HAL Implementations
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1-impl \
    vendor.sprd.hardware.gnss@1.0-impl \
    vendor.sprd.hardware.network@1.0-impl \
    vendor.sprd.hardware.wcn@1.0-impl \
    vendor.sprd.hardware.trusty-impl \
    vendor.sprd.hardware.connmgr@1.0-impl

# ===========================
# MISSING SYSTEM LIBRARIES (CRITICAL)
# ===========================

PRODUCT_PACKAGES += \
    libtinyxml2 \
    libsysutils \
    libnetutils \
    libhardware_legacy \
    libhidlmemory \
    libhwbinder \
    libion \
    libdrm \
    libsync \
    libgralloctypes \
    libdmabufheap \
    libnativewindow \
    libui \
    libgui \
    libmedia \
    libstagefright_foundation \
    libbinder \
    libxml2 \
    libcrypto \
    libdumpstateutil

# Configuration Files
PRODUCT_PACKAGES += \
    audio_policy_configuration \
    media_codecs \
    gralloc_configuration


PRODUCT_PACKAGES += \
    vendor-power-default.manifest

# Vendor DLKM Modules
PRODUCT_PACKAGES += \
    vendor_dlkm_modules_load \
    vendor_dlkm_modules_load_cali \
    vendor_dlkm_modules_load_charger \
    sprd_wlan_combo \
    sprd_thermal \
    mali_kbase

# Vendor DLKM Configuration
PRODUCT_PACKAGES += \
    vendor_dlkm_build_prop \
    vendor_dlkm_fs_config_dirs \
    vendor_dlkm_fs_config_files \
    init.realme.rc \
    init_vendor_dlkm \
    vendor_dlkm_file_contexts

# ===========================
# MISSING PACKAGES - ADDED TO FIX BUILD ERRORS
# ===========================


# Missing Broadcast Radio Libraries
PRODUCT_PACKAGES += \
    android.hardware.broadcastradio@2.0 \
    android.hardware.broadcastradio@1.0

# Missing CAS Libraries
PRODUCT_PACKAGES += \
    android.hardware.cas@1.2 \
    android.hardware.cas@1.1 \
    android.hardware.cas.native@1.0

# Missing Unisoc Radio Libraries (CRITICAL - these are causing build failures)
PRODUCT_PACKAGES += \
    vendor.unisoc.hardware.radio-V1-ndk \
    vendor.unisoc.hardware.radio.data-V1-ndk \
    vendor.unisoc.hardware.radio.sim-V1-ndk \
    vendor.unisoc.hardware.radio.network-V1-ndk \
    vendor.unisoc.hardware.radio.voice-V1-ndk \
    vendor.unisoc.hardware.radio.messaging-V1-ndk \
    vendor.unisoc.hardware.radio.modem-V1-ndk \
    vendor.unisoc.hardware.radio.ims-V1-ndk

# Missing AOSP Radio NDK Libraries (needed by librilcore)
PRODUCT_PACKAGES += \
    android.hardware.radio-V1-ndk \
    android.hardware.radio.modem-V1-ndk \
    android.hardware.radio.config-V1-ndk \
    android.hardware.radio.data-V1-ndk \
    android.hardware.radio.sim-V1-ndk \
    android.hardware.radio.network-V1-ndk \
    android.hardware.radio.voice-V1-ndk \
    android.hardware.radio.messaging-V1-ndk


# ===========================
# Boot HAL Configuration
# ===========================

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.bootctrl=android.hardware.boot@1.2-impl

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/product/etc/fstab.postinstall:$(TARGET_COPY_OUT_PRODUCT)/etc/fstab.postinstall 
#    $(LOCAL_PATH)/product/etc/fstab.postinstall:$(TARGET_COPY_OUT_RECOVERY)/product/etc/fstab.postinstall

# ===========================
# A/B OTA Configuration
# ===========================

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier \
    otapreopt_script \
    checkpoint_gc

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client


AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    POSTINSTALL_OPTIONAL_vendor=true



# ===========================
# Recovery Configuration
# ===========================

PRODUCT_PACKAGES += \
    adbd.recovery \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd \
    linker.recovery \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    shell_and_utilities_recovery \
    tune2fs.vendor_ramdisk

# Device libraries
PRODUCT_PACKAGES += \
    dmctl

PRODUCT_RECOVERY_PACKAGES += \
    dmctl

# ===========================
# SELinux Policy
# ===========================

PRODUCT_PACKAGES += \
    plat_sepolicy_vers.txt.vendor \
    vendor_file_contexts.vendor \
    vendor_hwservice_contexts.vendor \
    vendor_property_contexts.vendor \
    vendor_service_contexts.vendor \
    vendor_sepolicy.cil.vendor \
    vndservice_contexts.vendor

# ===========================
# Rootdir Scripts
# ===========================

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


# ===========================
# DUAL CPIO - Vendor Specific Files
# ===========================

# ---------------------------------
# Files for NORMAL boot (ramdisk.cpio)
# ---------------------------------

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
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.module.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.module.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.RE58C2:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.RE58C2

# ---------------------------------
# Files for RECOVERY boot (recovery.cpio)
# ---------------------------------

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
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.module.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.module.rc

# ===========================
# Device Tree Blobs
# ===========================

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilts/dtb.img:$(TARGET_COPY_OUT)/dtb.img

# ===========================
# Platform Configuration
# ===========================

ifneq ($(TARGET_BOARD_PLATFORM),)
PRODUCT_PLATFORM := ums9230
endif

# ===========================
# Loggers test
# ===========================

# Boot logging scripts
PRODUCT_COPY_FILES += \
    device/realme/RE58C2/scripts/early_kernel_log.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/early_kernel_log.sh \
    device/realme/RE58C2/scripts/boot_progress_log.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/boot_progress_log.sh \
    device/realme/RE58C2/scripts/migrate_early_logs.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/migrate_early_logs.sh \
    device/realme/RE58C2/scripts/continuous_kernel_log.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/continuous_kernel_log.sh

# Set executable permissions (append :755 for each)
PRODUCT_COPY_FILES += \
    device/realme/RE58C2/scripts/early_kernel_log.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/early_kernel_log.sh:755 \
    device/realme/RE58C2/scripts/boot_progress_log.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/boot_progress_log.sh:755 \
    device/realme/RE58C2/scripts/migrate_early_logs.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/migrate_early_logs.sh:755 \
    device/realme/RE58C2/scripts/continuous_kernel_log.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/continuous_kernel_log.sh:755



# =============================================
# DISABLE LINEAGEOS SECURITY STACK
# =============================================

# Remove ALL LineageOS security components
PRODUCT_PACKAGES := $(filter-out keystore2,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out keystore_cli_v2,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out android.hardware.security.keymint-service,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out android.hardware.security.keymint-service.remote,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out android.hardware.gatekeeper@1.0-service,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out gatekeeperd,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out odsign,$(PRODUCT_PACKAGES))
PRODUCT_PACKAGES := $(filter-out android.hardware.health-service.default,$(PRODUCT_PACKAGES))

# =============================================
# COPY STOCK SECURITY BINARIES (CRITICAL MISSING FILES)
# =============================================

PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/bin/odsign:$(TARGET_COPY_OUT_SYSTEM)/bin/odsign \
    vendor/realme/RE58C2/proprietary/system/etc/init/odsign.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/odsign.rc \
    vendor/realme/RE58C2/proprietary/system/bin/gatekeeperd:$(TARGET_COPY_OUT_SYSTEM)/bin/gatekeeperd \
    vendor/realme/RE58C2/proprietary/system/etc/init/gatekeeperd.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/gatekeeperd.rc \
    vendor/realme/RE58C2/proprietary/system/lib64/libfsverity.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libfsverity.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libcrypto_utils.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libcrypto_utils.so \
    vendor/realme/RE58C2/proprietary/system/lib64/liblogwrap.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/liblogwrap.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libprotobuf-cpp-lite.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libprotobuf-cpp-lite.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeyutils.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeyutils.so \
    vendor/realme/RE58C2/proprietary/system/lib64/android.hardware.security.secureclock-V1-ndk.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.hardware.security.secureclock-V1-ndk.so \
    vendor/realme/RE58C2/proprietary/system/lib64/android.hardware.security.sharedsecret-V1-ndk.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.hardware.security.sharedsecret-V1-ndk.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libbinder.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libbinder.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libbinder_ndk.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libbinder_ndk.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libgatekeeper.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libgatekeeper.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libgatekeeper_aidl.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libgatekeeper_aidl.so


# Stock system binaries for boot (ADD THESE)
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/bin/servicemanager:$(TARGET_COPY_OUT_SYSTEM)/bin/servicemanager \
    vendor/realme/RE58C2/proprietary/system/bin/hwservicemanager:$(TARGET_COPY_OUT_SYSTEM)/bin/hwservicemanager \
    vendor/realme/RE58C2/proprietary/system/bin/surfaceflinger:$(TARGET_COPY_OUT_SYSTEM)/bin/surfaceflinger \
    vendor/realme/RE58C2/proprietary/system/bin/bootanimation:$(TARGET_COPY_OUT_SYSTEM)/bin/bootanimation \
    vendor/realme/RE58C2/proprietary/system/bin/system_server:$(TARGET_COPY_OUT_SYSTEM)/bin/system_server

# Stock framework (MOST IMPORTANT - FIXES 74s TIMEOUT)
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/framework/services.jar:$(TARGET_COPY_OUT_SYSTEM)/framework/services.jar

# Stock init scripts (FIX SERVICE DEPENDENCIES)
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/etc/init/surfaceflinger.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/surfaceflinger.rc \
    vendor/realme/RE58C2/proprietary/system/etc/init/bootanim.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/bootanim.rc


# =============================================
# DISABLE VERIFICATION FOR INITIAL BOOT
# =============================================

PRODUCT_SYSTEM_PROPERTIES += \
    # Disable odsign verification temporarily
    odsign.verification.disabled=true \
    ro.odsign.disabled=true \
    
    # Disable APEX verification  
    ro.apex.updatable.testkey=true \
    
    # Use stock security stack
    ro.hardware.keystore=unisoc \
    ro.hardware.gatekeeper=trusty \
    ro.hardware.keymint=unisoc.trusty

# =============================================
# KEEP APEX UNFLATTENED FOR ODSIGN
# =============================================

# Ensure this is in BoardConfig.mk
# TARGET_FLATTEN_APEX := false


# =============================================
# COPY STOCK SYSTEM KEYSTORE2 STACK
# =============================================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/bin/keystore2:$(TARGET_COPY_OUT_SYSTEM)/bin/keystore2 \
    vendor/realme/RE58C2/proprietary/system/bin/keystore_cli_v2:$(TARGET_COPY_OUT_SYSTEM)/bin/keystore_cli_v2 \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeystore2_aaid.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeystore2_aaid.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeystore2_apc_compat.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeystore2_apc_compat.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeystore2_crypto.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeystore2_crypto.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeystore-attestation-application-id.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeystore-attestation-application-id.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeystore-engine.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeystore-engine.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkm_compat_service.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkm_compat_service.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkm_compat.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkm_compat.so \
    vendor/realme/RE58C2/proprietary/system/lib64/android.system.keystore2-V1-ndk.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.system.keystore2-V1-ndk.so \
    vendor/realme/RE58C2/proprietary/system/lib64/android.system.keystore2-V2-ndk.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.system.keystore2-V2-ndk.so \
    vendor/realme/RE58C2/proprietary/system/lib64/android.system.keystore2-V1-cpp.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.system.keystore2-V1-cpp.so \
    vendor/realme/RE58C2/proprietary/system/lib64/android.security.legacykeystore-ndk.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.security.legacykeystore-ndk.so \
    vendor/realme/RE58C2/proprietary/system/lib64/android.system.wifi.keystore@1.0.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/android.system.wifi.keystore@1.0.so \
    vendor/realme/RE58C2/proprietary/system/etc/init/keystore2.rc:$(TARGET_COPY_OUT_SYSTEM)/etc/init/keystore2.rc

# =============================================
# COPY STOCK VENDOR HARDWARE SECURITY SERVICES
# =============================================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/bin/hw/android.hardware.security.keymint@2.0-unisoc.service.trusty:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.security.keymint@2.0-unisoc.service.trusty \
    vendor/realme/RE58C2/proprietary/vendor/etc/init/android.hardware.security.keymint@2.0-unisoc.service.trusty.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.security.keymint@2.0-unisoc.service.trusty.rc \
    vendor/realme/RE58C2/proprietary/vendor/bin/hw/android.hardware.gatekeeper@1.0-service.trusty:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.gatekeeper@1.0-service.trusty \
    vendor/realme/RE58C2/proprietary/vendor/etc/init/android.hardware.gatekeeper@1.0-service.trusty.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.gatekeeper@1.0-service.trusty.rc

# =============================================
# COPY TRUSTY TEE STACK
# =============================================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/bin/tee_rpc:$(TARGET_COPY_OUT_VENDOR)/bin/tee_rpc \
    vendor/realme/RE58C2/proprietary/vendor/bin/hw/vendor.sprd.hardware.trusty-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/vendor.sprd.hardware.trusty-service \
    vendor/realme/RE58C2/proprietary/vendor/lib64/libteec.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libteec.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/libteecPlatform.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libteecPlatform.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/libteeproduction.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libteeproduction.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/libtrusty.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libtrusty.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/libsoter_trusty.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libsoter_trusty.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/libkernelbootcp.trusty.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkernelbootcp.trusty.so \
    vendor/realme/RE58C2/proprietary/vendor/etc/init/tee_rpc.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/tee_rpc.rc \
    vendor/realme/RE58C2/proprietary/vendor/etc/init/trusty-default.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/trusty-default.rc

# =============================================
# COPY KEYMINT/KEYMASTER LIBRARIES
# =============================================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeymint.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeymint.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeymint_support.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeymint_support.so \
    vendor/realme/RE58C2/proprietary/system/lib64/lib_android_keymaster_keymint_utils.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/lib_android_keymaster_keymint_utils.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeymaster_messages.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeymaster_messages.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeymaster_portable.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeymaster_portable.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeymaster4support.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeymaster4support.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libkeymaster4_1support.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libkeymaster4_1support.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libpuresoftkeymasterdevice.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libpuresoftkeymasterdevice.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libsqlite.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libsqlite.so

# =============================================
# VINTF MANIFESTS VIA PREBUILT_ETC
# =============================================
#PRODUCT_PACKAGES += \
    android.hardware.security.keymint.unisoc.trusty.manifest \
    android.hardware.gatekeeper@1.0-service.trusty.manifest \
    trusty.default.manifest 
  #  android.system.keystore2.manifest




# ===========================
# Overrides
# ===========================

PRODUCT_ENFORCE_RRO_TARGETS := *

# ===========================
# Inherit Vendor Files
# ===========================

$(call inherit-product, vendor/realme/RE58C2/RE58C2-vendor.mk)
