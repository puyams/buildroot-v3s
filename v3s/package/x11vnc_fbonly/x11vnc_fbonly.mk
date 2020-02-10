################################################################################
#
# x11vnc
#
################################################################################

X11VNC_FBONLY_VERSION = 0.9.16
X11VNC_FBONLY_SITE = $(call github,LibVNC,x11vnc,$(X11VNC_FBONLY_VERSION))
# sdl support is not used in x11vnc, but host include / library search paths
# leak in if host has sdl-config
X11VNC_FBONLY_CONF_OPTS = --without-sdl --without-ipv6 --without-x
X11VNC_FBONLY_DEPENDENCIES = libvncserver
X11VNC_FBONLY_LICENSE = GPL-2.0+
X11VNC_FBONLY_LICENSE_FILES = COPYING

# Source coming from github, no configure included
X11VNC_FBONLY_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_AVAHI_DAEMON)$(BR2_PACKAGE_DBUS),yy)
X11VNC_FBONLY_DEPENDENCIES += avahi dbus
else
X11VNC_FBONLY_CONF_OPTS += --without-avahi
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
X11VNC_FBONLY_DEPENDENCIES += jpeg
else
X11VNC_FBONLY_CONF_OPTS += --without-jpeg
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
X11VNC_FBONLY_DEPENDENCIES += openssl
else
X11VNC_FBONLY_CONF_OPTS += --without-ssl --without-crypto
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
X11VNC_FBONLY_DEPENDENCIES += zlib
else
X11VNC_FBONLY_CONF_OPTS += --without-zlib
endif

$(eval $(autotools-package))
