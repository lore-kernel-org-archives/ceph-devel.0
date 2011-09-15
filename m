From: Sage Weil <sage@newdream.net>
Subject: [PATCH 4/4] rbd: call flush, if available
Date: Thu, 15 Sep 2011 14:11:11 -0700
Message-ID: <1316121071-7690-5-git-send-email-sage@newdream.net>
References: <1316121071-7690-1-git-send-email-sage@newdream.net>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1316121071-7690-1-git-send-email-sage@newdream.net>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>
List-Id: ceph-devel.vger.kernel.org

librbd recently added async writeback and flush support.  If the new
rbd_flush() call is available, call it.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 block/rbd.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 202e7ec..af65924 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -705,6 +705,17 @@ static BlockDriverAIOCB *qemu_rbd_aio_writev(BlockDriverState *bs,
     return rbd_aio_rw_vector(bs, sector_num, qiov, nb_sectors, cb, opaque, 1);
 }
 
+static int qemu_rbd_flush(BlockDriverState *bs)
+{
+#if LIBRBD_VERSION_CODE >= LIBRBD_VERSION(0, 1, 1)
+    /* rbd_flush added in 0.1.1 */
+    BDRVRBDState *s = bs->opaque;
+    return rbd_flush(s->image);
+#else
+    return 0;
+#endif
+}
+
 static int qemu_rbd_getinfo(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVRBDState *s = bs->opaque;
@@ -840,6 +851,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_file_open     = qemu_rbd_open,
     .bdrv_close         = qemu_rbd_close,
     .bdrv_create        = qemu_rbd_create,
+    .bdrv_flush         = qemu_rbd_flush,
     .bdrv_get_info      = qemu_rbd_getinfo,
     .create_options     = qemu_rbd_create_options,
     .bdrv_getlength     = qemu_rbd_getlength,
-- 
1.7.2.5
