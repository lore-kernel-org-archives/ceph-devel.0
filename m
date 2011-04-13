From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v3 4/4] rbd: Add bdrv_truncate implementation
Date: Tue, 12 Apr 2011 17:45:26 -0700
Message-ID: <a1fea03a15d0d9b4ecf26cb7b9af7a8ddee96851.1302653035.git.josh.durgin@dreamhost.com>
References: <cover.1302653035.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49715 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab1DMArF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 20:47:05 -0400
In-Reply-To: <cover.1302653035.git.josh.durgin@dreamhost.com>
In-Reply-To: <cover.1302653035.git.josh.durgin@dreamhost.com>
References: <cover.1302653035.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: ceph-devel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 block/rbd.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index ac20282..4514dbd 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -686,6 +686,20 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
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

