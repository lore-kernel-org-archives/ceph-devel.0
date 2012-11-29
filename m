From: Stefan Priebe <s.priebe@profihost.ag>
Subject: [PATCHv3] rbd block driver fix race between aio completition and aio cancel
Date: Thu, 29 Nov 2012 11:25:40 +0100
Message-ID: <1354184740-23902-1-git-send-email-s.priebe@profihost.ag>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from packetbuilder64bit.de-nserver.de ([85.158.179.228]:38677 "EHLO
	packetbuilder64bit.de-nserver.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751634Ab2K2KZq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Nov 2012 05:25:46 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, josh.durgin@inktank.com, ceph-devel@vger.kernel.org, pbonzini@redhat.com, Stefan Priebe <s.priebe@profihost.ag>

This one fixes a race which qemu had also in iscsi block driver
between cancellation and io completition.

qemu_rbd_aio_cancel was not synchronously waiting for the end of
the command.

To archieve this it introduces a new status flag which uses
-EINPROGRESS.

Changes since last PATCH:
- fixed missing braces
- added vfree for bounce

Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
---
 block/rbd.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 0aaacaf..917c64c 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -77,6 +77,7 @@ typedef struct RBDAIOCB {
     int error;
     struct BDRVRBDState *s;
     int cancelled;
+    int status;
 } RBDAIOCB;
 
 typedef struct RADOSCB {
@@ -376,12 +377,6 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
     RBDAIOCB *acb = rcb->acb;
     int64_t r;
 
-    if (acb->cancelled) {
-        qemu_vfree(acb->bounce);
-        qemu_aio_release(acb);
-        goto done;
-    }
-
     r = rcb->ret;
 
     if (acb->cmd == RBD_AIO_WRITE ||
@@ -406,10 +401,11 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
             acb->ret = r;
         }
     }
+    acb->status = 0;
+
     /* Note that acb->bh can be NULL in case where the aio was cancelled */
     acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
     qemu_bh_schedule(acb->bh);
-done:
     g_free(rcb);
 }
 
@@ -568,6 +564,13 @@ static void qemu_rbd_aio_cancel(BlockDriverAIOCB *blockacb)
 {
     RBDAIOCB *acb = (RBDAIOCB *) blockacb;
     acb->cancelled = 1;
+
+    while (acb->status == -EINPROGRESS) {
+        qemu_aio_wait();
+    }
+
+    qemu_vfree(acb->bounce);
+    qemu_aio_release(acb);
 }
 
 static const AIOCBInfo rbd_aiocb_info = {
@@ -640,7 +643,9 @@ static void rbd_aio_bh_cb(void *opaque)
     qemu_bh_delete(acb->bh);
     acb->bh = NULL;
 
-    qemu_aio_release(acb);
+    if (!acb->cancelled) {
+        qemu_aio_release(acb);
+    }
 }
 
 static int rbd_aio_discard_wrapper(rbd_image_t image,
@@ -685,6 +690,7 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
     acb->s = s;
     acb->cancelled = 0;
     acb->bh = NULL;
+    acb->status = -EINPROGRESS;
 
     if (cmd == RBD_AIO_WRITE) {
         qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
@@ -731,7 +737,10 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
 failed:
     g_free(rcb);
     s->qemu_aio_count--;
-    qemu_aio_release(acb);
+    if (!acb->cancelled) {
+        qemu_vfree(acb->bounce);
+        qemu_aio_release(acb);
+    }
     return NULL;
 }
 
-- 
1.7.10.4

