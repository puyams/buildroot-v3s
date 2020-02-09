################################################################################
#
# rtl8723bs_ext
#
################################################################################

ifeq ($(BR2_PACKAGE_RTL8723BS_EXT_NEEDS_SOURCES),y)
RTL8723BS_EXT_VERSION = 11ab92d8ccd71c80f0102828366b14ef6b676fb2
else
RTL8723BS_EXT_VERSION = cc77e7b6092c54500058cd027b679421b9399905
endif

warn(RTL8723BS_EXT_VERSION=$(BR2_LINUX_KERNEL_VERSION))

RTL8723BS_EXT_SITE = $(call github,hadess,rtl8723bs,$(RTL8723BS_EXT_VERSION))
RTL8723BS_EXT_LICENSE = GPL-2.0, proprietary (*.bin firmware blobs)

RTL8723BS_EXT_MODULE_MAKE_OPTS = \
	CONFIG_RTL8723BS=m \
	KVER=$(LINUX_VERSION_PROBED) \
	KSRC=$(LINUX_DIR)

RTL8723BS_EXT_BINS = rtl8723bs_ap_wowlan.bin rtl8723bs_wowlan.bin \
	rtl8723bs_bt.bin rtl8723bs_nic.bin

define RTL8723BS_EXT_CONDITIONAL_PATCH
	if [ "$(BR2_PACKAGE_RTL8723BS_EXT_NEEDS_SOURCES)" = "y" ]; then \
		$(APPLY_PATCHES) $(@D) $(BR2_EXTERNAL_V3S_PATH)/package/rtl8723bs_ext 0001-rtl8723bs-add-debug-level-modparam.patch.conditional; \
	fi;
endef

RTL8723BS_EXT_POST_PATCH_HOOKS += RTL8723BS_EXT_CONDITIONAL_PATCH

define RTL8723BS_EXT_INSTALL_FIRMWARE
	$(foreach bin, $(RTL8723BS_EXT_BINS), \
		$(INSTALL) -D -m 644 $(@D)/$(bin) $(TARGET_DIR)/lib/firmware/rtlwifi/$(bin)
	)
endef
RTL8723BS_EXT_POST_INSTALL_TARGET_HOOKS += RTL8723BS_EXT_INSTALL_FIRMWARE

$(eval $(kernel-module))
$(eval $(generic-package))
