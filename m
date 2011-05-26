From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v6 4/4] rbd: Add bdrv_truncate implementation
Date: Thu, 26 May 2011 16:07:34 -0700
Message-ID: <1306451254-25864-5-git-send-email-josh.durgin__19313.2012420849$1306451530$gmane$org@dreamhost.com>
References: <1306451254-25864-1-git-send-email-josh.durgin@dreamhost.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1306451254-25864-1-git-send-email-josh.durgin@dreamhost.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, qemu-devel@nongnu.orgkvm@vger.kernel.orgqemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, Christian Brunner <chb@muc.de>
List-Id: ceph-devel.vger.kernel.org

Reviewed-by: Christian Brunner <chb@muc.de>
Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index f4da6ab..bdc448a 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -688,6 +688,19 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
     return info.size;
 }
 
+static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset)
+{
+    BDRVRBDState *s = bs->opaque;
+    int r;
+
+    r = rbd_resize(s->image, offset);
+    if (r < 0) {
+        return r;
+    }
+
+    return 0;
+}
+
 static int qemu_rbd_snap_create(BlockDriverState *bs,
                                 QEMUSnapshotInfo *sn_info)
 {
@@ -784,6 +797,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_get_info      = qemu_rbd_getinfo,
     .create_options     = qemu_rbd_create_options,
     .bdrv_getlength     = qemu_rbd_getlength,
+    .bdrv_truncate      = qemu_rbd_truncate,
     .protocol_name      = "rbd",
 
     .bdrv_aio_readv     = qemu_rbd_aio_readv,
-- 
1.7.2.3

