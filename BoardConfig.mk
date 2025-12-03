
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
SELINUX_IGNORE_NEVERALLOWS := true

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
# UNISOC GRAPHICS CONFIGURATION
# ==================================================

# GPU identification
TARGET_GPU_PLATFORM := mali-g52
TARGET_GPU_VARIANT := mali-g52

# Unisoc proprietary graphics
BOARD_USES_UNISOC_GRAPHICS := true
TARGET_USES_UNISOC_GRAPHICS := true

# Essential graphics support
TARGET_USES_OPENGLES := true

# Let AOSP handle the rest automatically!



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

BOARD_KERNEL_CMDLINE := \
    androidboot.hardware=ums9230_hulk \
    androidboot.selinux=permissive \
    androidboot.dtbo_idx=7 \
    loop.max_part=7 \
    swiotlb=1

        
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x05400000
BOARD_TAGS_OFFSET := 0x00000100
BOARD_DTB_SIZE := 123569
BOARD_DTB_OFFSET := 0x01f00000
BOARD_HEADER_SIZE := 2128
BOARD_VENDOR_CMDLINE := console=ttyS1,115200n8

# ==================================================
# KERNEL CONFIGURATION - KEEPING YOUR SETUP
# ==================================================

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
TARGET_PREBUILT_DTBO := $(DEVICE_PATH)/prebuilts/dtbo.img
BOARD_PREBUILT_DTBIMAGE := $(TARGET_PREBUILT_DTB)
BOARD_PREBUILT_DTBOIMAGE := $(TARGET_PREBUILT_DTBO)

# Kernel source (for headers only)
TARGET_KERNEL_SOURCE := kernel/realme/RE58C2
TARGET_KERNEL_CONFIG := RE58C2_defconfig


LOCAL_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel

# Vendor Boot Manifest
#BOARD_VENDOR_BOOT_MANIFEST_FILE := $(DEVICE_PATH)/manifest_vendor_boot.xml

# Kernel modules for DUAL CPIO
# Ramdisk modules
#BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/recoveryx/ramdisk/lib/modules/modules.load))
#BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(DEVICE_PATH)/recoveryx/ramdisk/lib/modules/, $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD))

# Recovery modules  
#BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/recoveryx/recovery/lib/modules/modules.load.recovery))
#BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES := $(addprefix $(DEVICE_PATH)/recoveryx/recovery/lib/modules/, $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))

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

# ==================================================
# PARTITION FILESYSTEM TYPES & SIZES
# ==================================================

# System: erofs (Android OS)
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472      # 3,072 MB (3.0 GB)

# Product: ext4 (Main GApps location)
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 2147483648     # 2,048 MB (2.0 GB)

# System_ext: ext4 (Additional GApps)
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_PARTITION_SIZE := 1073741824  # 1,024 MB (1.0 GB)

# Vendor: erofs (device blobs)
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_PARTITION_SIZE := 805306368       # 768 MB

# ODM: erofs (device-specific)
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_PARTITION_SIZE := 335544320          # 320 MB

# Vendor DLKM: erofs (kernel modules)
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE := 67108864   # 64 MB

# ==================================================
# EXT4 CONFIGURATION
# ==================================================

# Enable ext4 support (for product/system_ext)
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# ext4 optimization
BOARD_EXT4_SHARE_DUP_BLOCKS := true
BOARD_PRODUCTIMAGE_EXTFS_INODE_COUNT := -1
BOARD_SYSTEM_EXTIMAGE_EXTFS_INODE_COUNT := -1

# ==================================================
# SUPER PARTITION CONFIGURATION (CORRECTED)
# ==================================================

# 1. Calculate TOTAL of all partitions:
# System:    3,221,225,472 bytes
# Product:   2,147,483,648 bytes
# System_ext:1,073,741,824 bytes
# Vendor:      805,306,368 bytes
# ODM:         335,544,320 bytes
# Vendor_dlkm:  67,108,864 bytes
# --------------------------------
# TOTAL:     7,650,410,496 bytes (~7.15 GB)

# 2. Super partition size (from your stock: 8.4 GB)
BOARD_SUPER_PARTITION_SIZE := 8589934592            # 8,589,934,592 bytes (8.4 GB)

# 3. Dynamic partitions size MUST be >= sum of all partitions
# Using 7.8 GB (leaves ~600 MB for metadata)
BOARD_SUPER_PARTITION_GROUPS := realme_dynamic_partitions
BOARD_REALME_DYNAMIC_PARTITIONS_SIZE := 8375186227  # ~7.8 GB

# Alternative: Use exact sum + 10% overhead
# BOARD_REALME_DYNAMIC_PARTITIONS_SIZE := 8415451545  # 7.65 GB + 10%

# 4. Partition list
BOARD_REALME_DYNAMIC_PARTITIONS_PARTITION_LIST := system product system_ext vendor odm vendor_dlkm

# ==================================================
# SUPER IMAGE BUILD SETTINGS
# ==================================================

# Force super image building
BOARD_BUILD_SUPER_IMAGE := true
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_IMAGE_IN_UPDATE_PACKAGE := true

# ==================================================
# EROFS CONFIGURATION
# ==================================================

BOARD_EROFS_COMPRESSOR := lz4
BOARD_EROFS_PCLUSTER_SIZE := 65536

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
BOARD_AVB_ROLLBACK_INDEX := 0
BOARD_AVB_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Boot signing
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(BOARD_AVB_ROLLBACK_INDEX)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 2

# Vendor_boot signing  
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := $(BOARD_AVB_ROLLBACK_INDEX)
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 3

# Security patch level
VENDOR_SECURITY_PATCH := 2024-07-05

# VINTF Configuration
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# VINTF Compatibility Matrix
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    vendor/realme/RE58C2/proprietary/product/etc/vintf/compatibility_matrix.xml


# ODM manifests
# ODM_MANIFEST_FILES += vendor/realme/RE58C2/proprietary/odm/etc/vintf/manifest_nfc.xml

# EROFS for OTA updates
BOARD_USES_EROFS_POSTINSTALL := true

# Essential for APEX updates
TARGET_FLATTEN_APEX := false


# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_VENDOR_DLKM_PROP += $(DEVICE_PATH)/vendor_dlkm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop

TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm




# ==================================================
# ESSENTIAL CONFIGURATION
# ==================================================

# Display
TARGET_SCREEN_DENSITY := 320

# RIL
BOARD_PROVIDES_RILD := true
ENABLE_VENDOR_RIL_SERVICE := true

# Graphics (minimal)
TARGET_GPU_PLATFORM := mali-g52
TARGET_GPU_VARIANT := mali-g52
BOARD_USES_UNISOC_GRAPHICS := true
TARGET_USES_OPENGLES := true

# Security
TARGET_USES_TRUSTY := true
BOARD_USES_KEYMASTER_4 := true
TARGET_KEYMINT_VERSION := 2.0

# SELinux
BOARD_SEPOLICY_VERS := 33.0
BOARD_VENDOR_SEPOLICY_DIRS += device/realme/RE58C2/sepolicy/vendor
SELINUX_IGNORE_NEVERALLOWS := true

# Vold
TARGET_PROVIDES_VOLD := true

