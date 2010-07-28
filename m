From: y@vger.kernel.org
Subject: [PATCH 1/2] add dkms support
Date: Wed, 28 Jul 2010 14:10:35 +0200
Message-ID: <30772.004745859$1280319565@news.gmane.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.muellerit.ch ([92.51.129.153]:45867 "EHLO
	mail.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851Ab0G1MTQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jul 2010 08:19:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Thomas Mueller <thomas@chaschperli.ch>

From: Thomas Mueller <thomas@chaschperli.ch>

hi

saw that now the cpeh-client-standalone contains a version - this is the dkms patch updated. 

only dkms part - debian package parts follow some time later.

- Thomas

---
 Makefile                   |    3 ++-
 dkms.conf                  |    7 +++++++
 dkms/add-to-dkms-and-build |   15 +++++++++++++++
 dkms/postremove.sh         |   34 ++++++++++++++++++++++++++++++++++
 dkms/prebuild.sh           |   32 ++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 1 deletions(-)
 create mode 100644 dkms.conf
 create mode 100644 dkms/add-to-dkms-and-build
 create mode 100644 dkms/postremove.sh
 create mode 100644 dkms/prebuild.sh

diff --git a/Makefile b/Makefile
index 6a660e6..4b8f6e7 100644
--- a/Makefile
+++ b/Makefile
@@ -22,7 +22,8 @@ else
 #Otherwise we were called directly from the command
 # line; invoke the kernel build system.
 
-KERNELDIR ?= /lib/modules/$(shell uname -r)/build
+KERNELRELEASE ?= $(shell uname -r)
+KERNELDIR ?= /lib/modules/$(KERNELRELEASE)/build
 PWD := $(shell pwd)
 
 default: all
diff --git a/dkms.conf b/dkms.conf
new file mode 100644
index 0000000..bbf607c
--- /dev/null
+++ b/dkms.conf
@@ -0,0 +1,7 @@
+PACKAGE_NAME="ceph"
+PACKAGE_VERSION="1.0"
+DEST_MODULE_LOCATION[0]="/updates/ceph"
+BUILT_MODULE_NAME[0]="ceph"
+AUTOINSTALL="yes"
+PRE_BUILD="dkms/prebuild.sh ${kernelver}"
+POST_REMOVE="dkms/postremove.sh ${kernelver}"
diff --git a/dkms/add-to-dkms-and-build b/dkms/add-to-dkms-and-build
new file mode 100644
index 0000000..ffea573
--- /dev/null
+++ b/dkms/add-to-dkms-and-build
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+if ! [ -f ./upstream_version.h ]
+then
+	echo "Failure: ./upstream_version.h not found. Did you call this script from ceph-client root?"
+fi
+
+CEPH_VERSION=$(grep CEPH_VERSION upstream_version.h | egrep -o "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+[^\"]+")
+
+mkdir /usr/src/ceph-${CEPH_VERSION} || exit 1
+cp -r ./ /usr/src/ceph-${CEPH_VERSION}
+
+dkms add -m ceph -v ${CEPH_VERSION} &&
+dkms build -m ceph -v ${CEPH_VERSION} &&
+dkms install -m ceph -v ${CEPH_VERSION}
diff --git a/dkms/postremove.sh b/dkms/postremove.sh
new file mode 100644
index 0000000..8693fcf
--- /dev/null
+++ b/dkms/postremove.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+
+if [ "$1" = "" ]
+then
+        echo "Usage: $0 <kernelver>"
+        exit
+fi
+
+MODROOT="/lib/modules/$1"
+
+if ! [ -f /etc/debian_version ]
+then
+        echo "Info: runs only on Debian and derivates"
+        exit
+fi
+
+
+
+if [ -d "$MODROOT" ]
+then
+        if [ -f "$MODROOT/kernel/fs/ceph/ceph.ko.dpkg-divert-by-ceph-dkms" ]
+        then
+                if  ! [ -f "$MODROOT/kernel/fs/ceph/ceph.ko" ]
+                then
+                        dpkg-divert --rename --remove "$MODROOT/kernel/fs/ceph/ceph.ko"
+                else
+                        echo "Warning: $MODROOT/kernel/fs/ceph/ceph.ko  and diverted $MODROOT/kernel/fs/ceph/ceph.ko.dpkg-divert-by-ceph-dkms exist both!"
+                fi
+        fi
+else
+        echo "Warning: $MODROOT is not a directory"
+fi
+
diff --git a/dkms/prebuild.sh b/dkms/prebuild.sh
new file mode 100644
index 0000000..1aee069
--- /dev/null
+++ b/dkms/prebuild.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+
+if [ "$1" = "" ]
+then
+	echo "Usage: $0 <kernelver>"
+	exit
+fi
+
+MODROOT="/lib/modules/$1"
+
+if ! [ -f /etc/debian_version ]
+then
+	echo "Info: runs only on Debian and derivates"
+	exit
+fi
+
+
+if [ -d "$MODROOT" ]
+then
+	if [ -f "$MODROOT/kernel/fs/ceph/ceph.ko" ] 
+	then
+		if  ! [ -f "$MODROOT/kernel/fs/ceph/ceph.ko.dpkg-divert-by-ceph-dkms" ]
+		then
+			dpkg-divert --rename --package ceph-dkms --divert "$MODROOT/kernel/fs/ceph/ceph.ko.dpkg-divert-by-ceph-dkms" --add "$MODROOT/kernel/fs/ceph/ceph.ko"
+		else
+			echo "Warning: $MODROOT/kernel/fs/ceph/ceph.ko  and diverted $MODROOT/kernel/fs/ceph/ceph.ko.dpkg-divert-by-ceph-dkms exist both!"
+		fi
+	fi
+else 
+	echo "Warning: $MODROOT is not a directory"
+fi
-- 
1.7.1

