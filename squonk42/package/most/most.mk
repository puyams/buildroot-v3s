################################################################################
#
# most
#
################################################################################

MOST_SITE = http://www.jedsoft.org/releases/most
MOST_VERSION = 5.1.0
MOST_SOURCE = most-$(MOST_VERSION).tar.gz
MOST_LICENSE = GPL-2.0
MOST_LICENSE_FILES = COPYING

define MOST_BUILD_CMDS
	$(SED) 's/ slangversion / /g' $(@D)/src/Makefile
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define MOST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/src/objs/most $(TARGET_DIR)/usr/bin/most
endef

$(eval $(autotools-package))
