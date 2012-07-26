From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/7] rbd: drop "object_name" from rbd_req_sync_watch()
Date: Thu, 26 Jul 2012 13:57:34 -0500
Message-ID: <5011931E.8040409@inktank.com>
References: <50119076.1030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37892 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab2GZS5g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:57:36 -0400
Received: by gglu4 with SMTP id u4so2327042ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:57:35 -0700 (PDT)
In-Reply-To: <50119076.1030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_req_sync_watch() is only called in one place, and in that place
it passes rbd_dev->header_name as the value of the "object_name"
parameter.  This value is available within the function already.

Having the extra parameter leaves the impression the object name
could take on different values, but it does not.

So get rid of the parameter.  We can always add it back again if
we find we want to watch some other object in the future.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a748448..5cfeeaf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1236,9 +1236,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 /*
  * Request sync osd watch
  */
-static int rbd_req_sync_watch(struct rbd_device *rbd_dev,
-			      const char *object_name,
-			      u64 ver)
+static int rbd_req_sync_watch(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_req_op *ops;
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
@@ -1252,7 +1250,7 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev,
 	if (ret < 0)
 		goto fail;

-	ops[0].watch.ver = cpu_to_le64(ver);
+	ops[0].watch.ver = cpu_to_le64(rbd_dev->header.obj_version);
 	ops[0].watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
 	ops[0].watch.flag = 1;

@@ -1261,7 +1259,8 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev,
 			      0,
 			      CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
 			      ops,
-			      object_name, 0, 0, NULL,
+			      rbd_dev->header_name,
+			      0, 0, NULL,
 			      &rbd_dev->watch_request, NULL);

 	if (ret < 0)
@@ -2186,8 +2185,7 @@ static int rbd_init_watch_dev(struct rbd_device
*rbd_dev)
 	int ret, rc;

 	do {
-		ret = rbd_req_sync_watch(rbd_dev, rbd_dev->header_name,
-					 rbd_dev->header.obj_version);
+		ret = rbd_req_sync_watch(rbd_dev);
 		if (ret == -ERANGE) {
 			mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 			rc = __rbd_refresh_header(rbd_dev);
-- 
1.7.9.5

