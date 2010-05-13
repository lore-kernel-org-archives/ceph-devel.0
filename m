From: Christian Brunner <chb@muc.de>
Subject: [PATCH 2/2] avoid overwriting the header
Date: Thu, 13 May 2010 17:10:54 +0200
Message-ID: <20100513151054.GB53373@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:52718 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab0EMPKz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 May 2010 11:10:55 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

avoid overwriting the rbd header when doing qemu-img create
to resize a rbd image use rbdtool --resize instead
---
 block/rbd.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index a182d5e..11b7c10 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -163,6 +163,8 @@ static int rbd_create(const char *filename, QEMUOptionParameter * options)
 {
     int64_t bytes = 0;
     int64_t objsize;
+    uint64_t size;
+    time_t mtime;
     uint8_t obj_order = RBD_DEFAULT_OBJ_ORDER;
     char pool[RBD_MAX_SEG_NAME_SIZE];
     char n[RBD_MAX_SEG_NAME_SIZE];
@@ -227,6 +229,12 @@ static int rbd_create(const char *filename, QEMUOptionParameter * options)
         return -EIO;
     }
 
+    ret = rados_stat(p, n, &size, &mtime);
+    if (ret == 0) {
+        ret=-EEXIST;
+        goto done;
+    }
+
     ret = rados_write(p, n, 0, (const char *)&header, sizeof(header));
     if (ret < 0) {
         goto done;
-- 
1.7.0.4

