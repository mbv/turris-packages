#
# Copyright (C) 2020-2022 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=deckard
PKG_VERSION:=3.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/knot/deckard
PKG_SOURCE_VERSION:=2cb9779c550e8327667e96e28be83ecab430af96
PKG_MIRROR_HASH:=e10fe75613b5da883baaeb02055c5d878ce0a125060c339ebae07201463bb8b8

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/deckard
  SECTION:=net
  CATEGORY:=Network
  TITLE:=DNS testing framework
  URL:=https://gitlab.nic.cz/knot/deckard
  DEPENDS:= \
	+python3 \
	+python3-dns \
	+python3-pytest \
	+python3-yaml
endef

define Package/deckard/description
  Deckard helps debug DNS issues on different network configurations.
endef

Build/Compile:=:
Build/Install:=:

SCRIPTS_DIR:=/usr/libexec/deckard

define Package/deckard/install
	$(INSTALL_DIR) $(1)/$(SCRIPTS_DIR)/tools
	$(INSTALL_DIR) $(1)/usr/bin

	$(CP) $(PKG_BUILD_DIR)/{configs,contrib,doc,pydnstest,sets,template,tests,tools} $(1)/$(SCRIPTS_DIR)/
	$(CP) $(PKG_BUILD_DIR)/{*.sh,*.py,*.txt,*.rst,*.ini} $(1)/$(SCRIPTS_DIR)/
	$(INSTALL_BIN) ./files/dns_test.sh $(1)/$(SCRIPTS_DIR)/tools/
endef

$(eval $(call BuildPackage,deckard))
