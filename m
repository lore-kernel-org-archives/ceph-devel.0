From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH 3/3] debian: add libcephfs-java package
Date: Fri, 02 Mar 2012 16:49:49 -0800
Message-ID: <4F516AAD.7010003@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:37227 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab2CCAtt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 19:49:49 -0500
Received: from martini.local (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id 62A201008A88
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 16:49:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Creates libceph1-java package that contains
the libcephfs Java wrappers .jar file and the
JNI library.

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 debian/.gitignore            |    1 +
 debian/control               |    8 +++++++-
 debian/libceph1-java.install |    2 ++
 debian/rules                 |    1 +
 4 files changed, 11 insertions(+), 1 deletions(-)
 create mode 100644 debian/libceph1-java.install

diff --git a/debian/.gitignore b/debian/.gitignore
index 1409714..323c423 100644
--- a/debian/.gitignore
+++ b/debian/.gitignore
@@ -28,4 +28,5 @@
 /gceph
 /obsync
 /python-ceph
+/libceph1-java
 /tmp
diff --git a/debian/control b/debian/control
index 946b0c3..1cec88e 100644
--- a/debian/control
+++ b/debian/control
@@ -6,7 +6,7 @@ Vcs-Git: git://github.com/ceph/ceph.git
 Vcs-Browser: https://github.com/ceph/ceph
 Maintainer: Laszlo Boszormenyi (GCS) <gcs@debian.hu>
 Uploaders: Sage Weil <sage@newdream.net>
-Build-Depends: debhelper (>= 6.0.7~), autotools-dev, autoconf, automake, libfuse-dev, libboost-dev (>= 1.34), libedit-dev, libcrypto++-dev, libtool, libexpat1-dev, libfcgi-dev, libatomic-ops-dev, libgoogle-perftools-dev [i386 amd64], pkg-config, libgtkmm-2.4-dev, python, python-support, libcurl4-gnutls-dev, libkeyutils-dev, uuid-dev, libaio-dev
+Build-Depends: debhelper (>= 6.0.7~), autotools-dev, autoconf, automake, libfuse-dev, libboost-dev (>= 1.34), libedit-dev, libcrypto++-dev, libtool, libexpat1-dev, libfcgi-dev, libatomic-ops-dev, libgoogle-perftools-dev [i386 amd64], pkg-config, libgtkmm-2.4-dev, python, python-support, libcurl4-gnutls-dev, libkeyutils-dev, uuid-dev, libaio-dev, javahelper, default-jdk
 Standards-Version: 3.9.3
 
 Package: ceph
@@ -326,3 +326,9 @@ Description: Python libraries for the Ceph distributed filesystem
  .
  This package contains Python libraries for interacting with Ceph's
  RADOS object storage, and RBD (RADOS block device).
+
+Package: libceph1-java
+Section: java
+Architecture: linux-any
+Depends: libcephfs1, ${shlibs:Depends}, ${java:Depends}, ${misc:Depends}
+Description: Java libraries for the Ceph File System
diff --git a/debian/libceph1-java.install b/debian/libceph1-java.install
new file mode 100644
index 0000000..5c14ed0
--- /dev/null
+++ b/debian/libceph1-java.install
@@ -0,0 +1,2 @@
+usr/lib/libcephfs_jni.so.* usr/lib/jni
+usr/lib/libcephfs.jar usr/share/java
diff --git a/debian/rules b/debian/rules
index e1f6e62..65ab30e 100755
--- a/debian/rules
+++ b/debian/rules
@@ -21,6 +21,7 @@ endif
 export DEB_HOST_ARCH      ?= $(shell dpkg-architecture -qDEB_HOST_ARCH)
 
 extraopts += --with-ocf
+extraopts += --enable-cephfs-java
 
 ifeq ($(DEB_HOST_ARCH), armel)
   # armel supports ARMv4t or above instructions sets.
-- 
1.7.5.4

