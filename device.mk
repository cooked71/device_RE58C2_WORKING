# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# ===========================
# ABSOLUTE MINIMAL CONFIGURATION
# ===========================

# Dalvik VM Configuration
$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# Essential inheritances
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/userspace_reboot.mk)

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
DEVICE_MANIFEST_FILE += vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest.xml
DEVICE_MATRIX_FILE += vendor/realme/RE58C2/proprietary/vendor/etc/vintf/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += vendor/realme/RE58C2/proprietary/product/etc/vintf/compatibility_matrix.xml
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# KEEP ONLY WORKING MANIFESTS - REMOVE FAILING ONES
DEVICE_MANIFEST_FILE += \
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
# SELINUX POLICIES
# ===========================
BOARD_VENDOR_SEPOLICY_DIRS += device/realme/RE58C2/sepolicy/vendor

# ===========================
# EMERGENCY GRAPHICS FIXES
# ===========================
PRODUCT_SYSTEM_PROPERTIES += \
    debug.sf.disable_hwc=1 \
    debug.sf.force_gpu=1 \
    debug.egl.force_software=1 \
    ro.surface_flinger.force_hwc_copy_for_virtual_displays=true \
    ro.boottime.init=180 \
    ro.boottime.zygote=180 \
    ro.boottime.surfaceflinger=180

# ===========================
# BOOT PROPERTIES - MINIMAL
# ===========================
PRODUCT_SYSTEM_PROPERTIES += \
    ro.boot.selinux=permissive \
    ro.debuggable=1 \
    ro.hardware.egl=mali \
    ro.hardware.vulkan=mali \
    ro.hardware.gpu=mali \
    ro.hardware.hwcomposer=unisoc \
    ro.hardware.gralloc=default \
    ro.board.platform=ums9230 \
    ro.hardware.bootctrl=default \
    debug.sf.enable_gl_backpressure=1 \
    debug.sf.enable_hwc_vds=0 \
    debug.sf.hwc.canUseABC=0 \
    init.svc.surfaceflinger.timeout=60000 \
    ro.odsign.disabled=true \
    odsign.verification.disabled=true \
    ro.apex.updatable=false \
    persist.sys.usb.config=adb \
    ro.fastbootd.available=true

# ===========================
# DEVICE-SPECIFIC PACKAGES ONLY (NO AOSP CORE COMPONENTS)
# ===========================
PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.graphics.composer@2.4-service \
    android.hardware.graphics.allocator@4.0-service \
    android.hardware.biometrics.fingerprint@2.1-service \
    android.hardware.security.keymint@2.0-unisoc.service.trusty \
    vendor.sprd.hardware.boot@1.2-service \
    vendor.sprd.hardware.lights-service \
    vendor.sprd.hardware.vibrator-service \
    SoterService \
    ims

# ===========================
# GRAPHICS FILES
# ===========================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/lib/egl/libGLES_mali.so:$(TARGET_COPY_OUT_VENDOR)/lib/egl/libGLES_mali.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/egl/libGLES_mali.so:$(TARGET_COPY_OUT_VENDOR)/lib64/egl/libGLES_mali.so \
    vendor/realme/RE58C2/proprietary/vendor/lib/hw/gralloc.default.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/gralloc.default.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/hw/gralloc.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/gralloc.default.so

# ===========================
# AUDIO CONFIGURATION
# ===========================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/bin/hw/android.hardware.audio.service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.audio.service \
    vendor/realme/RE58C2/proprietary/vendor/etc/init/android.hardware.audio.service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.audio.service.rc \
    vendor/realme/RE58C2/proprietary/odm/etc/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_ODM)/etc/audio/audio_policy_configuration.xml

PRODUCT_SYSTEM_PROPERTIES += \
    ro.hardware.audio.primary=whale \
    ro.hardware.audio=whale \
    ro.audio.sprd=1

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
# VENDOR RAMDISK (KEEP EXISTING)
# ===========================
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/realme/RE58C2/recoveryx/ramdisk/system,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/system)

# Essential modules for normal boot
NORMAL_MODULES := $(wildcard $(LOCAL_PATH)/recoveryx/ramdisk/lib/modules/*.ko)
PRODUCT_COPY_FILES += $(foreach file,$(NORMAL_MODULES),\
    $(file):$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/$(notdir $(file)))

# ===========================
# RECOVERY BOOT
# ===========================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recoveryx/recovery/init.recovery.common.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.common.rc \
    $(LOCAL_PATH)/recoveryx/recovery/init.recovery.ums9230_hulk.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.ums9230_hulk.rc

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
# SELINUX FILES
# ===========================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/etc/selinux/vendor_file_contexts:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/vendor_file_contexts \
    vendor/realme/RE58C2/proprietary/vendor/etc/selinux/vendor_sepolicy.cil:$(TARGET_COPY_OUT_VENDOR)/etc/selinux/vendor_sepolicy.cil

BOARD_SEPOLICY_UNION += \
    vendor_file_contexts \
    vendor_sepolicy.cil

# ===========================
# TEMPORARY SELINUX PERMISSIVE
# ===========================
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
PRODUCT_PROPERTY_OVERRIDES += ro.boot.selinux=permissive

# ===========================
# CORE LIBRARIES
# ===========================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/system/lib/libhardware_legacy.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libhardware_legacy.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libhardware_legacy.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libhardware_legacy.so \
    vendor/realme/RE58C2/proprietary/system/lib/libnetutils.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libnetutils.so \
    vendor/realme/RE58C2/proprietary/system/lib64/libnetutils.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libnetutils.so

# ===========================
# MEDIA CONFIGURATION
# ===========================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/etc/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml

# ===========================
# BOOT CONTROL LIBRARIES
# ===========================
PRODUCT_COPY_FILES += \
    vendor/realme/RE58C2/proprietary/vendor/lib/hw/android.hardware.boot@1.0-impl-1.2.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/android.hardware.boot@1.0-impl-1.2.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/hw/android.hardware.boot@1.0-impl-1.2.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.boot@1.0-impl-1.2.so \
    vendor/realme/RE58C2/proprietary/vendor/lib/hw/bootctrl.default.so:$(TARGET_COPY_OUT_VENDOR)/lib/hw/bootctrl.default.so \
    vendor/realme/RE58C2/proprietary/vendor/lib64/hw/bootctrl.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/bootctrl.default.so
