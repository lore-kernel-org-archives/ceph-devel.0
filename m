From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v3 5/5] rbd: fix error handling from rbd_snap_name()
Date: Mon,  9 Sep 2013 00:17:02 -0700
Message-ID: <1378711022-20158-6-git-send-email-josh.durgin@inktank.com>
References: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50661 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3IIH2U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Sep 2013 03:28:20 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 093A626470
	for <ceph-devel@vger.kernel.org>; Mon,  9 Sep 2013 00:32:54 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 030C62646B
	for <ceph-devel@vger.kernel.org>; Mon,  9 Sep 2013 00:32:54 -0700 (PDT)
In-Reply-To: <1378711022-20158-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_snap_name() calls rbd_dev_v{1,2}_snap_name() depending on the
format of the image. The format 1 version returns NULL on error, which
is handled by the caller. The format 2 version returns an ERR_PTR,
which the caller of rbd_snap_name() does not expect.

Fortunately this is unlikely to occur in practice because
rbd_snap_id_by_name() is called before rbd_snap_name(). This would hit
similar errors to rbd_snap_name() (like the snapshot not existing) and
return early, so rbd_snap_name() would not hit an error unless the
snapshot was removed between the two calls or memory was exhausted.

Use an ERR_PTR in rbd_dev_v1_snap_name() so that the specific error
can be propagated, and it is consistent with rbd_dev_v2_snap_name().
Handle the ERR_PTR in the only rbd_snap_name() caller.

Suggested-by: Alex Elder <alex.elder@linaro.org>
Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 226fa04..16384b7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -927,12 +927,14 @@ static const char *rbd_dev_v1_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id)
 {
 	u32 which;
+	const char *snap_name;
 
 	which = rbd_dev_snap_index(rbd_dev, snap_id);
 	if (which == BAD_SNAP_INDEX)
-		return NULL;
+		return ERR_PTR(-ENOENT);
 
-	return _rbd_dev_v1_snap_name(rbd_dev, which);
+	snap_name = _rbd_dev_v1_snap_name(rbd_dev, which);
+	return snap_name ? snap_name : ERR_PTR(-ENOMEM);
 }
 
 static const char *rbd_snap_name(struct rbd_device *rbd_dev, u64 snap_id)
@@ -4163,8 +4165,8 @@ static int rbd_dev_spec_update(struct rbd_device *rbd_dev)
 	/* Look up the snapshot name, and make a copy */
 
 	snap_name = rbd_snap_name(rbd_dev, spec->snap_id);
-	if (!snap_name) {
-		ret = -ENOMEM;
+	if (IS_ERR(snap_name)) {
+		ret = PTR_ERR(snap_name);
 		goto out_err;
 	}
 
-- 
1.7.2.5

