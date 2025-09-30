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
    init.logger.rc\
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
#PRODUCT_COPY_FILES += \
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


# Kernel modules - ALL modules from prebuilts
#PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilts/lib/modules/aes-ce-ccm.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/aes-ce-ccm.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/aes-neon-blk.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/aes-neon-blk.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/agdsp_access.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/agdsp_access.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/apsys-dvfs.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/apsys-dvfs.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/arc4.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/arc4.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/asix.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/asix.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/audio-dsp-dump.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/audio-dsp-dump.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/audio_mem.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/audio_mem.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/audio-pipe.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/audio-pipe.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/audio_sipc.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/audio_sipc.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/ax88179_178a.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/ax88179_178a.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/chipone-tddi.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/chipone-tddi.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/clk-sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/clk-sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/core.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/core.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/device_info.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/device_info.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/extcon-usb-gpio.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/extcon-usb-gpio.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/flash_ic_ocp8137.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/flash_ic_ocp8137.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/flash_ic_sgm3785.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/flash_ic_sgm3785.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/focaltech_ft8756_spi_ts.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/focaltech_ft8756_spi_ts.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/focaltech_touch-modules.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/focaltech_touch-modules.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/focaltech_tp.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/focaltech_tp.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/ghash-ce.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/ghash-ce.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/gpio-eic-sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/gpio-eic-sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/gpio.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/gpio.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/gpio-pmic-eic-sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/gpio-pmic-eic-sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/gpio-sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/gpio-sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/hardware_info.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/hardware_info.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/himax_mmi.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/himax_mmi.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/hung_task_enhance.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/hung_task_enhance.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/i2c-sprd-hw-v2.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/i2c-sprd-hw-v2.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/i2c-sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/i2c-sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/ion_cma_heap.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/ion_cma_heap.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/ion_ipc_trusty.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/ion_ipc_trusty.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/jiiov_fp.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/jiiov_fp.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/jpg.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/jpg.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/kfifo_buf.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/kfifo_buf.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/lcd_bias_adjust.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/lcd_bias_adjust.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/leds-sc27xx-bltc.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/leds-sc27xx-bltc.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/ledtrig-pattern.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/ledtrig-pattern.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/mcdt_hw_r2p0.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/mcdt_hw_r2p0.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/misc_sprd_uid.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/misc_sprd_uid.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/mmc_hsq.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/mmc_hsq.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/mmc_swcq.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/mmc_swcq.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/musb_hdrc.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/musb_hdrc.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/musb_sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/musb_sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/nq-nci.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/nq-nci.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/nvmem-sc27xx-efuse.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/nvmem-sc27xx-efuse.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/nvmem_sprd_cache_efuse.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/nvmem_sprd_cache_efuse.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/nvmem_sprd_efuse.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/nvmem_sprd_efuse.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/nvt_nt36xxx_spi_ts.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/nvt_nt36xxx_spi_ts.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/omnivision_tcm.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/omnivision_tcm.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/oplus_chg.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/oplus_chg.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/phy-sprd-qogirl6.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/phy-sprd-qogirl6.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/pinctrl.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/pinctrl.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/pinctrl-sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/pinctrl-sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/pinctrl-sprd-qogirl6.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/pinctrl-sprd-qogirl6.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/pwm-sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/pwm-sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/rpmb.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/rpmb.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/rtc-sc27xx.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/rtc-sc27xx.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sblock_bridge.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sblock_bridge.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sbuf_bridge.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sbuf_bridge.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sc2730-regulator.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sc2730-regulator.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sc27xx_adc.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sc27xx_adc.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sc27xx_fuel_gauge.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sc27xx_fuel_gauge.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sc27xx-poweroff.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sc27xx-poweroff.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sc27xx_typec.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sc27xx_typec.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sc27xx-vibra.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sc27xx-vibra.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sdhci-sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sdhci-sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sensorhub.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sensorhub.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/seth.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/seth.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sha1-ce.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sha1-ce.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sipc-core.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sipc-core.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sipx.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sipx.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/slog_bridge.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/slog_bridge.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sipa.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sipa.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sipa-tuning.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sipa-tuning.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sprd-card.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sprd-card.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sprd-codec-sc2730.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sprd-codec-sc2730.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sprd-codec-sc2730-power-dev.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sprd-codec-sc2730-power-dev.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sprd-codec-sc2730-power.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sprd-codec-sc2730-power.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sprd-dummy-codec.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sprd-dummy-codec.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sprd-pa-ucp1301.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sprd-pa-ucp1301.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sprd-pdm-r2p0.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sprd-pdm-r2p0.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sprd-vbc-fe.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sprd-vbc-fe.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/snd-soc-sprd-vbc-v4.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/snd-soc-sprd-vbc-v4.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/spipe.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/spipe.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/spi-sprd-adi.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/spi-sprd-adi.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/spi-sprd.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/spi-sprd.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/spool.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/spool.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_7sreset.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_7sreset.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_apipe.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_apipe.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_audcp_boot.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_audcp_boot.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_audcp_dvfs.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_audcp_dvfs.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_camera.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_camera.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_camsys_pw_domain.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_camsys_pw_domain.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-compr-2stage-dma.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-compr-2stage-dma.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_cpp.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_cpp.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-cpufreq-public.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-cpufreq-public.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-cpufreq-v2.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-cpufreq-v2.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-dmaengine-pcm.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-dmaengine-pcm.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-dma.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-dma.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-drm.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-drm.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_flash_drv.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_flash_drv.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-gsp.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-gsp.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_hwspinlock.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_hwspinlock.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-ion.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-ion.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_iq.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_iq.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_manufacturer_model.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_manufacturer_model.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_modem_loader.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_modem_loader.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_pdbg.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_pdbg.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-platform-pcm-routing.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-platform-pcm-routing.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_pmic_refout.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_pmic_refout.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_pmic_syscon.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_pmic_syscon.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_power_manager.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_power_manager.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-sc27xx-spi.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-sc27xx-spi.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_sensor.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_sensor.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_shm.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_shm.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-sipc-virt-bus.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-sipc-virt-bus.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_sip_svc.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_sip_svc.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_soc_id.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_soc_id.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_systimer.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_systimer.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_time_sync_cp.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_time_sync_cp.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_time_sync.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_time_sync.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_usbpinmux_qogirl6.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_usbpinmux_qogirl6.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd-vsp-pw-domain.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd-vsp-pw-domain.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/sprd_wdt_fiq.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/sprd_wdt_fiq.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/trusty-ipc.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/trusty-ipc.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/trusty-irq.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/trusty-irq.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/trusty.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/trusty.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/trusty-log.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/trusty-log.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/trusty-pm.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/trusty-pm.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/trusty-tui.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/trusty-tui.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/trusty-virtio.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/trusty-virtio.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/twofish_common.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/twofish_common.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/twofish_generic.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/twofish_generic.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/ufs-sprd_qogirl6.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/ufs-sprd_qogirl6.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/ump518-regulator.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/ump518-regulator.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/ums9230-clk.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/ums9230-clk.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/unisoc-iommu.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/unisoc-iommu.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/unisoc-mailbox.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/unisoc-mailbox.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/usb_f_vser.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/usb_f_vser.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/virt-dma.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/virt-dma.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/vsp.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/vsp.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/zram.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/zram.ko \
    $(LOCAL_PATH)/prebuilts/lib/modules/zsmalloc.ko:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules/zsmalloc.ko




# Platform-specific configurations
ifneq ($(TARGET_BOARD_PLATFORM),)
PRODUCT_PLATFORM := ums9230
endif


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
