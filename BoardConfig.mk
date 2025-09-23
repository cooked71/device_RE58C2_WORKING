#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/realme/RE58C2

# Build system flags
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
ALLOW_MISSING_DEPENDENCIES := false
BUILD_BROKEN_MISSING_KERNEL_HEADERS := true

# Release tools
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)

#ramdisk prebuild
BOARD_VENDOR_RAMDISK_SUPPORT := false


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
TARGET_BOARD_PLATFORM := qogirl6
TARGET_BOOTLOADER_BOARD_NAME := ums9230_hulk
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

# 1. IMPORTANT: First, INCLUDE the Mesa namespace in device.mk
#    This makes the modules available to the build system
#    (This line goes in device.mk, not here)
# PRODUCT_SOONG_NAMESPACES += external/mesa3d

# 2. The STANDARD way to disable open-source graphics components
#    These flags tell the Mesa build rules to NOT build their modules
TARGET_USES_MESAGL := false
TARGET_USES_MESAGL2 := false
TARGET_USES_SWIFTSHADER := false

# 3. Signal that the device provides its own proprietary GPU implementation
BOARD_USE_PROPRIETARY_OPENGL := true

# 4. Standard OpenGL ES support flags
#    These are for the SYSTEM to know what features to support,
#    not for the BUILD SYSTEM to build open-source implementations
TARGET_USES_OPENGLES := true
TARGET_USES_GLES2 := true
TARGET_USES_GLES3 := true

# 5. (Optional but recommended) Point to your vendor's EGL library.
TARGET_EGL_PREBUILT_LIBRARY := "/vendor/lib/egl/libGLES_mali.so"
TARGET_EGL_PREBUILT_LIBRARY_64 := "/vendor/lib64/egl/libGLES_mali.so"



# Vendor Boot configuration
#BOARD_USES_RECOVERY_AS_BOOT :=
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE :=
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true


TARGET_NO_RECOVERY := false
BOARD_BOOT_HEADER_VERSION := 4
BOARD_USES_VENDOR_BOOT_IMAGE := true
BOARD_RAMDISK_USE_LZ4 := true
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD += $(BOOT_KERNEL_MODULES)

BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# Kernel arguments
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := console=ttyS1,115200n8 buildvariant=user
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
#debug 
BOARD_KERNEL_CMDLINE += single loglevel=8 ignore_loglevel earlyprintk
# Keep this - it's good for debugging!
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_panic=true

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x05400000
BOARD_TAGS_OFFSET := 0x00000100
BOARD_DTB_SIZE := 123569
BOARD_DTB_OFFSET := 0x01f00000
BOARD_HEADER_SIZE := 2128
BOARD_VENDOR_CMDLINE := console=ttyS1,115200n8 
BOARD_VENDOR_CMDLINE += androidboot.selinux=permissive

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
TARGET_PREBUILT_DTBO := $(DEVICE_PATH)/prebuilts/dtbo.img
BOARD_PREBUILT_DTBIMAGE := $(TARGET_PREBUILT_DTB)
BOARD_PREBUILT_DTBOIMAGE := $(TARGET_PREBUILT_DTBO)

# Disable RenderScript completely
# TARGET_EXCLUDE_RENDERSCRIPT := true
# ENABLE_RENDERSCRIPT := false


TARGET_KERNEL_SOURCE := kernel/realme/RE58C2
TARGET_KERNEL_CONFIG := RE58C2_defconfig
BOARD_KERNEL_IMAGE_NAME := Image

# Kernel version (must match prebuilt)
KERNEL_VERSION := 5.4.254-android12-9-gb10a25caafa5-ab1063

# Clang Toolchain
KERNEL_CLANG_PATH := /tmp/src/android/prebuilts/clang/kernel/linux-x86/clang-r416183b
TARGET_KERNEL_CLANG_VERSION := r416183b
TARGET_KERNEL_CLANG_PATH := $(KERNEL_CLANG_PATH)

# Graphics - Mali G57
TARGET_BOARD_GPU_OBJECT_SYSTEM_SUPPORT := true
BOARD_USES_GRALLOC_HANDLE := true
BOARD_USES_HWCOMPOSER := true
TARGET_USES_HWC2 := true
TARGET_USES_GRALLOC1 := true

# OpenGL ES
TARGET_USES_OPENGLES := true
TARGET_USES_GLES2 := true
TARGET_USES_GLES3 := true

# Mali GPU
TARGET_USES_MALI := true
BOARD_GPU_DRIVERS := mali
TARGET_GPU_PLATFORM := mali


# DTBO
BOARD_DTBOIMG_PARTITION_SIZE := 8388608

# Boot/ Vendor Boot sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864          # 64 MB
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 104857600  # 100 MB

# Super partition configuration
#BOARD_SUPER_PARTITION_SIZE := 8389734400
#BOARD_SUPER_PARTITION_GROUPS := realme_dynamic_partitions
BOARD_REALME_DYNAMIC_PARTITIONS_PARTITION_LIST := system product system_ext vendor odm vendor_dlkm
#BOARD_REALME_DYNAMIC_PARTITIONS_SIZE := 8289734400

BOARD_SUPER_PARTITION_SIZE := 8388608000
BOARD_SUPER_PARTITION_GROUPS := realme_dynamic_partitions
BOARD_REALME_DYNAMIC_PARTITIONS_SIZE := 8384418000

# Individual partition sizes (CORRECTED based on stock geometry):
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3435973836     # 3.2 GB (corrected from 3.0 GB)
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824     # 1.0 GB (corrected from 0.75 GB)
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 1610612736    # 1.5 GB
BOARD_SYSTEM_EXTIMAGE_PARTITION_SIZE := 1610612736 # 1.5 GB (corrected from 0.5 GB)
BOARD_ODMIMAGE_PARTITION_SIZE := 268435456         # 0.25 GB
BOARD_VENDOR_DLKMIMAGE_PARTITION_SIZE := 67108864  # 0.06 GB

# =============================================
# SUPER IMAGE CONFIGURATION
# =============================================
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_IMAGE_IN_UPDATE_PACKAGE := true
TARGET_USES_SUPER_PARTITION := true
BOARD_SUPER_PARTITION_GROUPS := realme_dynamic_partitions




# Dynamic partitions filesystem
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs

TARGET_COPY_OUT_VENDOR:=vendor
TARGET_COPY_OUT_PRODUCT:=product
TARGET_COPY_OUT_SYSTEM_EXT:=system_ext
TARGET_COPY_OUT_VENDOR_DLKM:=vendor_dlkm
TARGET_COPY_OUT_ODM:=odm

#set metadata partittion
BOARD_USES_METADATA_PARTITION := true



# Filesystem support
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Flash block size
BOARD_FLASH_BLOCK_SIZE := 262144  # (BOARD_KERNEL_PAGESIZE * 64)

# Recovery fstab
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Verified Boot (AVB)
# Verified Boot (AVB)
# Enable AVB
BOARD_AVB_ENABLE := true

# Main vbmeta signing key
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_ALGORITHM := SHA256_RSA4096
BOARD_AVB_ROLLBACK_INDEX := 1
BOARD_AVB_ROLLBACK_INDEX_LOCATION := 1

# Development only: disable hashtree verification to avoid dm-verity panic
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

# Security patch level
VENDOR_SECURITY_PATCH := 2024-07-05

#sepolicy for fastdotd
#BOARD_SEPOLICY_DIRS += device/realme/RE58C2/sepolicy/common
BOARD_RECOVERY_SEPOLICY_DIRS += device/realme/RE58C2/sepolicy/recovery

# Kernel modules
BOOT_KERNEL_MODULES += \
aes-ce-ccm.ko \
aes-neon-blk.ko \
apsys-dvfs.ko \
arc4.ko \
asix.ko \
ax88179_178a.ko \
bq2560x-charger.ko \
bq2597x-charger.ko \
chipone-tddi.ko\
clk-sprd.ko \
core.ko \
cpufreq_userspace.ko \
device_info.ko \
extcon-usb-gpio.ko \
fan53555.ko \
focaltech_touch-modules.ko \
focaltech_tp.ko \
ghash-ce.ko \
gnss_common_ctl_all.ko \
gnss_dbg.ko \
gnss_pmnotify_ctl.ko \
gpio-eic-sprd.ko \
gpio.ko \
gpio-pmic-eic-sprd.ko \
gpio-sprd.ko \
hardware_info.ko \
himax_mmi.ko \
hung_task_enhance.ko \
hyb.ko \
i2c-sprd-hw-v2.ko \
i2c-sprd.ko \
ims_bridge.ko \
ims_bridge_t.ko \
ion_cma_heap.ko \
ion_ipc_trusty.ko \
kfifo_buf.ko \
lcd_bias_adjust.ko \
leds-sc27xx-bltc.ko \
ledtrig-pattern.ko \
lzo.ko \
lzo-rle.ko \
mipi_driver.ko \
misc_sprd_uid.ko \
mmc_hsq.ko \
mmc_swcq.ko \
musb_hdrc.ko \
musb_sprd.ko \
nq-nci.ko \
nvmem-sc27xx-efuse.ko \
nvmem_sprd_cache_efuse.ko \
nvmem_sprd_efuse.ko \
omnivision_tcm.ko \
oplus_chg.ko \
op_rf_cable_monitor.ko \
phy-sprd-qogirl6.ko \
pinctrl.ko \
pinctrl-sprd.ko \
pinctrl-sprd-qogirl6.ko \
pwm-sprd.ko \
rpmb.ko \
rtc-sc27xx.ko \
sblock_bridge.ko \
sbuf_bridge.ko \
sc2332_sipc_wlan.ko \
sc2355_sdio_wlan.ko \
sc2355_sipc_wlan.ko \
sc2730-regulator.ko \
sc27xx_adc.ko \
sc27xx_fuel_gauge.ko \
sc27xx-poweroff.ko \
sc27xx_tsensor_thermal.ko \
sc27xx_typec.ko \
sc27xx-vibra.ko \
sdhci-sprd.ko \
sensorhub.ko \
seth.ko \
sfp_core.ko \
sha1-ce.ko \
sipc-core.ko \
sipx.ko \
slog_bridge.ko \
spipe.ko \
spi-sprd-adi.ko \
spi-sprd.ko \
spool.ko \
sprd_7sreset.ko \
sprd_cp_dvfs.ko \
sprd_cpu_cooling.ko \
sprd-cpufreq-public.ko \
sprd-cpufreq-v2.ko \
sprd_ddr_dvfs.ko \
sprd_disp_pm_domain_sharkl3.ko \
sprd-dma.ko \
sprd_gpu_cooling.ko \
sprd_hwspinlock.ko \
sprd-ion.ko \
sprd_iq.ko \
sprd_manufacturer_model.ko \
sprd_map.ko \
sprd_mipi.ko \
sprd_modem_loader.ko \
sprd_net_helper.ko \
sprd_pdbg.ko \
sprd_pmic_refout.ko \
sprd_pmic_smpl.ko \
sprd_pmic_syscon.ko \
sprd_pmic_wdt.ko \
sprd_power_manager.ko \
sprd-sc27xx-spi.ko \
sprd_shm.ko \
sprd-sipc-virt-bus.ko \
sprd_sip_svc.ko \
sprd_soc_id.ko \
sprd_soc_thm.ko \
sprd_systimer.ko \
sprd_thermal.ko \
sprd_time_sync_cp.ko \
sprd_time_sync.ko \
sprd-top-dvfs.ko \
sprd_u_ether.ko \
sprd_usb_f_rndis.ko \
sprd_usbpinmux_qogirl6.ko \
sprd_wdf.ko \
sprd_wdt_fiq.ko \
sprd_wlan.ko \
thermal-generic-adc.ko \
trusty-ipc.ko \
trusty-irq.ko \
trusty.ko \
trusty-log.ko \
trusty-pm.ko \
trusty-tui.ko \
trusty-virtio.ko \
twofish_common.ko \
twofish_generic.ko \
ufs-sprd_qogirl6.ko \
ump518-regulator.ko \
ums9230-clk.ko \
unisoc-iommu.ko \
unisoc-mailbox.ko \
usb_f_vser.ko \
virt-dma.ko \
virtio_crypto.ko \
wcn_bsp.ko \
zram.ko \
zsmalloc.ko


BOARD_VENDOR_KERNEL_MODULES_LOAD += $(BOOT_KERNEL_MODULES)

#sepolicy for fastdotd
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/common
BOARD_RECOVERY_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/recovery


# =============================================
# VINTF Configuration
# =============================================
DEVICE_MANIFEST_FILE += vendor/realme/RE58C2/proprietary/vintf/manifest.xml
DEVICE_MATRIX_FILE += vendor/realme/RE58C2/proprietary/vintf/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += vendor/realme/RE58C2/proprietary/product/etc/vintf/compatibility_matrix.xml
DEVICE_MANIFEST_FILE += \
    $(foreach f,$(wildcard vendor/realme/RE58C2/proprietary/vendor/etc/vintf/manifest/*.xml),$(f))

# Add manifest fragments if they exist
ifneq (,$(wildcard vendor/realme/RE58C2/proprietary/vintf/manifest/android.hardware.gatekeeper@1.0-service.trusty.xml))
  DEVICE_MANIFEST_FILE += vendor/realme/RE58C2/proprietary/vintf/manifest/android.hardware.gatekeeper@1.0-service.trusty.xml
endif

ifneq (,$(wildcard vendor/realme/RE58C2/proprietary/vintf/manifest/android.hardware.health-service.example.xml))
   DEVICE_MANIFEST_FILE += vendor/realme/RE58C2/proprietary/vintf/manifest/android.hardware.health-service.example.xml
endif

ifneq (,$(wildcard vendor/realme/RE58C2/proprietary/vintf/manifest/vendor-power-default.xml))
    DEVICE_MANIFEST_FILE += vendor/realme/RE58C2/proprietary/vintf/manifest/vendor-power-default.xml
endif

ifneq (,$(wildcard vendor/realme/RE58C2/proprietary/vintf/manifest/android.hardware.thermal@2.0-service.xml))
    DEVICE_MANIFEST_FILE += vendor/realme/RE58C2/proprietary/vintf/manifest/android.hardware.thermal@2.0-service.xml
endif

# Enable VINTF enforcement
PRODUCT_ENFORCE_VINTF_MANIFEST := true

ODM_MANIFEST_FILES += vendor/realme/RE58C2/proprietary/odm/etc/vintf/manifest_nfc.xml

# Properties
TARGET_SYSTEM_PROP        += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP        += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP       += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP    += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP   += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP           += $(DEVICE_PATH)/odm.prop
TARGET_VENDOR_DLKM_PROP   += $(DEVICE_PATH)/vendor_dlkm.prop
TARGET_ODM_DLKM_PROP      += $(DEVICE_PATH)/odm_dlkm.prop


# Inherit vendor blobs
include vendor/realme/RE58C2/BoardConfigVendor.mk
