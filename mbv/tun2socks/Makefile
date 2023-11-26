include $(TOPDIR)/rules.mk

PKG_NAME:=tun2socks
PKG_VERSION:=2.5.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/xjasonlyu/tun2socks/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=48f42df4e991264196971035a63aa46647a41e031a60f4c4347a393ea43d9020

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jason Lyu <xjasonlyu@gmail.com>

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

GO_PKG:=github.com/xjasonlyu/tun2socks/v2
GO_PKG_BUILD_PKG:=$(GO_PKG)

GO_PKG_LDFLAGS_X:=$(GO_PKG)/internal/version.Version=$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/tun2socks
  TITLE:=powered by gVisor TCP/IP stack
  SECTION:=net
  CATEGORY:=Network
  URL:=https://github.com/xjasonlyu/tun2socks
  DEPENDS:=$(GO_ARCH_DEPENDS) +kmod-tun
endef

define Package/tun2socks/description
  tun2socks - powered by gVisor TCP/IP stack
endef


define Package/tun2socks/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/tun2socks $(1)/usr/bin/tun2socks

	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/tun2socks.conf $(1)/etc/config/tun2socks
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/tun2socks.init $(1)/etc/init.d/tun2socks
endef

$(eval $(call BuildPackage,tun2socks))