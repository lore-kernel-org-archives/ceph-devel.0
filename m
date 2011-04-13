From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v3 3/4] rbd: check return values when scheduling aio
Date: Tue, 12 Apr 2011 17:45:25 -0700
Message-ID: <c5962037945a72d2e8a027aaf770f957cd48984b.1302653035.git.josh.durgin@dreamhost.com>
References: <cover.1302653035.git.josh.durgin@dreamhost.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <cover.1302653035.git.josh.durgin@dreamhost.com>
In-Reply-To: <cover.1302653035.git.josh.durgin@dreamhost.com>
References: <cover.1302653035.git.josh.durgin@dreamhost.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>
List-Id: ceph-devel.vger.kernel.org

If scheduling fails, the number of outstanding I/Os must be correct,
or there will be a hang when waiting for everything to be flushed.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 19014fb..ac20282 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -579,10 +579,14 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
     rbd_completion_t c;
     int64_t off, size;
     char *buf;
+    int r;
 
     BDRVRBDState *s = bs->opaque;
 
     acb = qemu_aio_get(&rbd_aio_pool, bs, cb, opaque);
+    if (!acb) {
+        return NULL;
+    }
     acb->write = write;
     acb->qiov = qiov;
     acb->bounce = qemu_blockalign(bs, qiov->size);
@@ -609,16 +613,28 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
     rcb->buf = buf;
     rcb->s = acb->s;
     rcb->size = size;
+    r = rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_finish_aiocb, &c);
+    if (r < 0) {
+        goto failed;
+    }
 
     if (write) {
-        rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_finish_aiocb, &c);
-        rbd_aio_write(s->image, off, size, buf, c);
+        r = rbd_aio_write(s->image, off, size, buf, c);
     } else {
-        rbd_aio_create_completion(rcb, (rbd_callback_t) rbd_finish_aiocb, &c);
-        rbd_aio_read(s->image, off, size, buf, c);
+        r = rbd_aio_read(s->image, off, size, buf, c);
+    }
+
+    if (r < 0) {
+        goto failed;
     }
 
     return &acb->common;
+
+failed:
+    qemu_free(rcb);
+    s->qemu_aio_count--;
+    qemu_aio_release(acb);
+    return NULL;
 }
 
 static BlockDriverAIOCB *qemu_rbd_aio_readv(BlockDriverState *bs,
-- 
1.7.2.3

