#
## Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater-opkg-wrapper
PKG_VERSION:=0.2.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/updater/opkg-wrapper.git
PKG_MIRROR_HASH:=4f22127171467fc41b820197910a79547ebf6ced2e5e4b220e9b07cdbc29de20
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/updater-opkg-wrapper
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=OPKG compatibility wrapper for updater
  DEPENDS:=+opkg +updater-ng +localrepo
endef

define Package/updater-opkg-wrapper/description
  Minimal script tracking opkg commands and changing into
  updater-ng's configuration. This is needed so changes done by opkg are not
  reverted by updater. In general, this covers only installation and removal of
  packages and that is with exceptions too.
endef

define Package/updater-opkg-wrapper/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/opkg $(1)/usr/bin/opkg-pkgupdate-wrapper.sh
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/opkg.lua $(1)/etc/updater/conf.d/opkg.lua
endef

Build/Compile:=

$(eval $(call BuildPackage,updater-opkg-wrapper))
