From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v3 4/5] rbd: ignore unmapped snapshots that no longer exist
Date: Mon,  9 Sep 2013 00:17:01 -0700
Message-ID: <1378711022-20158-5-git-send-email-josh.durgin@inktank.com>
References: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50660 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3IIH2T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 03:28:19 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 0826226485
	for <ceph-devel@vger.kernel.org>; Mon,  9 Sep 2013 00:32:54 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id EE76626484
	for <ceph-devel@vger.kernel.org>; Mon,  9 Sep 2013 00:32:53 -0700 (PDT)
In-Reply-To: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com>
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
index fe5767a..226fa04 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4078,8 +4078,13 @@ static u64 rbd_v2_snap_id_by_name(struct rbd_device *rbd_dev, const char *name)
 
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

