From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/6] rbd: send header version when notifying
Date: Thu, 19 Jul 2012 07:35:05 -0500
Message-ID: <5007FEF9.8040708@inktank.com>
References: <5007FDEA.9010605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39184 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab2GSMfH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 08:35:07 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so2682359ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 05:35:06 -0700 (PDT)
In-Reply-To: <5007FDEA.9010605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Previously the original header version was sent. Now, we update it
when the header changes.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 988f944..4d3a1e0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1197,7 +1197,7 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 	if (ret < 0)
 		return ret;

-	ops[0].watch.ver = cpu_to_le64(rbd_dev->header.obj_version);
+	ops[0].watch.ver = cpu_to_le64(ver);
 	ops[0].watch.cookie = notify_id;
 	ops[0].watch.flag = 0;

@@ -1216,6 +1216,7 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
 {
 	struct rbd_device *rbd_dev = (struct rbd_device *)data;
+	u64 hver;
 	int rc;

 	if (!rbd_dev)
@@ -1225,12 +1226,13 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		rbd_dev->header_name, notify_id, (int) opcode);
 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 	rc = __rbd_refresh_header(rbd_dev);
+	hver = rbd_dev->header.obj_version;
 	mutex_unlock(&ctl_mutex);
 	if (rc)
 		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
 			   " update snaps: %d\n", rbd_dev->major, rc);

-	rbd_req_sync_notify_ack(rbd_dev, ver, notify_id, rbd_dev->header_name);
+	rbd_req_sync_notify_ack(rbd_dev, hver, notify_id, rbd_dev->header_name);
 }

 /*
@@ -1746,6 +1748,7 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev)
 	/* osd requests may still refer to snapc */
 	ceph_put_snap_context(rbd_dev->header.snapc);

+	rbd_dev->header.obj_version = h.obj_version;
 	rbd_dev->header.image_size = h.image_size;
 	rbd_dev->header.total_snaps = h.total_snaps;
 	rbd_dev->header.snapc = h.snapc;
-- 
1.7.5.4

