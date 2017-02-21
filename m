From: jazeltq@gmail.com
Subject: [RFC v6] RBD: Add support readv,writev for rbd
Date: Tue, 21 Feb 2017 11:43:36 +0800
Message-ID: <20170221034336.10097-1-jazeltq@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35972 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdBUDqi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2017 22:46:38 -0500
Received: by mail-pg0-f65.google.com with SMTP id a123so13074606pgc.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Feb 2017 19:46:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jdurgin@redhat.com, jcody@redhat.com, dillaman@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, jazeltq@gmail.com, tianqing <tianqing@unitedstack.com>

From: tianqing <tianqing@unitedstack.com>

Rbd can do readv and writev directly, so wo do not need to transform
iov to buf or vice versa any more.

Signed-off-by: tianqing <tianqing@unitedstack.com>
---
 block/rbd.c | 79 ++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index a57b3e3..5373680 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -62,6 +62,13 @@
 #define RBD_MAX_SNAP_NAME_SIZE 128
 #define RBD_MAX_SNAPS 100
 
+/* The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h */
+#ifdef LIBRBD_SUPPORTS_IOVEC
+#define LIBRBD_USE_IOVEC 1
+#else
+#define LIBRBD_USE_IOVEC 0
+#endif
+
 typedef enum {
     RBD_AIO_READ,
     RBD_AIO_WRITE,
@@ -310,6 +317,17 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
     return ret;
 }
 
+static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
+{
+    if(LIBRBD_USE_IOVEC){
+        RBDAIOCB *acb = rcb->acb;
+        iov_memset(acb->qiov->iov, acb->qiov->niov, offs, 0,
+                   acb->qiov->size - offs);
+    } else {
+        memset(rcb->buf + offs, 0, rcb->size - offs);
+    }
+}
+
 static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     Error *local_err = NULL;
@@ -426,11 +444,11 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
         }
     } else {
         if (r < 0) {
-            memset(rcb->buf, 0, rcb->size);
+            qemu_rbd_memset(rcb, 0);
             acb->ret = r;
             acb->error = 1;
         } else if (r < rcb->size) {
-            memset(rcb->buf + r, 0, rcb->size - r);
+            qemu_rbd_memset(rcb, r);
             if (!acb->error) {
                 acb->ret = rcb->size;
             }
@@ -440,11 +458,14 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
     }
 
     g_free(rcb);
-
-    if (acb->cmd == RBD_AIO_READ) {
-        qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
+ 
+    if(!LIBRBD_USE_IOVEC){
+         if (acb->cmd == RBD_AIO_READ) {
+             qemu_iovec_from_buf(acb->qiov, 0, acb->bounce, acb->qiov->size);
+         }
+         qemu_vfree(acb->bounce);
     }
-    qemu_vfree(acb->bounce);
+
     acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
 
     qemu_aio_unref(acb);
@@ -655,7 +676,6 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
     RBDAIOCB *acb;
     RADOSCB *rcb = NULL;
     rbd_completion_t c;
-    char *buf;
     int r;
 
     BDRVRBDState *s = bs->opaque;
@@ -664,27 +684,29 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
     acb->cmd = cmd;
     acb->qiov = qiov;
     assert(!qiov || qiov->size == size);
-    if (cmd == RBD_AIO_DISCARD || cmd == RBD_AIO_FLUSH) {
-        acb->bounce = NULL;
-    } else {
-        acb->bounce = qemu_try_blockalign(bs, qiov->size);
-        if (acb->bounce == NULL) {
-            goto failed;
+
+    rcb = g_new(RADOSCB, 1);
+
+    if(!LIBRBD_USE_IOVEC){
+        if (cmd == RBD_AIO_DISCARD || cmd == RBD_AIO_FLUSH) {
+            acb->bounce = NULL;
+        } else {
+            acb->bounce = qemu_try_blockalign(bs, qiov->size);
+            if (acb->bounce == NULL) {
+                goto failed;
+            }
         }
+        if (cmd == RBD_AIO_WRITE) {
+            qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
+        }
+        rcb->buf = acb->bounce;
     }
+
     acb->ret = 0;
     acb->error = 0;
     acb->s = s;
 
-    if (cmd == RBD_AIO_WRITE) {
-        qemu_iovec_to_buf(acb->qiov, 0, acb->bounce, qiov->size);
-    }
-
-    buf = acb->bounce;
-
-    rcb = g_new(RADOSCB, 1);
     rcb->acb = acb;
-    rcb->buf = buf;
     rcb->s = acb->s;
     rcb->size = size;
     r = rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_finish_aiocb, &c);
@@ -694,10 +716,16 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
 
     switch (cmd) {
     case RBD_AIO_WRITE:
-        r = rbd_aio_write(s->image, off, size, buf, c);
+        if(!LIBRBD_USE_IOVEC)
+            r = rbd_aio_write(s->image, off, size, rcb->buf, c);
+        else
+            r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
         break;
     case RBD_AIO_READ:
-        r = rbd_aio_read(s->image, off, size, buf, c);
+        if(!LIBRBD_USE_IOVEC)
+            r = rbd_aio_read(s->image, off, size, rcb->buf, c);
+        else
+            r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);
         break;
     case RBD_AIO_DISCARD:
         r = rbd_aio_discard_wrapper(s->image, off, size, c);
@@ -712,14 +740,15 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
     if (r < 0) {
         goto failed_completion;
     }
-
     return &acb->common;
 
 failed_completion:
     rbd_aio_release(c);
 failed:
     g_free(rcb);
-    qemu_vfree(acb->bounce);
+    if(!LIBRBD_USE_IOVEC)
+        qemu_vfree(acb->bounce);
+
     qemu_aio_unref(acb);
     return NULL;
 }
-- 
2.10.2

