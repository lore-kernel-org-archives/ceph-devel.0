From: Christian Brunner <chb@muc.de>
Subject: [PATCH 1/2] qemu-kvm/rbd: use new librados callback for
	ack/complete
Date: Thu, 6 May 2010 22:54:11 +0200
Message-ID: <20100506205411.GA57852@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:64807 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab0EFUyM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 16:54:12 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch uses the new librados aio callback function (from the unstable
branch of ceph).

Christian
---
 block/rbd.c |   51 ++++++++++++++++++++++++---------------------------
 1 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 12a85dc..dfd2eca 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -393,34 +393,31 @@ static void rbd_finish_aiocb(rados_completion_t c, RADOSCB * rcb)
     int64_t r;
     int i;
 
-    if (rados_aio_is_complete(c)) {
-        acb->aiocnt--;
-        r = rados_aio_get_return_value(c);
-        rados_aio_set_callback(c, NULL, NULL);
-        rados_aio_release(c);
-        if (acb->write) {
-            acb->ret += r;
+    acb->aiocnt--;
+    r = rados_aio_get_return_value(c);
+    rados_aio_release(c);
+    if (acb->write) {
+        acb->ret += r;
+    } else {
+        if (r < 0) {
+            memset(rcb->buf, 0, rcb->segsize);
+            acb->ret += rcb->segsize;
+        } else if (r < rcb->segsize) {
+            memset(rcb->buf + r, 0, rcb->segsize - r);
+            acb->ret += rcb->segsize;
         } else {
-            if (r < 0) {
-                memset(rcb->buf, 0, rcb->segsize);
-                acb->ret += rcb->segsize;
-            } else if (r < rcb->segsize) {
-                memset(rcb->buf + r, 0, rcb->segsize - r);
-                acb->ret += rcb->segsize;
-            } else {
-                acb->ret += r;
-            }
-        }
-        qemu_free(rcb);
-        i = 0;
-        while ((acb->aiocnt == 0) && !acb->rccomplete && i < 5) {
-            usleep(100);
-            i++;
-        }
-        if ((acb->aiocnt == 0) && acb->rccomplete && acb->bh) {
-            qemu_bh_schedule(acb->bh);
+            acb->ret += r;
         }
     }
+    qemu_free(rcb);
+    i = 0;
+    while ((acb->aiocnt == 0) && !acb->rccomplete && i < 5) {
+        usleep(100);
+        i++;
+    }
+    if ((acb->aiocnt == 0) && acb->rccomplete && acb->bh) {
+        qemu_bh_schedule(acb->bh);
+    }
 }
 
 static void rbd_aio_bh_cb(void *opaque)
@@ -494,8 +491,8 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState * bs,
 
         acb->aiocnt++;
 
-        rados_aio_create_completion((rados_callback_t) rbd_finish_aiocb,
-                                    rcb, &c);
+        rados_aio_create_completion(rcb, (rados_callback_t) rbd_finish_aiocb,
+                                    NULL, &c);
         if (write) {
             rados_aio_write(s->pool, n, segoffs, buf, segsize, c);
         } else {
-- 
1.6.6.1


-- 
Christian Brunner                              MUC.DE e.V.
                                               Joseph-Dollinger-Bogen 14
                                               D-80807 Muenchen
