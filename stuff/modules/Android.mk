#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),RE58C2)

MODULES_DIR := $(LOCAL_PATH)/stuff/modules
MODULES := $(shell find $(MODULES_DIR) -name '*.ko')

define add_prebuilt_module
include $(CLEAR_VARS)

LOCAL_MODULE := $(notdir $(basename $1))
LOCAL_MODULE_CLASS := KERNEL_MODULE
LOCAL_MODULE_SUFFIX := .ko
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(patsubst $(LOCAL_PATH)/%,%,$1)
LOCAL_MODULE_PATH := $(TARGET_OUT)/lib/modules

include $(BUILD_PREBUILT)
endef

$(foreach module,$(MODULES),$(eval $(call add_prebuilt_module,$(module))))

endif
