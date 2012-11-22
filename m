From: Stefan Priebe <s.priebe@profihost.ag>
Subject: [PATCH] rbd block driver fix race between aio
	completition and aio cancel
Date: Thu, 22 Nov 2012 11:00:19 +0100
Message-ID: <1353578419-5481-1-git-send-email-s.priebe@profihost.ag>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, ceph-devel@vger.kernel.org, pbonzini@redhat.com, Stefan Priebe <s.priebe@profihost.ag>, josh.durgin@inktank.com
List-Id: ceph-devel.vger.kernel.org

This one fixes a race which qemu had also in iscsi block driver
between cancellation and io completition.

qemu_rbd_aio_cancel was not synchronously waiting for the end of
the command.

To archieve this it introduces a new status flag which uses
-EINPROGRESS.

Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
---
 block/rbd.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 0384c6c..783c3d7 100644
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
 
@@ -574,6 +570,12 @@ static void qemu_rbd_aio_cancel(BlockDriverAIOCB *blockacb)
 {
     RBDAIOCB *acb = (RBDAIOCB *) blockacb;
     acb->cancelled = 1;
+
+    while (acb->status == -EINPROGRESS) {
+        qemu_aio_wait();
+    }
+
+    qemu_aio_release(acb);
 }
 
 static AIOPool rbd_aio_pool = {
@@ -646,7 +648,8 @@ static void rbd_aio_bh_cb(void *opaque)
     qemu_bh_delete(acb->bh);
     acb->bh = NULL;
 
-    qemu_aio_release(acb);
+    if (!acb->cancelled)
+        qemu_aio_release(acb);
 }
 
 static int rbd_aio_discard_wrapper(rbd_image_t image,
@@ -691,6 +694,7 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
     acb->s = s;
     acb->cancelled = 0;
     acb->bh = NULL;
+    acb->status = -EINPROGRESS;
 
     if (cmd == RBD_AIO_WRITE) {
         qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
@@ -737,7 +741,8 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
 failed:
     g_free(rcb);
     s->qemu_aio_count--;
-    qemu_aio_release(acb);
+    if (!acb->cancelled)
+        qemu_aio_release(acb);
     return NULL;
 }
 
-- 
1.7.10.4
