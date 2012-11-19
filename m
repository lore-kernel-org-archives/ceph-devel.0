From: Stefan Priebe <s.priebe@profihost.ag>
Subject: [PATCH] rbd block driver fix race between aio completition and aio
 cancel
Date: Mon, 19 Nov 2012 21:43:07 +0100
Message-ID: <50AA99DB.6040307@profihost.ag>
References: <1353357585-31746-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56396 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2KSUnJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 15:43:09 -0500
In-Reply-To: <1353357585-31746-1-git-send-email-s.priebe@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "pve-devel@pve.proxmox.com" <pve-devel@pve.proxmox.com>

From: Stefan Priebe <s.priebe@profhost.ag>

This one fixes a race qemu also had in iscsi block driver between
cancellation and io completition.

qemu_rbd_aio_cancel was not synchronously waiting for the end of
the command.

It also removes the useless cancelled flag and introduces instead
a status flag with EINPROGRESS like iscsi block driver.

Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
---
  block/rbd.c |   19 ++++++++++++-------
  1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 5a0f79f..7b3bcbb 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -76,7 +76,7 @@ typedef struct RBDAIOCB {
      int64_t sector_num;
      int error;
      struct BDRVRBDState *s;
-    int cancelled;
+    int status;
  } RBDAIOCB;
   typedef struct RADOSCB {
@@ -376,9 +376,7 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
      RBDAIOCB *acb = rcb->acb;
      int64_t r;
  -    if (acb->cancelled) {
-        qemu_vfree(acb->bounce);
-        qemu_aio_release(acb);
+    if (acb->bh) {
          goto done;
      }
  @@ -406,9 +404,12 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
              acb->ret = r;
          }
      }
+    acb->status = acb->ret;
+
      /* Note that acb->bh can be NULL in case where the aio was 
cancelled */
      acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
      qemu_bh_schedule(acb->bh);
+
  done:
      g_free(rcb);
  }
@@ -573,7 +574,10 @@ static void qemu_rbd_close(BlockDriverState *bs)
  static void qemu_rbd_aio_cancel(BlockDriverAIOCB *blockacb)
  {
      RBDAIOCB *acb = (RBDAIOCB *) blockacb;
-    acb->cancelled = 1;
+
+    while (acb->status == -EINPROGRESS) {
+        qemu_aio_wait();
+    }
  }
   static AIOPool rbd_aio_pool = {
@@ -642,10 +646,11 @@ static void rbd_aio_bh_cb(void *opaque)
          qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
      }
      qemu_vfree(acb->bounce);
-    acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
      qemu_bh_delete(acb->bh);
      acb->bh = NULL;
  +    acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
+
      qemu_aio_release(acb);
  }
  @@ -689,8 +694,8 @@ static BlockDriverAIOCB 
*rbd_start_aio(BlockDriverState *bs,
      acb->ret = 0;
      acb->error = 0;
      acb->s = s;
-    acb->cancelled = 0;
      acb->bh = NULL;
+    acb->status = -EINPROGRESS;
       if (cmd == RBD_AIO_WRITE) {
          qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
-- 
1.7.10.4

