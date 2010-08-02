From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH 1/3] debian: create standalone client-tools package for mount.ceph
Date: Mon,  2 Aug 2010 13:32:43 +0200
Message-ID: <1280748765-21794-1-git-send-email-thomas@chaschperli.ch>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.muellerit.ch ([92.51.129.153]:54048 "EHLO
	mail.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab0HBLdF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 07:33:05 -0400
Received: from mail.muellerit.ch ([127.0.0.1])
	by localhost (mail.muellerit.ch [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cehLFTAADp-L for <ceph-devel@vger.kernel.org>;
	Mon,  2 Aug 2010 13:32:55 +0200 (CEST)
Received: from gargelblaster.mit.local (80-219-106-215.dclient.hispeed.ch [80.219.106.215])
	by mail.muellerit.ch (Postfix) with ESMTPSA id 1A4297924030
	for <ceph-devel@vger.kernel.org>; Mon,  2 Aug 2010 13:32:55 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Thomas Mueller <thomas@chaschperli.ch>

this is a replacement for "[PATCH] debian: create standalone client-tools package for mount.ceph"

* create package "ceph-client-tools"
* move rbd,rados,csyn too into the new package
* move fuse-utils dependency (Recommends) to ceph-fuse
* add ceph-client-tools dependency to ceph (Recommends)



Signed-off-by: Thomas Mueller <thomas@chaschperli.ch>
---
 debian/ceph-client-tools.install |    2 ++
 debian/ceph.install              |    2 --
 debian/control                   |   20 ++++++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100644 debian/ceph-client-tools.install

diff --git a/debian/ceph-client-tools.install b/debian/ceph-client-tools.install
new file mode 100644
index 0000000..49b5dd5
--- /dev/null
+++ b/debian/ceph-client-tools.install
@@ -0,0 +1,2 @@
+sbin/mount.ceph
+usr/share/man/man8/mount.ceph.8
diff --git a/debian/ceph.install b/debian/ceph.install
index e0dcf89..c8c7a2a 100644
--- a/debian/ceph.install
+++ b/debian/ceph.install
@@ -13,7 +13,6 @@ usr/bin/cosd
 usr/bin/cauthtool
 usr/bin/rados
 usr/bin/rbd
-sbin/mount.ceph
 usr/sbin/mkcephfs
 usr/lib/ceph/ceph_common.sh
 usr/lib/rados-classes/*
@@ -30,7 +29,6 @@ usr/share/man/man8/osdmaptool.8
 usr/share/man/man8/monmaptool.8
 usr/share/man/man8/cconf.8
 usr/share/man/man8/ceph.8
-usr/share/man/man8/mount.ceph.8
 usr/share/man/man8/cauthtool.8
 usr/share/man/man8/rados.8
 usr/share/man/man8/rbd.8
diff --git a/debian/control b/debian/control
index 53de537..38d4fac 100644
--- a/debian/control
+++ b/debian/control
@@ -56,6 +56,26 @@ Description: debugging symbols for ceph-fuse
  .
  This package contains the debugging symbols for ceph-fuse.
 
+Package: ceph-client-tools
+Architecture: any
+Depends: ${shlibs:Depends}, ${misc:Depends}
+Suggests: ceph
+Description: utilities to mount a ceph filesystem with the kernel client
+ Ceph is a distributed network file system designed to provide
+ excellent performance, reliability, and scalability.  This is the mount
+ utility, that allows to mount the ceph fs with the kernel client.
+
+Package: ceph-client-tools-dbg
+Architecture: any
+Depends: ${shlibs:Depends}, ${misc:Depends}
+Suggests: ceph
+Description: utilities for mount ceph filesystem with kernel client
+ Ceph is a distributed network file system designed to provide
+ excellent performance, reliability, and scalability.  This is the mount
+ utility, that allows to mount the ceph fs with the kernel client.
+ .
+ This package contains the debugging symbols for ceph-client-tools
+
 Package: libcrush1
 Conflicts: libcrush
 Replaces: libcrush
-- 
1.7.1

