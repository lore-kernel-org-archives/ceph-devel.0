From: Wido den Hollander <wido@widodh.nl>
Subject: [Qemu] Passing config options to librados
Date: Tue, 15 Mar 2011 13:20:18 +0100
Message-ID: <1300191618.2434.27.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49010 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757548Ab1COMUV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2011 08:20:21 -0400
Received: from [IPv6:2a00:f10:113:1:224:1dff:fedd:9061] (unknown [IPv6:2a00:f10:113:1:224:1dff:fedd:9061])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 7CDDF4267C
	for <ceph-devel@vger.kernel.org>; Tue, 15 Mar 2011 13:20:19 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

While testing with Qemu-KVM and RBD I got:

Unable to find any monitors in the configuration file, because there is
no configuration file. Please specify monitors via -m monaddr or -c
ceph.conf
qemu-system-x86_64: -drive file=rbd:rbd/beta,format=rbd: error
connecting
qemu: could not open disk image rbd:rbd/beta: No such file or directory

Some searching through the source-code showed me that ceph.conf isn't
read by librados anymore, but you have to force this with
rados_conf_read_file

The current RBD code doesn't do this, thus leaving librados
unconfigured.

I'm using the patch below to force reading the ceph.conf, but imho that
is not flexible enough.

The current RBD code has no way of reading config options from Qemu and
converting them into librados options by rados_conf_set() nor specifying
a conf file to be read by rados_conf_read_file().

Something that still has to be implemented or am I missing something?

Wido


From 03cfbebf1363b89bca6c97beb90e30e04add5db9 Mon Sep 17 00:00:00 2001
From: Wido den Hollander <wido@widodh.nl>
Date: Tue, 15 Mar 2011 13:11:24 +0100
Subject: [PATCH] librados: Force reading ceph.conf


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 block/rbd.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index f722cb4..7cd12f4 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -222,6 +222,11 @@ static int qemu_rbd_create(const char *filename,
QEMUOptionParameter *options)
         return -EIO;
     }
 
+    if (rados_conf_read_file(cluster, "/etc/ceph/ceph.conf") < 0) {
+        error_report("error reading configuration file");
+        return -EIO;
+    }
+
     if (rados_connect(cluster) < 0) {
         error_report("error connecting");
         rados_shutdown(cluster);
@@ -351,6 +356,11 @@ static int qemu_rbd_open(BlockDriverState *bs,
const char *filename, int flags)
         return r;
     }
 
+    if ((r = rados_conf_read_file(s->cluster, "/etc/ceph/ceph.conf")) <
0) {
+        error_report("error reading configuration file");
+        return r;
+    }
+
     if ((r = rados_connect(s->cluster)) < 0) {
         error_report("error connecting");
         rados_shutdown(s->cluster);
-- 
1.7.0.4

