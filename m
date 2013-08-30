From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH] rbd: ignore unmapped snapshots that no longer exist
Date: Thu, 29 Aug 2013 19:19:00 -0700
Message-ID: <1377829140-13635-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39766 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab3H3CbS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 22:31:18 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 1CEA6263CB
	for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 19:35:12 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 05404263BD
	for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 19:35:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This prevents erroring out while adding a device when a snapshot
unrelated to the current mapping is deleted between reading the
snapshot context and reading the snapshot names. If the mapped
snapshot name is not found an error still occurs as usual.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0e83a10..545ceff 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4077,8 +4077,13 @@ static u64 rbd_v2_snap_id_by_name(struct rbd_device *rbd_dev, const char *name)
 
 		snap_id = snapc->snaps[which];
 		snap_name = rbd_dev_v2_snap_name(rbd_dev, snap_id);
-		if (IS_ERR(snap_name))
-			break;
+		if (IS_ERR(snap_name)) {
+			/* ignore no-longer existing snapshots */
+			if (PTR_ERR(snap_name) == -ENOENT)
+				continue;
+			else
+				break;
+		}
 		found = !strcmp(name, snap_name);
 		kfree(snap_name);
 	}
-- 
1.7.2.5

