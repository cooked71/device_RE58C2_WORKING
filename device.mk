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
PRODUCT_COPY_FILES += \
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
      $(LOCAL_PATH)/recoveryx/recovery/init.recovery.RE58C2.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.RE58C2.rc \
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
      $(LOCAL_PATH)/recoveryx/recovery/etc/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/etc/recovery.fstab

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

# Thermal Services (FIXED: Only list once)
PRODUCT_PACKAGES += \
    vendor.sprd.hardware.thermal@2.0-service \
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

# VINTF Manifests
# PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.trusty.manifest \
    android.hardware.health-service.example.manifest 

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

# Missing Trusty Libraries
PRODUCT_PACKAGES += \
    libtrusty \
    libtrustyHalHelper

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

# Missing System Libraries (for CAS service)
# PRODUCT_PACKAGES += \
    libstagefright_foundation \
    libmedia

# ===========================
# Hardware-specific manifests
# ===========================

# ===========================
# VINTF Manifest Configuration (STOCK STRUCTURE)
# ===========================

# Include all vendor manifest fragments as found in stock
DEVICE_MANIFEST_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/ai_engine-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.biometrics.fingerprint@2.1-service.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.cas@1.2-service.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.drm-service.clearkey.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.gatekeeper@1.0-service.trusty.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.health-service.example.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.security.keymint@2.0-unisoc.service.trusty.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.sensors-multihal.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.thermal@2.0-service.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.usb-service.example.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi@1.0-service.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi.hostapd.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/android.hardware.wifi.supplicant.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/bluetooth_audio.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/cplog_svc-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/enhance-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/face-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/hdcp-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/lights.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/manifest_android.hardware.drm-service.widevine.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/manifest_dualsim.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/manifest_media_c2_V1_1_unisoc.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/manifest_oplus_performance.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/memtrack.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/network-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/power.stats-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/rebootescrow-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/soter_default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/trusty-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/tui-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor-fingerprintmmi-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor-log-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor-oemlock-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor-power-default.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor.sprd.hardware.boot@1.2.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor.sprd.hardware.commondcs@1.0-service.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor.sprd.hardware.gnss@2.2-service.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vendor.sprd.hardware.thermal@2.0-service.xml \
    vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/vibrator.xml

# Also include compatibility matrix if it exists
DEVICE_MATRIX_FILE += vendor/realme/RE58C2/proprietary/vendor/etc/vintf/compatibility_matrix.xml

# ===========================
# Boot HAL Configuration
# ===========================

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.bootctrl=android.hardware.boot@1.2-impl

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/product/etc/fstab.postinstall:$(TARGET_COPY_OUT_PRODUCT)/etc/fstab.postinstall \
    $(LOCAL_PATH)/product/etc/fstab.postinstall:$(TARGET_COPY_OUT_RECOVERY)/product/etc/fstab.postinstall

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
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
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
# Init Scripts
# ===========================

#PRODUCT_PACKAGES += \
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
    init.zramwb.rc \
    init.logger.rc \
    init.recovery.common.rc

# ===========================
# Fstab Files
# ===========================

#PRODUCT_PACKAGES += \
    fstab.module \
    fstab.RE58C2 \
    fstab.RMX3624 \
    fstab.ums9230_1h10 \
    fstab.ums9230_1h10_go \
    fstab.ums9230_4h10 \
    fstab.ums9230_4h10_go \
    fstab.ums9230_6h10 \
    fstab.ums9230_7h10 \
    fstab.ums9230_haps \
    fstab.ums9230_hulk \
    fstab.ums9230_nico \
    fstab.ums9230_zebu

# ===========================
# Ueventd Files
# ===========================

#PRODUCT_PACKAGES += \
    ueventd.module.rc \
    ueventd.RE58C2.rc \
    ueventd.RMX3624.rc \
    ueventd.ums9230_1h10_go.rc \
    ueventd.ums9230_1h10.rc \
    ueventd.ums9230_4h10_go.rc \
    ueventd.ums9230_4h10.rc \
    ueventd.ums9230_6h10.rc \
    ueventd.ums9230_7h10.rc \
    ueventd.ums9230_haps.rc \
    ueventd.ums9230_hulk.rc \
    ueventd.ums9230_nico.rc \
    ueventd.ums9230_zebu.rc



# ===========================
# Recovery Files
# ===========================

# Recovery init files for vendor ramdisk
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.recovery.common.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/init.recovery.common.rc

# Recovery init files for recovery partition
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.recovery.common.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.common.rc

#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.recovery.metadata.rc:$(TARGET_COPY_OUT_RECOVERY)/init.recovery.metadata.rc

# Fstab files for all variants in recovery
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.module:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.module \
    $(LOCAL_PATH)/rootdir/etc/fstab.RE58C2:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.RE58C2 \
    $(LOCAL_PATH)/rootdir/etc/fstab.RMX3624:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.RMX3624 \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_1h10:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_1h10 \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_1h10_go:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_1h10_go \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_4h10:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_4h10 \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_4h10_go:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_4h10_go \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_6h10:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_6h10 \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_7h10:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_7h10 \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_haps:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_haps \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_hulk:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_hulk \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_nico:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_nico \
    $(LOCAL_PATH)/rootdir/etc/fstab.ums9230_zebu:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.ums9230_zebu

# Ueventd files for recovery - root folder
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/ueventd.module.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.module.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.RE58C2.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.RMX3624.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.RMX3624.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_1h10_go.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_1h10_go.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_1h10.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_1h10.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_4h10_go.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_4h10_go.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_4h10.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_4h10.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_6h10.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_6h10.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_7h10.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_7h10.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_haps.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_haps.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_hulk.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_hulk.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_nico.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_nico.rc \
    $(LOCAL_PATH)/rootdir/etc/ueventd.ums9230_zebu.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.ums9230_zebu.rc

# Recovery fstab
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab


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
# Core AOSP/Lineage Apps
# ===========================

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

# ===========================
# Overrides
# ===========================

PRODUCT_ENFORCE_RRO_TARGETS := *

# ===========================
# Inherit Vendor Files
# ===========================

$(call inherit-product, vendor/realme/RE58C2/RE58C2-vendor.mk)
