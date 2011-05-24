From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v4 4/4] rbd: Add bdrv_truncate implementation
Date: Tue, 24 May 2011 11:51:18 -0700
Message-ID: <1306263078-18089-5-git-send-email-josh.durgin__31812.4486403123$1306263339$gmane$org@dreamhost.com>
References: <1306263078-18089-1-git-send-email-josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46157 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918Ab1EXSzX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 14:55:23 -0400
In-Reply-To: <1306263078-18089-1-git-send-email-josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kvm@vger.kernel.org, qemu-devel@nongnu.orgkvm@vger.kernel.orgqemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, Christian Brunner <chb@muc.de>

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index c9f32e4..015ae8e 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -687,6 +687,20 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
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
@@ -785,6 +799,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_get_info      = qemu_rbd_getinfo,
     .create_options     = qemu_rbd_create_options,
     .bdrv_getlength     = qemu_rbd_getlength,
+    .bdrv_truncate      = qemu_rbd_truncate,
     .protocol_name      = "rbd",
 
     .bdrv_aio_readv     = qemu_rbd_aio_readv,
-- 
1.7.2.3

