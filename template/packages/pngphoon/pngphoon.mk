################################################################################
#
# pngphoon
#
################################################################################

PNGPHOON_VERSION = 1.2
PNGPHOON_SOURCE = pngphoon-$(PNGPHOON_VERSION).tar.bz2
PNGPHOON_SITE = http://svolli.de/software/pngphoon
PNGPHOON_LICENSE = GPL-2.0+
PNGPHOON_LICENSE_FILES = LICENSE

define PNGPHOON_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define PNGPHOON_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/pngphoon $(TARGET_DIR)/usr/bin/pngphoon
endef

$(eval $(generic-package))
