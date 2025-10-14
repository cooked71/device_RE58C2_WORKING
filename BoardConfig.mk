# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/RE58C2
KERNEL_PATH := device/realme/RE58C2/prebuilts

# Build system flags
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
ALLOW_MISSING_DEPENDENCIES := false
BUILD_BROKEN_MISSING_KERNEL_HEADERS := true
BUILD_BROKEN_INITRC_CHECKS := true


# SEPolicy
BOARD_SEPOLICY_VERS := 33.0

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a75

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Platform
TARGET_BOARD_PLATFORM := ums9230
TARGET_BOOTLOADER_BOARD_NAME := hulk_Natv
TARGET_OTA_ASSERT_DEVICE := RE58C2
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 320

# A/B partitions
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    vendor_dlkm \
    system \
    product \
    system_ext \
    vendor \
    odm

# ==================================================
# Graphics Configuration - USE VENDOR PREBUILTS ONLY
# ==================================================

# COMPLETELY disable AOSP graphics source building
TARGET_NO_GRALLOC := true
TARGET_NO_HWC := true
TARGET_NO_GPU := true

# Disable Mesa3D completely
MESA3D_BUILD := false
TARGET_USES_MESA3D := false
BOARD_USES_MESA3D := false

# Use prebuilt Mali GPU driver
BOARD_GPU_DRIVERS := mali
TARGET_USES_PREBUILT_GPU_DRIVER := true
TARGET_GPU_PLATFORM := mali

# EGL configuration
BOARD_EGL_CFG := $(DEVICE_PATH)/prebuilts/egl.cfg

# Force use of vendor prebuilts only
TARGET_PROVIDES_GRALLOC_HAL := true
TARGET_PROVIDES_HWC_HAL := true
TARGET_PROVIDES_GPU_LIBRARIES := true

# OpenGL ES support
TARGET_USES_OPENGLES := true
TARGET_USES_GLES2 := true
TARGET_USES_GLES3 := true

# Satisfy Mesa3D Android.mk namespace requirement
PRODUCT_SOONG_NAMESPACES += external/mesa3d

# Vendor Boot configuration for DUAL CPIO
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_USES_VENDOR_BOOT_IMAGE := true
TARGET_NO_RECOVERY := false

BOARD_BOOT_HEADER_VERSION := 4
BOARD_RAMDISK_USE_LZ4 := true

BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# Kernel arguments
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
# In device/realme/RE58C2/BoardConfig.mk or device.mk
BOARD_KERNEL_CMDLINE := \
    console=ttyS1,115200n8 \
    earlycon \
    androidboot.hardware=ums9230_hulk \
    androidboot.selinux=permissive \
    androidboot.verifiedbootstate=orange \
    androidboot.dtbo_idx=7 \
    loop.max_part=7 \
    swiotlb=1 \
    loglevel=7 \
    initcall_debug=1
    
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x05400000
BOARD_TAGS_OFFSET := 0x00000100
BOARD_DTB_SIZE := 123569
BOARD_DTB_OFFSET := 0x01f00000
BOARD_HEADER_SIZE := 2128
BOARD_VENDOR_CMDLINE := console=ttyS1,115200n8

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
TARGET_PREBUILT_DTBO := $(DEVICE_PATH)/prebuilts/dtbo.img
BOARD_PREBUILT_DTBIMAGE := $(TARGET_PREBUILT_DTB)
BOARD_PREBUILT_DTBOIMAGE := $(TARGET_PREBUILT_DTBO)

###########################
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_KERNEL_SOURCE := kernel/realme/RE58C2

LOCAL_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel

# Vendor Boot Manifest
BOARD_VENDOR_BOOT_MANIFEST_FILE := $(DEVICE_PATH)/manifest_vendor_boot.xml

# Kernel modules for DUAL CPIO
#BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/recoveryx/ramdisk/lib/modules/*.ko)
#BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)/recoveryx/recovery/lib/modules/*.ko)



# Kernel modules - SEPARATE for ramdisk.cpio and recovery.cpio
#BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/recoveryx/ramdisk/lib/modules/modules.load))
#BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(DEVICE_PATH)/recoveryx/ramdisk/lib/modules/, $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD))

#BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/recoveryx/recovery/lib/modules/modules.load.recovery))
#RECOVERY_MODULES := $(addprefix $(DEVICE_PATH)/recoveryx/recovery/lib/modules/, $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))



# Kernel modules for DUAL CPIO

# Ramdisk modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/recoveryx/ramdisk/lib/modules/modules.load))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(DEVICE_PATH)/recoveryx/ramdisk/lib/modules/, $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD))

# Recovery modules  
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/recoveryx/recovery/lib/modules/modules.load.recovery))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES := $(addprefix $(DEVICE_PATH)/recoveryx/recovery/lib/modules/, $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))

# Kernel version
KERNEL_VERSION := 5.4.254-android12-9-gb10a25caafa5-ab1063

# Clang Toolchain
TARGET_KERNEL_CLANG_VERSION := r416183b
TARGET_KERNEL_CLANG_COMPILE := true

# DTBO
BOARD_DTBOIMG_PARTITION_SIZE := 8388608

# Boot/ Vendor Boot sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 104857600

# Super partition configuration
BOARD_SUPER_PARTITION_SIZE := 8388608000
BOARD_SUPER_PARTITION_GROUPS := realme_dynamic_partitions
BOARD_REALME_DYNAMIC_PARTITIONS_SIZE := 8384418000
BOARD_REALME_DYNAMIC_PARTITIONS_PARTITION_LIST := system product system_ext vendor odm vendor_dlkm

# Force super image building
BOARD_BUILD_SUPER_IMAGE := true
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_IMAGE_IN_UPDATE_PACKAGE := true

# Individual partition sizes
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_VENDORIMAGE_PARTITION_SIZE := 805306368
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 1610612736
BOARD_SYSTEM_EXTIMAGE_PARTITION_SIZE := 536870912
BOARD_ODMIMAGE_PARTITION_SIZE := 268435456
BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE := 67108864

# Dynamic partitions filesystem
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

TARGET_COPY_OUT_SYSTEM := system
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_ODM := odm

# Metadata partition
BOARD_USES_METADATA_PARTITION := true

ENABLE_VENDOR_RIL_SERVICE := true

# Filesystem support
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Flash block size
BOARD_FLASH_BLOCK_SIZE := 262144

# Recovery fstab
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recoveryx/recovery/etc/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Verified Boot (AVB)
BOARD_AVB_ENABLE := true
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ALGORITHM := SHA256_RSA4096
BOARD_AVB_ROLLBACK_INDEX := 1
BOARD_AVB_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Boot signing
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 2

# Vendor_boot signing
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 3

# AVB signing for partitions
BOARD_AVB_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_ROLLBACK_INDEX := 1
BOARD_AVB_SYSTEM_ROLLBACK_INDEX_LOCATION := 4

BOARD_AVB_SYSTEM_EXT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_SYSTEM_EXT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_SYSTEM_EXT_ROLLBACK_INDEX := 1
BOARD_AVB_SYSTEM_EXT_ROLLBACK_INDEX_LOCATION := 5

BOARD_AVB_PRODUCT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_PRODUCT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_PRODUCT_ROLLBACK_INDEX := 1
BOARD_AVB_PRODUCT_ROLLBACK_INDEX_LOCATION := 6

BOARD_AVB_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_ROLLBACK_INDEX := 1
BOARD_AVB_VENDOR_ROLLBACK_INDEX_LOCATION := 7

BOARD_AVB_ODM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ODM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_ODM_ROLLBACK_INDEX := 1
BOARD_AVB_ODM_ROLLBACK_INDEX_LOCATION := 8

# Security patch level
VENDOR_SECURITY_PATCH := 2024-07-05


# =============================================
# VINTF Configuration
# =============================================
DEVICE_MANIFEST_FILE += vendor/realme/RE58C2/proprietary/vintf/manifest.xml
DEVICE_MATRIX_FILE += vendor/realme/RE58C2/proprietary/vintf/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += vendor/realme/RE58C2/proprietary/product/etc/vintf/compatibility_matrix.xml
DEVICE_MANIFEST_FILE += \
    $(foreach f,$(wildcard vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/*.xml),$(f))


# Enable VINTF enforcement
PRODUCT_ENFORCE_VINTF_MANIFEST := true

ODM_MANIFEST_FILES += vendor/realme/RE58C2/proprietary/odm/etc/vintf/manifest_nfc.xml

# EROFS OTA Configuration
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)
# TARGET_POSTINSTALL_FSTAB := $(DEVICE_PATH)/product/etc/fstab.postinstall
BOARD_USES_EROFS_POSTINSTALL := true

# Ensure the install plan picks up EROFS
TARGET_OTA_ASSERT_DEVICE := RE58C2

# Critical for odsign to work
TARGET_FLATTEN_APEX := false

# Disable AVB if still having issues
#BOARD_AVB_ENABLE := false

BOARD_VENDOR_SEPOLICY_DIRS += device/your_vendor/your_device/sepolicy/vendor




# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop

# Inherit vendor blobs
include vendor/realme/RE58C2/BoardConfigVendor.mk
