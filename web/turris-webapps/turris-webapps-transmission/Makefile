#
# Copyright (C) 2020-2022 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-webapps-transmission
PKG_VERSION:=1.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/turris-webapps-transmission
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=WebApps
  TITLE:=Transmission integration
  DEPENDS:=+transmission-daemon +transmission-web \
    +turris-webapps \
    +turris-auth \
    +lighttpd-mod-proxy \
    +lighttpd-mod-setenv
  URL:=https://gitlab.nic.cz/turris/webapps
endef

define Package/turris-webapps-transmission/description
  WebApps integration package for transmission.
  See https://transmissionbt.com/
endef

define Build/Compile
endef

define Package/turris-webapps-transmission/install
	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) ./files/30_transmission.json $(1)/usr/share/turris-webapps/

	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/transmission.svg $(1)/www/webapps-icons

	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d
	$(CP) ./files/transmission.lighttpd $(1)/etc/lighttpd/conf.d/80-transmission.conf
endef

define Package/turris-webapps-transmission/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /etc/init.d/lighttpd restart
endef

$(eval $(call BuildPackage,turris-webapps-transmission))
