################################################################################
#
# rtl8723bs_ext
#
################################################################################

RTL8723BS_BT_VERSION = 16f22d79a3326d49ce9c1fd17bce74d20521a6bb

RTL8723BS_BT_SITE = $(call github,bmericc,rtl8723bs_bt,$(RTL8723BS_BT_VERSION))
RTL8723BS_BT_LICENSE = GPL-2.0, proprietary (*.bin firmware blobs)

define RTL8723BS_BT_BUILD_CMDS
	cd $(@D) ; $(TARGET_CC) -o rtk_hciattach hciattach.c hciattach_rtk.c
endef

ifeq ($(BR2_PACKAGE_RTL8723BS_BT_NEW_FIRMWARE),y)
RTL8723BS_BT_FW_FILENAME = rtl8723bs_bt_fw_new.bin
else
RTL8723BS_BT_FW_FILENAME = rtl8723bs_bt_fw.bin
endif

define RTL8723BS_BT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/rtk_hciattach $(TARGET_DIR)/usr/sbin/rtk_hciattach
	$(INSTALL) -D -m 0644 $(@D)/firmware/rtl8723bs_bt_config $(TARGET_DIR)/lib/firmware/rtl_bt/rtl8723bs_config
	$(INSTALL) -D -m 0644 $(@D)/firmware/$(RTL8723BS_BT_FW_FILENAME) $(TARGET_DIR)/lib/firmware/rtl_bt/rtl8723bs_fw.bin
endef

$(eval $(generic-package))
