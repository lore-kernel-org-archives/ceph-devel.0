From: jazeltq@gmail.com
Subject: [PATCH] RBD: Add support readv,writev for rbd
Date: Sat,  5 Nov 2016 13:17:21 +0800
Message-ID: <20161105051721.80186-1-jazeltq@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34267 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbcKEFRh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Nov 2016 01:17:37 -0400
Received: by mail-qk0-f196.google.com with SMTP id 124so750603qkh.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2016 22:17:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jdurgin@redhat.com, jcody@redhat.com, jdillama@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, tianqing <tianqing@unitedstack.com>

From: tianqing <tianqing@unitedstack.com>

Rbd can do readv and writev directly, so wo do not need to transform
iov to buf or vice versa any more.

Signed-off-by: tianqing <tianqing@unitedstack.com>
---
 block/rbd.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index a57b3e3..a405c02 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -53,6 +53,13 @@
 #undef LIBRBD_SUPPORTS_DISCARD
 #endif
 
+/* rbd_aio_readv, rbd_aio_writev added in 0.1.11 */
+#if LIBRBD_VERSION_CODE >= LIBRBD_VERSION(0, 1, 11)
+#define LIBRBD_SUPPORTS_IOV
+#else
+#undef LIBRBD_SUPPORTS_IOV
+#endif
+
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
 
 #define RBD_MAX_CONF_NAME_SIZE 128
@@ -73,7 +80,10 @@ typedef struct RBDAIOCB {
     BlockAIOCB common;
     int64_t ret;
     QEMUIOVector *qiov;
+#ifdef LIBRBD_SUPPORTS_IOV
+#else
     char *bounce;
+#endif
     RBDAIOCmd cmd;
     int error;
     struct BDRVRBDState *s;
@@ -83,7 +93,10 @@ typedef struct RADOSCB {
     RBDAIOCB *acb;
     struct BDRVRBDState *s;
     int64_t size;
+#ifdef LIBRBD_SUPPORTS_IOV
+#else
     char *buf;
+#endif
     int64_t ret;
 } RADOSCB;
 
@@ -406,6 +419,48 @@ shutdown:
     return ret;
 }
 
+
+#ifdef LIBRBD_SUPPORTS_IOV
+/*
+ * This aio completion is being called from rbd_finish_bh() and runs in qemu
+ * BH context.
+ */
+static void qemu_rbd_complete_aio(RADOSCB *rcb)
+{
+    RBDAIOCB *acb = rcb->acb;
+    int64_t r;
+
+    r = rcb->ret;
+
+    if (acb->cmd != RBD_AIO_READ) {
+        if (r < 0) {
+            acb->ret = r;
+            acb->error = 1;
+        } else if (!acb->error) {
+            acb->ret = rcb->size;
+        }
+    } else {
+        if (r < 0) {
+            iov_memset(acb->qiov->iov, acb->qiov->niov, 0, 0, acb->qiov->size);
+            acb->ret = r;
+            acb->error = 1;
+        } else if (r < rcb->size) {
+            iov_memset(acb->qiov->iov, acb->qiov->niov,
+                       rcb->size - r, 0, acb->qiov->size);
+            if (!acb->error) {
+                acb->ret = rcb->size;
+            }
+        } else if (!acb->error) {
+            acb->ret = r;
+        }
+    }
+
+    g_free(rcb);
+    acb->common.cb(acb->common.opaque, (acb->ret > 0 ? 0 : acb->ret));
+
+    qemu_aio_unref(acb);
+}
+#else
 /*
  * This aio completion is being called from rbd_finish_bh() and runs in qemu
  * BH context.
@@ -449,6 +504,7 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
 
     qemu_aio_unref(acb);
 }
+#endif
 
 /* TODO Convert to fine grained options */
 static QemuOptsList runtime_opts = {
@@ -644,6 +700,73 @@ static int rbd_aio_flush_wrapper(rbd_image_t image,
 #endif
 }
 
+#ifdef LIBRBD_SUPPORTS_IOV
+static BlockAIOCB *rbd_start_aio_vec(BlockDriverState *bs,
+                                 int64_t off,
+                                 QEMUIOVector *qiov,
+                                 int64_t size,
+                                 BlockCompletionFunc *cb,
+                                 void *opaque,
+                                 RBDAIOCmd cmd)
+{
+    RBDAIOCB *acb;
+    RADOSCB *rcb = NULL;
+    rbd_completion_t c;
+    int r;
+
+    BDRVRBDState *s = bs->opaque;
+
+    acb = qemu_aio_get(&rbd_aiocb_info, bs, cb, opaque);
+    acb->cmd = cmd;
+    acb->qiov = qiov;
+    assert(!qiov || qiov->size == size);
+
+    acb->ret = 0;
+    acb->error = 0;
+    acb->s = s;
+
+    rcb = g_new(RADOSCB, 1);
+    rcb->acb = acb;
+    rcb->s = acb->s;
+    rcb->size = size;
+    r = rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_finish_aiocb, &c);
+    if (r < 0) {
+        goto failed;
+    }
+
+    switch (cmd) {
+    case RBD_AIO_WRITE:
+        r = rbd_aio_writev(s->image, qiov->iov, qiov->niov, off, c);
+        break;
+    case RBD_AIO_READ:
+        r = rbd_aio_readv(s->image, qiov->iov, qiov->niov, off, c);
+        break;
+    case RBD_AIO_DISCARD:
+        r = rbd_aio_discard_wrapper(s->image, off, size, c);
+        break;
+    case RBD_AIO_FLUSH:
+        r = rbd_aio_flush_wrapper(s->image, c);
+        break;
+    default:
+        r = -EINVAL;
+    }
+
+    if (r < 0) {
+        goto failed_completion;
+    }
+
+    return &acb->common;
+
+failed_completion:
+    rbd_aio_release(c);
+failed:
+    g_free(rcb);
+    qemu_aio_unref(acb);
+    return NULL;
+
+}
+
+#else
 static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
                                  int64_t off,
                                  QEMUIOVector *qiov,
@@ -723,6 +846,7 @@ failed:
     qemu_aio_unref(acb);
     return NULL;
 }
+#endif
 
 static BlockAIOCB *qemu_rbd_aio_readv(BlockDriverState *bs,
                                       int64_t sector_num,
-- 
2.10.2

