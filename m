From: Christian Brunner <chb@muc.de>
Subject: qemu-kvm/rbd: first attempt to implement aio
Date: Thu, 15 Apr 2010 22:24:39 +0200
Message-ID: <20100415202439.GA8005@ncolin.muc.de>
References: <20100414204907.GA976@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:55822 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756564Ab0DOUYn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Apr 2010 16:24:43 -0400
Content-Disposition: inline
In-Reply-To: <20100414204907.GA976@ncolin.muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

To increase the performance of the qemu rbd driver I started to implement
aio functions. Attached is an intial aio implementation. However it is
missing the callback of rados_aio_read or _write from time to time.
This leads to a lockup of the disk driver until the guest OS is 
perfomring a bus reset.

If someone has an explanation for the cause of the lost callbacks. I
would be happy.

Regards, Christian

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rbd-aio.patch"

diff --git a/block/rbd.c b/block/rbd.c
index f68b440..5af2c05 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -47,6 +47,17 @@
 
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
 
+typedef struct RBDAIOCB {
+        BlockDriverAIOCB common;
+        QEMUIOVector *qiov;
+        int64_t sector_num;
+        int nb_sectors;
+        QEMUBH *bh;
+        int write;
+        char *buf;
+        int ret;
+        int aiocnt;
+} RBDAIOCB;
 
 typedef struct RBDRVRBDState {
 	rados_pool_t pool;
@@ -341,6 +352,192 @@ static int rbd_read(BlockDriverState *bs, int64_t sector_num,
 	return(0);
 }
 
+static int rbd_schedule_bh(QEMUBHFunc *cb, RBDAIOCB *acb) {
+        if (acb->bh) {
+                fprintf(stderr, "rbd_schedule_bh: bh should be NULL\n");
+                return -EIO;
+        }
+
+        acb->bh = qemu_bh_new(cb, acb);
+        if (!acb->bh) {
+                fprintf(stderr, "rbd_schedule_bh: qemu_bh_new failed\n");
+                return -EIO;
+        }
+
+        qemu_bh_schedule(acb->bh);
+
+        return 0;
+}
+
+static void rbd_finish_aiocb(rados_completion_t c, RBDAIOCB *acb) {
+	if (rados_aio_is_complete(c) && !rados_aio_is_safe(c)) {
+		acb->aiocnt--;
+		if (acb->write == 0) {
+			fprintf(stderr, "rbd_finish_aiocb: read complete - aiocnt=%i\n", acb->aiocnt);
+		} else {
+			fprintf(stderr, "rbd_finish_aiocb: write complete - aiocnt=%i\n", acb->aiocnt);
+		}
+	} else {
+		//fprintf(stderr, "rbd_finish_aiocb: returning\n");
+		return;
+	}
+	if (acb->aiocnt == 0) {
+		if (acb->write == 0) {
+			qemu_iovec_from_buffer(acb->qiov, acb->buf, acb->nb_sectors*512);
+		}
+	        acb->common.cb(acb->common.opaque, acb->ret);
+		//qemu_free(acb->buf);
+		qemu_aio_release(acb);
+	}
+}
+
+static void rbd_readv_bh_cb(void *p)
+{
+        RBDAIOCB *acb = p;
+        RBDRVRBDState *s = acb->common.bs->opaque;
+	rados_completion_t c;
+	char *buf;
+	char n[RBD_MAX_SEG_NAME_SIZE];
+	int64_t segnr, segoffs, segsize;
+	int64_t off, size;
+
+	off = acb->sector_num * 512;
+	size = acb->nb_sectors * 512;
+	segnr = (int64_t) (off / s->objsize);
+	segoffs = (int64_t) (off % s->objsize);
+	segsize  = (int64_t) (s->objsize - segoffs);
+
+	buf = acb->buf;
+
+	while (size > 0) {
+		if (size < segsize) {
+			segsize = size;
+		}
+	
+		snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name, (long long unsigned int) segnr);
+		acb->aiocnt++;
+		fprintf(stderr, "rbd_readv_bh_cb: aiocnt=%i: reading %s (segoffs: %lld, segsize %lld)\n", acb->aiocnt, n, (long long int) segoffs, (long long int) segsize);
+		rados_aio_read(s->pool, n, segoffs, (char *) buf, segsize, &c);
+		rados_aio_set_callback(c, (rados_callback_t) rbd_finish_aiocb, acb);
+		buf += segsize;
+		size -= segsize;
+		segoffs = 0;
+		segsize = s->objsize;
+		segnr++;
+	}
+
+	return;
+}
+
+static void rbd_writev_bh_cb(void *p)
+{
+        RBDAIOCB *acb = p;
+        RBDRVRBDState *s = acb->common.bs->opaque;
+	rados_completion_t c;
+	char *buf;
+	char n[RBD_MAX_SEG_NAME_SIZE];
+	int64_t segnr, segoffs, segsize;
+	int64_t off, size;
+
+	off = acb->sector_num * 512;
+	size = acb->nb_sectors * 512;
+	segnr = (int64_t) (off / s->objsize);
+	segoffs = (int64_t) (off % s->objsize);
+	segsize  = (int64_t) (s->objsize - segoffs);
+
+	buf = malloc(acb->qiov->size);
+	if (!buf) {
+		/* XXX: error */
+	}
+
+	qemu_iovec_to_buffer(acb->qiov, buf);
+
+	while (size > 0) {
+		if (size < segsize) {
+			segsize = size;
+		}
+	
+		snprintf(n, RBD_MAX_SEG_NAME_SIZE, "%s.%012llx", s->name, (long long unsigned int) segnr);
+		acb->aiocnt++;
+		fprintf(stderr, "rbd_readv_bh_cb: aiocnt=%i: writing %s (segoffs: %lld, segsize %lld)\n", acb->aiocnt, n, (long long int) segoffs, (long long int) segsize);
+		rados_aio_write(s->pool, n, segoffs, (char *) buf, segsize, &c);
+		rados_aio_set_callback(c, (rados_callback_t) rbd_finish_aiocb, acb);
+		
+		buf += segsize;
+		size -= segsize;
+		segoffs = 0;
+		segsize = s->objsize;
+		segnr++;
+	}
+
+	return;
+}
+
+static void rbd_aio_cancel(BlockDriverAIOCB *blockacb) {
+	// Do we have to implement canceling? Seems to work without...
+}
+
+static AIOPool rbd_aio_pool = {
+	.aiocb_size         = sizeof(RBDAIOCB),
+	.cancel             = rbd_aio_cancel,
+};
+
+static RBDAIOCB *rbd_aio_setup(BlockDriverState *bs,
+                                     int write, QEMUIOVector *qiov,
+                                     int64_t sector_num, int nb_sectors,
+                                     BlockDriverCompletionFunc *cb,
+                                     void *opaque) {
+	RBDAIOCB *acb;
+
+	acb = qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
+	acb->qiov = qiov;
+	acb->sector_num = sector_num;
+	acb->nb_sectors = nb_sectors;
+	acb->write = write;
+	acb->bh = NULL;
+	acb->aiocnt = 0;
+
+	if(acb->buf) {
+		qemu_free(acb->buf);
+	}
+	acb->buf = qemu_malloc(nb_sectors * 512);
+	if(write == 0) {
+		memset(acb->buf, 0, nb_sectors * 512);
+	}
+
+	return(acb);
+}
+
+static BlockDriverAIOCB *rbd_aio_readv(BlockDriverState *bs,
+        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
+        BlockDriverCompletionFunc *cb, void *opaque)
+{
+	RBDAIOCB *acb;
+
+	acb = rbd_aio_setup(bs, 0, qiov, sector_num, nb_sectors, cb, opaque);
+
+	rbd_schedule_bh(rbd_readv_bh_cb, acb);
+	return &acb->common;
+}
+
+
+
+static BlockDriverAIOCB *rbd_aio_writev(BlockDriverState *bs,
+                                       int64_t sector_num,
+                                       QEMUIOVector *qiov,
+                                       int nb_sectors,
+                                       BlockDriverCompletionFunc *cb,
+                                       void *opaque)
+{
+        RBDAIOCB *acb;
+
+        acb = rbd_aio_setup(bs, 1, qiov, sector_num, nb_sectors, cb, opaque);
+
+        rbd_schedule_bh(rbd_writev_bh_cb, acb);
+        return &acb->common;
+}
+
+
 static int rbd_getinfo(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     RBDRVRBDState *s = bs->opaque;
@@ -381,6 +578,9 @@ static BlockDriver bdrv_rbd = {
 	.create_options = rbd_create_options,
 	.bdrv_getlength	= rbd_getlength,
 	.protocol_name	= "rbd",
+
+	.bdrv_aio_readv = rbd_aio_readv,
+	.bdrv_aio_writev= rbd_aio_writev,
 };
 
 static void bdrv_rbd_init(void) {
@@ -389,4 +589,3 @@ static void bdrv_rbd_init(void) {
 
 block_init(bdrv_rbd_init);
 
-

--CE+1k2dSO48ffgeK--
