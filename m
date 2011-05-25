From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v5 3/4] rbd: check return values when
	scheduling aio
Date: Wed, 25 May 2011 13:34:46 -0700
Message-ID: <1306355687-4647-4-git-send-email-josh.durgin__2739.82739677212$1306355974$gmane$org@dreamhost.com>
References: <1306355687-4647-1-git-send-email-josh.durgin@dreamhost.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1306355687-4647-1-git-send-email-josh.durgin@dreamhost.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: kvm@vger.kernel.org, qemu-devel@nongnu.orgkvm@vger.kernel.orgqemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>
List-Id: ceph-devel.vger.kernel.org

If scheduling fails, the number of outstanding I/Os must be correct,
or there will be a hang when waiting for everything to be flushed.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index d346a21..a44d160 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -581,10 +581,14 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
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
@@ -611,16 +615,28 @@ static BlockDriverAIOCB *rbd_aio_rw_vector(BlockDriverState *bs,
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
