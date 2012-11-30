From: Stefan Priebe <s.priebe@profihost.ag>
Subject: [PATCHv6] rbd block driver fix race between aio
	completition and aio cancel
Date: Fri, 30 Nov 2012 09:55:46 +0100
Message-ID: <1354265746-8390-1-git-send-email-s.priebe@profihost.ag>
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

Changes since PATCHv5:
- qemu_aio_release has to be done in qemu_rbd_aio_cancel if I/O
  was cancelled

Changes since PATCHv4:
- removed unnecessary qemu_vfree of acb->bounce as BH will always
  run

Changes since PATCHv3:
- removed unnecessary if condition in rbd_start_aio as we
  haven't start io yet
- moved acb->status = 0 to rbd_aio_bh_cb so qemu_aio_wait always
  waits until BH was executed

Changes since PATCHv2:
- fixed missing braces
- added vfree for bounce

Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>

---
 block/rbd.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index f3becc7..737bab1 100644
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
@@ -409,7 +404,6 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
     /* Note that acb->bh can be NULL in case where the aio was cancelled */
     acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
     qemu_bh_schedule(acb->bh);
-done:
     g_free(rcb);
 }
 
@@ -568,6 +562,12 @@ static void qemu_rbd_aio_cancel(BlockDriverAIOCB *blockacb)
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
 
 static const AIOCBInfo rbd_aiocb_info = {
@@ -639,8 +639,11 @@ static void rbd_aio_bh_cb(void *opaque)
     acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
     qemu_bh_delete(acb->bh);
     acb->bh = NULL;
+    acb->status = 0;
 
-    qemu_aio_release(acb);
+    if (!acb->cancelled) {
+        qemu_aio_release(acb);
+    }
 }
 
 static int rbd_aio_discard_wrapper(rbd_image_t image,
@@ -685,6 +688,7 @@ static BlockDriverAIOCB *rbd_start_aio(BlockDriverState *bs,
     acb->s = s;
     acb->cancelled = 0;
     acb->bh = NULL;
+    acb->status = -EINPROGRESS;
 
     if (cmd == RBD_AIO_WRITE) {
         qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
-- 
1.7.10.4
