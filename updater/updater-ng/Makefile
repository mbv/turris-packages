#
## Copyright (C) 2016-2022 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=updater-ng
PKG_VERSION:=70.2.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/updater/updater.git
PKG_MIRROR_HASH:=6b0004bd64d238c661318d15038f669ad4e4564ff13f4a70863464e8a1d203eb
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DEPENDS:=busybox uthash argp-standalone

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk

define Package/updater-ng
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Updater
  DEPENDS:=\
    +liblua \
    +libuci-lua \
    +libevent2 \
    +libcurl \
    +liburiparser \
    +libarchive \
    +base64c \
    +ca-certificates
endef

define Package/updater-ng/description
  Turris package manager designed for automatic updates in mind. It is
  non-interactive in general but highly configurable through Lua scripts.
endef

CONFIGURE_ARGS += \
		--disable-tests \
		--disable-linters \
		--disable-docs \
		--with-embed-busybox="$(STAGING_DIR)/bin/busybox-static"

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libupdater*.so* $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(INSTALL_BIN) ./files/update_alternatives.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/updater
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/conf.lua $(1)/etc/updater
	$(INSTALL_DIR) $(1)/etc/updater/conf.d
	$(INSTALL_CONF) ./files/turris.lua $(1)/etc/updater/conf.d/turris.lua
	$(INSTALL_CONF) ./files/turris-repo.lua $(1)/etc/updater/turris-repo.lua
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/pkgupdate/configs/example.lua $(1)/etc/updater/conf.d/example.lua

	$(INSTALL_DIR) $(1)/etc/updater/hook_preupdate
	touch $(1)/etc/updater/hook_preupdate/.keep
	$(INSTALL_DIR) $(1)/etc/updater/hook_postupdate
	$(INSTALL_BIN) ./files/cleanup_rc_d.sh $(1)/etc/updater/hook_postupdate/
	$(INSTALL_DIR) $(1)/etc/updater/hook_reboot_required
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/pkgupdate/hook_reboot_required/50-create-notification.sh $(1)/etc/updater/hook_reboot_required/50-create-notification.sh

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/updater.config $(1)/etc/config/updater
endef

define Package/updater-ng/conffiles
/etc/updater/conf.d/example.lua
/etc/updater/turris-repo.lua
/etc/config/updater
endef

define Package/updater-ng/postinst
if [ -n "$$IPKG_INSTROOT" ] && [ -n "$$BOOTSTRAP_UPDATER_BRANCH" ]; then
	mkdir -p "$$IPKG_INSTROOT/usr/share/updater"
	echo "$$BOOTSTRAP_UPDATER_BRANCH" \
		> "$$IPKG_INSTROOT/usr/share/updater/bootstrap-updater-branch"
fi
endef

$(eval $(call BuildPackage,updater-ng))
