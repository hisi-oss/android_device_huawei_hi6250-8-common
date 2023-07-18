#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter prague warsaw,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

# EGL symlinks
EGL_LIBS := libOpenCL.so libOpenCL.so.1 libOpenCL.so.1.1 hw/vulkan.hi6250.so

EGL_32_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/lib/,$(EGL_LIBS))
$(EGL_32_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "EGL 32 lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib/egl/libGLES_mali.so $@

EGL_64_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/lib64/,$(EGL_LIBS))
$(EGL_64_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "EGL 64 lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib64/egl/libGLES_mali.so $@

ALL_DEFAULT_INSTALLED_MODULES += $(EGL_32_SYMLINKS) $(EGL_64_SYMLINKS)

LIBBT_SYMLINKS := $(TARGET_OUT_VENDOR)/lib64/libbt-vendor.so
$(LIBBT_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "libbt-vendor link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib64/libbt-vendor-hisi.so $@

ALL_DEFAULT_INSTALLED_MODULES += $(LIBBT_SYMLINKS)

NATIVE_PACKAGES_FIXUP := $(TARGET_OUT_VENDOR)/etc/native_packages.xml
$(NATIVE_PACKAGES_FIXUP): $(TARGET_OUT_VENDOR)/etc/native_packages.bin
	@echo "Move vendor native_packages.bin to native_packages.xml"
	$(hide) mv $(TARGET_OUT_VENDOR)/etc/native_packages.bin $@

ALL_DEFAULT_INSTALLED_MODULES += $(NATIVE_PACKAGES_FIXUP)

endif
