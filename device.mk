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
# UNISOC RIL CONFIGURATION
# ===========================

# Unisoc RIL packages
PRODUCT_PACKAGES += \
    urild \
    libril-private \
    libimpl-ril \
    librilutils \
    librilcore

# Unisoc RIL libraries
PRODUCT_PACKAGES += \
    vendor.unisoc.hardware.radio-V1-ndk \
    vendor.unisoc.hardware.radio.data-V1-ndk \
    vendor.unisoc.hardware.radio.sim-V1-ndk \
    vendor.unisoc.hardware.radio.network-V1-ndk \
    vendor.unisoc.hardware.radio.voice-V1-ndk \
    vendor.unisoc.hardware.radio.messaging-V1-ndk \
    vendor.unisoc.hardware.radio.modem-V1-ndk \
    vendor.unisoc.hardware.radio.ims-V1-ndk

# RIL properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.hardware.ril=unisoc \
    ro.radio.noril=no \
    persist.radio.multisim.config=dsds \
    rild.libpath=/vendor/lib64/libril-private.so \
    rild.libargs=-d /dev/ttyUSB0 \
    ro.telephony.default_network=9,9 \
    telephony.lteOnCdmaDevice=1

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

# Thermal Services
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
# SYSTEM LIBRARIES
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
# MISSING RADIO LIBRARIES
# ===========================

# AOSP Radio NDK Libraries
PRODUCT_PACKAGES += \
    android.hardware.radio-V1-ndk \
    android.hardware.radio.modem-V1-ndk \
    android.hardware.radio.config-V1-ndk \
    android.hardware.radio.data-V1-ndk \
    android.hardware.radio.sim-V1-ndk \
    android.hardware.radio.network-V1-ndk \
    android.hardware.radio.voice-V1-ndk \
    android.hardware.radio.messaging-V1-ndk

# Missing Broadcast Radio Libraries
PRODUCT_PACKAGES += \
    android.hardware.broadcastradio@2.0 \
    android.hardware.broadcastradio@1.0

# Missing CAS Libraries
PRODUCT_PACKAGES += \
    android.hardware.cas@1.2 \
    android.hardware.cas@1.1 \
    android.hardware.cas.native@1.0

# ===========================
# Recovery Configuration
# ===========================

PRODUCT_PACKAGES += \
    adbd.recovery \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd \
    linker.vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    shell_and_utilities_vendor_ramdisk \
    tune2fs.vendor_ramdisk

# Device libraries
PRODUCT_PACKAGES += \
    dmctl

PRODUCT_RECOVERY_PACKAGES += \
    dmctl

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

# Files for NORMAL boot (ramdisk.cpio)
PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.module.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.module.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/ueventd.RE58C2.rc \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.module:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.module \
      $(LOCAL_PATH)/recoveryx/ramdisk/first_stage_ramdisk/fstab.RE58C2:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.RE58C2

# Files for RECOVERY boot (recovery.cpio)
PRODUCT_COPY_FILES += \
      $(LOCAL_PATH)/recoveryx/recovery/init.recovery.common.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.common.rc \
      $(LOCAL_PATH)/recoveryx/recovery/init.recovery.ums9230_hulk.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.ums9230_hulk.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.module.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.module.rc \
      $(LOCAL_PATH)/recoveryx/recovery/ueventd.RE58C2.rc:$(TARGET_COPY_OUT_RECOVERY)/root/ueventd.RE58C2.rc

# ===========================
# Kernel modules - SEPARATE for normal vs recovery
# ===========================

# Modules for NORMAL boot (ramdisk.cpio)
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/*.ko),\
    $(file):$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/$(notdir $(file))) \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.alias:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.alias \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.dep:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.dep \
      $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/modules.load:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/modules.load

# Modules for RECOVERY boot (recovery.cpio)
PRODUCT_COPY_FILES += \
    $(foreach file,$(wildcard $(LOCAL_PATH)/recoveryx/recovery/lib/modules/*.ko),\
    $(file):$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/$(notdir $(file))) \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.alias:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.alias \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.dep:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.dep \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.load:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load \
      $(LOCAL_PATH)/recoveryx/recovery/lib/modules/modules.load.recovery:$(TARGET_COPY_OUT_RECOVERY)/root/lib/modules/modules.load.recovery

# ===========================
# Boot HAL Configuration
# ===========================

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.bootctrl=android.hardware.boot@1.2-impl

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/product/etc/fstab.postinstall:$(TARGET_COPY_OUT_PRODUCT)/etc/fstab.postinstall

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
# Boot Debugging Properties
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    debug.sf.nobootanimation=0 \
    ro.surface_flinger.max_frame_buffer_acquired_buffers=3 \
    ro.surface_flinger.running_without_sync_framework=true

# ===========================
# DISABLE VERIFICATION FOR INITIAL BOOT
# ===========================

PRODUCT_SYSTEM_PROPERTIES += \
    odsign.verification.disabled=true \
    ro.odsign.disabled=true \
    ro.apex.updatable.testkey=true \
    ro.hardware.keystore=unisoc \
    ro.hardware.gatekeeper=trusty \
    ro.hardware.keymint=unisoc.trusty

# ===========================
# Inherit Vendor Files
# ===========================

$(call inherit-product, vendor/realme/RE58C2/RE58C2-vendor.mk)