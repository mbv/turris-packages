#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis
PKG_VERSION:=0.7.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/reforis/reforis
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=\
	node/host \
	reforis-distutils/host \

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ./files/reforis-translations.mk

define Package/reforis
  TITLE:=reforis
  URL:=https://gitlab.labs.nic.cz/turris/reforis
  DEPENDS:= \
    +crypto-wrapper \
    +foris-client \
    +foris-controller-app \
    +foris-ws \
    +fosquitto \
    +lighttpd \
    +lighttpd-mod-alias \
    +lighttpd-mod-fastcgi \
    +lighttpd-mod-redirect \
    +lighttpd-mod-setenv \
    +python3-flask \
    +python3-flask-babel \
    +python3-flask-seasurf \
    +python3-flask-session \
    +python3-light \
    +python3-paho-mqtt \
    +python3-simplejson \
    +turris-maintain
  VARIANT:=python3
endef

define Package/reforis/description
  Web administration interface for Turris router.
endef

define Package/reforis/conffiles
/etc/config/reforis
endef

define Py3Package/reforis/filespec
+|$(PYTHON3_PKG_DIR)
-|$(PYTHON3_PKG_DIR)/reforis/translations/*
+|$(PYTHON3_PKG_DIR)/reforis/translations/en
endef

define Py3Package/reforis/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) ./files/01_reforis.conf $(1)/usr/share/turris-webapps/
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/reforis.jpg $(1)/www/webapps-icons

	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/reforis-lighttpd.conf $(1)/etc/lighttpd/conf.d/reforis.conf

	$(INSTALL_DIR) $(1)/usr/libexec/reforis
	$(INSTALL_BIN) ./files/reforis-lighttpd-dynamic.sh $(1)/usr/libexec/reforis/lighttpd-dynamic
	$(SED) 's%/usr/lib/python...%/usr/lib/python$(PYTHON3_VERSION)%g' $(1)/usr/libexec/reforis/lighttpd-dynamic

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/reforis.uci $(1)/etc/config/reforis

endef

define Package/reforis/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/lighttpd enable
	/usr/bin/maintain-lighttpd-restart
}
endef

define Package/reforis/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /usr/bin/maintain-lighttpd-restart
endef

$(eval $(call Py3Package,reforis))
$(eval $(call BuildPackage,reforis))
$(eval $(call BuildPackage,reforis-src))
$(foreach trans,$(REFORIS_TRANSLATIONS),$(eval $(call ReForisTranslation,$(trans))))