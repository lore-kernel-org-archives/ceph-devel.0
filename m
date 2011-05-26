From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v6 3/4] rbd: check return values when scheduling aio
Date: Thu, 26 May 2011 16:07:33 -0700
Message-ID: <1306451254-25864-4-git-send-email-josh.durgin__16584.1671209366$1306451526$gmane$org@dreamhost.com>
References: <1306451254-25864-1-git-send-email-josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49527 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533Ab1EZXLw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2011 19:11:52 -0400
In-Reply-To: <1306451254-25864-1-git-send-email-josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kvm@vger.kernel.org, qemu-devel@nongnu.orgkvm@vger.kernel.orgqemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, Christian Brunner <chb@muc.de>

If scheduling fails, the number of outstanding I/Os must be correct,
or there will be a hang when waiting for everything to be flushed.

Reviewed-by: Christian Brunner <chb@muc.de>
Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index edf1086..f4da6ab 100644
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

