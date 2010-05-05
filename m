From: Christian Brunner <chb@muc.de>
Subject: [PATCH 1/2] qemu-kvm/rbd: Implement aio
Date: Wed, 5 May 2010 21:49:10 +0200
Message-ID: <20100505194909.GA50182@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:55044 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab0EETtM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 May 2010 15:49:12 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Finally I've managed to get a working implementation of async-I/O for qemu.
(At least in my test setup things are looking good now.)

The attached patch requires a small modification of librados. I will
send a mail on this in a few minutes.

Christian 
---
 block/rbd.c |  179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 178 insertions(+), 1 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 2177fcd..a3bfb4d 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -47,6 +47,25 @@
 
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
 
+typedef struct RBDAIOCB {
+        BlockDriverAIOCB common;
+        QEMUBH *bh;
+        int ret;
+        QEMUIOVector *qiov;
+        char *bounce;
+        int write;
+        int64_t sector_num;
+        int aiocnt;
+	int rccomplete;
+} RBDAIOCB;
+
+typedef struct RADOSCB {
+        int rcbid;
+        RBDAIOCB *acb;
+        int done;
+        int64_t segsize;
+        char *buf;
+} RADOSCB;
 
 typedef struct RBDRVRBDState {
 	rados_pool_t pool;
@@ -341,6 +360,162 @@ static int rbd_read(BlockDriverState *bs, int64_t sector_num,
 	return(0);
 }
 
+static void rbd_aio_cancel(BlockDriverAIOCB *blockacb)
+{
+    RBDAIOCB *acb = (RBDAIOCB *)blockacb;
+    qemu_bh_delete(acb->bh);
+    acb->bh = NULL;
+    qemu_aio_release(acb);
+}
+
+static AIOPool rbd_aio_pool = 
+{
+    .aiocb_size         = sizeof(RBDAIOCB),
+    .cancel             = rbd_aio_cancel,
+};
+
+static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb) 
+{
+    RBDAIOCB *acb = rcb->acb;
+    int64_t r;
+    int i;
+
+    if (rados_aio_is_complete(c)) {
+        acb->aiocnt--;
+        r = rados_aio_get_return_value(c);
+        rados_aio_set_callback(c, NULL, NULL);
+        rados_aio_release(c);
+        if (acb->write) {
+            acb->ret += r;
+        } else {
+            if (r < 0) {
+                memset(rcb->buf, 0, rcb->segsize);
+                acb->ret += rcb->segsize;
+            } else if (r < rcb->segsize) {
+                memset(rcb->buf+r, 0, rcb->segsize-r);
+                acb->ret += rcb->segsize;
+            } else {
+                acb->ret += r;
+            }
+        }
+        qemu_free(rcb);
+        i=0;
+        while ((acb->aiocnt == 0) && !acb->rccomplete && i<5) {
+	    usleep(100);
+            i++;
+        }
+        if ((acb->aiocnt == 0) && acb->rccomplete && acb->bh) {
+            qemu_bh_schedule(acb->bh);
+	}
+    }
+}
+            
+static void rbd_aio_bh_cb(void *opaque) 
+{
+    RBDAIOCB *acb = opaque;
+
+    if (!acb->write) {
+        qemu_iovec_from_buffer(acb->qiov, acb->bounce, acb->qiov->size);
+    }
+    qemu_vfree(acb->bounce);
+    acb->common.cb(acb->common.opaque, acb->ret);
+    qemu_bh_delete(acb->bh);
+    acb->bh = NULL;
+    qemu_aio_release(acb);
+}
+
+static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
+                                           int64_t sector_num,
+                                           QEMUIOVector *qiov,
+                                           int nb_sectors,
+                                           BlockDriverCompletionFunc *cb,
+                                           void *opaque,
+                                           int write)
+{
+    RBDAIOCB *acb;
+    RADOSCB *rcb;
+    rados_completion_t c;
+    char n[RBD_MAX_SEG_NAME_SIZE];
+    int64_t segnr, segoffs, segsize;
+    int64_t off, size;
+    char *buf;
+
+    RBDRVRBDState *s = bs->opaque;
+
+    acb = qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
+    acb->write = write;
+    acb->qiov = qiov;
+    acb->bounce = qemu_blockalign(bs, qiov->size);
+    acb->aiocnt=0;
+    acb->ret=0;
+    acb->rccomplete=0;
+
+    if (!acb->bh) {
+        acb->bh = qemu_bh_new(rbd_aio_bh_cb, acb);
+    }
+
+    if (write) {
+        qemu_iovec_to_buffer(acb->qiov, acb->bounce);
+    }
+
+    buf = acb->bounce;
+
+    off = sector_num * 512;
+    size = nb_sectors * 512;
+    segnr = (int64_t) (off / s->objsize);
+    segoffs = (int64_t) (off % s->objsize);
+    segsize  = (int64_t) (s->objsize - segoffs);
+
+    while (size > 0) {
+        if (size < segsize) {
+            segsize = size;
+        }
+
+        snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name, (long long unsigned int) segnr);
+
+        rcb = qemu_malloc(sizeof(RADOSCB));
+        rcb->done = 0;
+        rcb->acb = acb;
+        rcb->segsize = segsize;
+        rcb->buf = buf;
+
+        acb->aiocnt++;
+
+        rados_aio_create_completion((rados_callback_t) rbd_finish_aiocb, rcb, &c);
+        if (write) {
+            rados_aio_write(s->pool, n, segoffs, buf , segsize, c);
+	} else {
+            rados_aio_read(s->pool, n, segoffs, buf , segsize, c);
+	}
+
+        buf += segsize;
+        size -= segsize;
+        segoffs = 0;
+        segsize = s->objsize;
+        segnr++;
+    }
+
+    acb->rccomplete=1;
+
+    return &acb->common;
+}
+
+
+static BlockDriverAIOCB *rbd_aio_readv(BlockDriverState *bs,
+        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
+        BlockDriverCompletionFunc *cb, void *opaque)
+{
+    return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb, opaque, 0);
+}
+
+static BlockDriverAIOCB *rbd_aio_writev(BlockDriverState *bs,
+        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
+        BlockDriverCompletionFunc *cb, void *opaque)
+{
+    return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb, opaque, 1);
+}
+
+
 static int rbd_getinfo(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     RBDRVRBDState *s = bs->opaque;
@@ -381,6 +556,9 @@ static BlockDriver bdrv_rbd = {
 	.create_options = rbd_create_options,
 	.bdrv_getlength	= rbd_getlength,
 	.protocol_name	= "rbd",
+
+	.bdrv_aio_readv = rbd_aio_readv,
+	.bdrv_aio_writev= rbd_aio_writev,
 };
 
 static void bdrv_rbd_init(void) {
@@ -389,4 +567,3 @@ static void bdrv_rbd_init(void) {
 
 block_init(bdrv_rbd_init);
 
-
-- 
1.6.6.1


-- 
Christian Brunner                              MUC.DE e.V.
                                               Joseph-Dollinger-Bogen 14
                                               D-80807 Muenchen
