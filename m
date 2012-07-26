From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/7] rbd: drop "object_name" from rbd_req_sync_notify()
Date: Thu, 26 Jul 2012 13:57:39 -0500
Message-ID: <50119323.7080001@inktank.com>
References: <50119076.1030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37892 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab2GZS5l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:57:41 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so2327042ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:57:41 -0700 (PDT)
In-Reply-To: <50119076.1030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_req_sync_notify() only ever uses rbd_dev->header_name as the
value of its "object_name" parameter, and that value is available
within the function already.  So get rid of the parameter.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5cfeeaf..b9aa377 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1323,8 +1323,7 @@ static void rbd_notify_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 /*
  * Request sync osd notify
  */
-static int rbd_req_sync_notify(struct rbd_device *rbd_dev,
-		          const char *object_name)
+static int rbd_req_sync_notify(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_req_op *ops;
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
@@ -1355,7 +1354,8 @@ static int rbd_req_sync_notify(struct rbd_device
*rbd_dev,
 			       0,
 			       CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			       ops,
-			       object_name, 0, 0, NULL, NULL, NULL);
+			       rbd_dev->header_name,
+			       0, 0, NULL, NULL, NULL);
 	if (ret < 0)
 		goto fail_event;

@@ -2647,7 +2647,7 @@ static ssize_t rbd_snap_add(struct device *dev,
 	mutex_unlock(&ctl_mutex);

 	/* make a best effort, don't error if failed */
-	rbd_req_sync_notify(rbd_dev, rbd_dev->header_name);
+	rbd_req_sync_notify(rbd_dev);

 	ret = count;
 	kfree(name);
-- 
1.7.9.5

