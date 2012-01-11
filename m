From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: [PATCH v2] rbd: wire up snapshot removal and rollback functionality
Date: Wed, 11 Jan 2012 11:53:52 -0800
Message-ID: <CAF3hT9CSKMepR_rfbKsWUQrbYDJUyYpzsX5FpHXH30E8jBJYLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53413 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757620Ab2AKTxx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jan 2012 14:53:53 -0500
Received: by iabz25 with SMTP id z25so1536048iab.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jan 2012 11:53:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, ceph-devel@vger.kernel.org

Signed-off-by: Greg Farnum <gregory.farnum@dreamhost.com>
---
Remove redundant warnings and add Kevin to the CC.

 block/rbd.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 7a2384c..475e362 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -787,6 +787,26 @@ static int qemu_rbd_snap_create(BlockDriverState *bs,
     return 0;
 }

+static int qemu_rbd_snap_remove(BlockDriverState *bs,
+                                const char *snapshot_name)
+{
+    BDRVRBDState *s = bs->opaque;
+    int r;
+
+    r = rbd_snap_remove(s->image, snapshot_name);
+    return r;
+}
+
+static int qemu_rbd_snap_rollback(BlockDriverState *bs,
+                                  const char *snapshot_name)
+{
+    BDRVRBDState *s = bs->opaque;
+    int r;
+
+    r = rbd_snap_rollback(s->image, snapshot_name);
+    return r;
+}
+
 static int qemu_rbd_snap_list(BlockDriverState *bs,
                               QEMUSnapshotInfo **psn_tab)
 {
@@ -860,7 +880,9 @@ static BlockDriver bdrv_rbd = {
     .bdrv_co_flush_to_disk  = qemu_rbd_co_flush,

     .bdrv_snapshot_create   = qemu_rbd_snap_create,
+    .bdrv_snapshot_delete   = qemu_rbd_snap_remove,
     .bdrv_snapshot_list     = qemu_rbd_snap_list,
+    .bdrv_snapshot_goto     = qemu_rbd_snap_rollback,
 };

 static void bdrv_rbd_init(void)
-- 
1.7.2.5
