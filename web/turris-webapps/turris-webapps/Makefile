#
# Copyright (C) 2018-2022 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=turris-webapps
PKG_VERSION:=35e83ff3
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.nic.cz/api/v4/projects/962/packages/generic/turris-webapps/4.1.0/
PKG_HASH:=332842ccf058136d322358ec098c853045e990db7d7d3394c8a26e3e1d35cf29

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk

define Package/turris-webapps
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=WebApps
  TITLE:=Turris WebApps
  DEPENDS:=+lighttpd +lighttpd-mod-alias +lighttpd-mod-cgi +lighttpd-mod-setenv
  URL:=https://gitlab.nic.cz/turris/webapps
endef

define Package/turris-webapps/description
 Common landding page for various installed WebApps.
endef

Build/Compile:=:

define Package/turris-webapps/install
	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/turris-root.conf $(1)/etc/lighttpd/conf.d/90-turris-root.conf

	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/turris-webapps-json-cgi $(1)/usr/share/turris-webapps

	$(INSTALL_DIR) $(1)/www/turris-webapps
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/*.png $(1)/www/turris-webapps
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/index.html $(1)/www/turris-webapps
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/manifest.json $(1)/www/turris-webapps

	$(INSTALL_DIR) $(1)/www/turris-webapps/static

	$(INSTALL_DIR) $(1)/www/turris-webapps/static/css
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/static/css/* $(1)/www/turris-webapps/static/css

	$(INSTALL_DIR) $(1)/www/turris-webapps/static/js
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/static/js/* $(1)/www/turris-webapps/static/js

	$(INSTALL_DIR) $(1)/www/turris-webapps/static/media/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/static/media/turris-dark.*.svg $(1)/www/turris-webapps/static/media
endef

define Package/turris-webapps/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/lighttpd restart
}
endef

$(eval $(call BuildPackage,turris-webapps))
