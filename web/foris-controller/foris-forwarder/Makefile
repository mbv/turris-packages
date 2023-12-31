#
# Copyright (C) 2020-2022 CZ.NIC, z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-forwarder
PKG_VERSION:=0.3.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/foris-controller/foris-forwarder.git
PKG_MIRROR_HASH:=355051e70092f4fbdaef7950f704e94b19b28db752b90c7d2a4037d3fb22767a
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/foris-forwarder
  SECTION:=web
  CATEGORY:=Web
  SUBMENU:=Foris Controller
  TITLE:=foris-forwarder
  URL:=https://gitlab.nic.cz/turris/foris-controller/foris-forwarder
  DEPENDS:= \
    +python3-light \
    +fosquitto \
    +python3-paho-mqtt \
    +python3-zeroconf
endef

define Package/foris-forwarder/description
  Websocket server implementation for foris notifications.
endef

define Package/foris-forwarder/conffiles
/etc/config/foris-forwarder
endef

define Py3Package/foris-forwarder/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/foris-forwarder.init $(1)/etc/init.d/foris-forwarder
endef

define Package/foris-forwarder/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/foris-forwarder enable
	/etc/init.d/foris-forwarder restart
}
endef

define Package/foris-forwarder/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/foris-forwarder stop
	/etc/init.d/foris-forwarder disable
}
endef

$(eval $(call Py3Package,foris-forwarder))
$(eval $(call BuildPackage,foris-forwarder))
$(eval $(call BuildPackage,foris-forwarder-src))
