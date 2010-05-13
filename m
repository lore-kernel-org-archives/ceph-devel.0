From: Christian Brunner <chb@muc.de>
Subject: [PATCH 1/2] qemu-kvm: improved error handling
Date: Thu, 13 May 2010 17:10:15 +0200
Message-ID: <20100513151015.GA53373@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:62063 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865Ab0EMPKS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 May 2010 11:10:18 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

improved error handling: Since doing a memset(0) on every error is
potentially dangerous, we will limit this to -ENOENT, which is needed
for thin provisioning.

---
 block/rbd.c |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 7128e23..a182d5e 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -56,6 +56,7 @@ typedef struct RBDAIOCB {
     int write;
     int64_t sector_num;
     int aiocnt;
+    int error;
 } RBDAIOCB;
 
 typedef struct RADOSCB {
@@ -317,14 +318,16 @@ static int rbd_rw(BlockDriverState *bs, int64_t sector_num,
                  (long long unsigned int)segnr);
 
         if (write) {
-            if (rados_write(s->pool, n, segoffs, (const char *)buf, 
-                segsize) < 0) {
-                return -errno;
+            if ((r = rados_write(s->pool, n, segoffs, (const char *)buf, 
+                segsize)) < 0) {
+                return r;
             }
         } else {
             r = rados_read(s->pool, n, segoffs, (char *)buf, segsize);
-            if (r < 0) {
+            if (r == -ENOENT) {
                 memset(buf, 0, segsize);
+            } else if (r < 0) {
+                return(r);
             } else if (r < segsize) {
                 memset(buf + r, 0, segsize - r);
             }
@@ -376,15 +379,27 @@ static void rbd_finish_aiocb(rados_completion_t c, RADOSCB * rcb)
     r = rados_aio_get_return_value(c);
     rados_aio_release(c);
     if (acb->write) {
-        acb->ret += r;
-    } else {
         if (r < 0) {
-            memset(rcb->buf, 0, rcb->segsize);
+            acb->ret = r;
+            acb->error = 1;
+        } else if (!acb->error) {
             acb->ret += rcb->segsize;
+        }
+    } else {
+        if (r == -ENOENT) {
+            memset(rcb->buf, 0, rcb->segsize);
+            if (!acb->error) {
+                acb->ret += rcb->segsize;
+            }
+        } else if (r < 0) {
+            acb->ret = r;
+            acb->error = 1;
         } else if (r < rcb->segsize) {
             memset(rcb->buf + r, 0, rcb->segsize - r);
-            acb->ret += rcb->segsize;
-        } else {
+            if (!acb->error) {
+                acb->ret += rcb->segsize;
+            }
+        } else if (!acb->error) {
             acb->ret += r;
         }
     }
@@ -432,6 +447,7 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState * bs,
     acb->bounce = qemu_blockalign(bs, qiov->size);
     acb->aiocnt = 0;
     acb->ret = 0;
+    acb->error = 0;
 
     if (!acb->bh) {
         acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
-- 
1.7.0.4

