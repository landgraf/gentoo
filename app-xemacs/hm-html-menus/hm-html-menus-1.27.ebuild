# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SLOT="0"
DESCRIPTION="HTML editing"
SRC_URI="http://ftp.xemacs.org/pub/xemacs/beta/experimental/packages/hm--html-menus-${PV}-pkg.tar.gz"
XEMACS_PKG_CAT="standard"

XEMACS_EXPERIMENTAL="true"

RDEPEND="app-xemacs/dired
app-xemacs/xemacs-base
"
KEYWORDS="~alpha amd64 ppc ppc64 ~riscv sparc x86"

inherit xemacs-packages
