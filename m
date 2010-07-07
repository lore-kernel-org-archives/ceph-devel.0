From: Thomas Mueller <thomas@chaschperli.ch>
Subject: PATCH: link ceph-client version to kernel version
Date: Wed, 7 Jul 2010 08:54:00 +0000 (UTC)
Message-ID: <i11fb7$mk1$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57771 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab0GGIyK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Jul 2010 04:54:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OWQON-0000XC-Nz
	for ceph-devel@vger.kernel.org; Wed, 07 Jul 2010 10:54:07 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jul 2010 10:54:07 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jul 2010 10:54:07 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

reading the version in ceph_fs.h made me think, that now that ceph is in 
vanilla kernel, it would be nice to have the version linked to the kernel 
version. this is how the kvm guys work for their backported module.

I've also patched super.c to expose the version to modinfo.

- Thomas


diff --git a/ceph_fs.h b/ceph_fs.h
index 63ff461..cfc995b 100644
--- a/ceph_fs.h
+++ b/ceph_fs.h
@@ -18,16 +18,17 @@
 /*
  * Ceph release version
  */
-#define CEPH_VERSION_MAJOR 0
-#define CEPH_VERSION_MINOR 20
-#define CEPH_VERSION_PATCH 0
+#define CEPH_VERSION_MAJOR 2
+#define CEPH_VERSION_MINOR 6
+#define CEPH_VERSION_PATCH 35
+#define CEPH_VERSION_FIX 0
 
 #define _CEPH_STRINGIFY(x) #x
 #define CEPH_STRINGIFY(x) _CEPH_STRINGIFY(x)
-#define CEPH_MAKE_VERSION(x, y, z) CEPH_STRINGIFY(x) "." CEPH_STRINGIFY(y) \
-       "." CEPH_STRINGIFY(z)
+#define CEPH_MAKE_VERSION(w, x, y, z) CEPH_STRINGIFY(w) "." CEPH_STRINGIFY(x) \
+       "." CEPH_STRINGIFY(y) "." CEPH_STRINGIFY(z)
 #define CEPH_VERSION CEPH_MAKE_VERSION(CEPH_VERSION_MAJOR, \
-                                      CEPH_VERSION_MINOR, CEPH_VERSION_PATCH)
+                                      CEPH_VERSION_MINOR, CEPH_VERSION_PATCH, CEPH_VERSION_FIX)
 
 /*
  * subprotocol versions.  when specific messages types or high-level
diff --git a/super.c b/super.c
index 27447a2..93d9c59 100644
--- a/super.c
+++ b/super.c
@@ -1149,3 +1149,4 @@ MODULE_AUTHOR("Yehuda Sadeh <yehuda@hq.newdream.net>");
 MODULE_AUTHOR("Patience Warnick <patience@newdream.net>");
 MODULE_DESCRIPTION("Ceph filesystem for Linux");
 MODULE_LICENSE("GPL");
+MODULE_INFO(version, CEPH_VERSION);

