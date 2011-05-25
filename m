From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v5 4/4] rbd: Add bdrv_truncate implementation
Date: Wed, 25 May 2011 13:34:47 -0700
Message-ID: <1306355687-4647-5-git-send-email-josh.durgin__12564.0505728827$1306356022$gmane$org@dreamhost.com>
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

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index a44d160..b95b1eb 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -688,6 +688,20 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
     return info.size;
 }
 
+static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset)
+{
+    BDRVRBDState *s = bs->opaque;
+    int r;
+
+    r = rbd_resize(s->image, offset);
+    if (r < 0) {
+        error_report("failed to resize rbd image");
+        return -EIO;
+    }
+
+    return 0;
+}
+
 static int qemu_rbd_snap_create(BlockDriverState *bs,
                                 QEMUSnapshotInfo *sn_info)
 {
@@ -784,6 +798,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_get_info      = qemu_rbd_getinfo,
     .create_options     = qemu_rbd_create_options,
     .bdrv_getlength     = qemu_rbd_getlength,
+    .bdrv_truncate      = qemu_rbd_truncate,
     .protocol_name      = "rbd",
 
     .bdrv_aio_readv     = qemu_rbd_aio_readv,
-- 
1.7.2.3
