From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: kill rbd_init_watch_dev()
Date: Thu, 26 Jul 2012 14:11:18 -0500
Message-ID: <50119656.9080709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61293 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2GZTLU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 15:11:20 -0400
Received: by gglu4 with SMTP id u4so2344356ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 12:11:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When an rbd image is mapped, a watch request is issued so that the
client will get notified in the event the image header object
changes.  This is done using rbd_init_watch_dev(), which calls
rbd_req_sync_watch().

rbd_init_watch_dev() is organized as a loop, arranging to re-issue
the request after refreshing the header if -ERANGE ever gets
returned.  But the only way rbd_req_sync_watch() will return -ERANGE
is if the CEPH_OSD_OP_WATCH operation returns that, which it will
not.

As a result, the whole looping structure and in fact the whole
function becomes excessive.  So get rid of rbd_init_watch_dev(),
and call rbd_req_sync_watch() directly in the one place it's used.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 94d0745..71e3f3b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2191,22 +2191,6 @@ static void rbd_bus_del_dev(struct rbd_device
*rbd_dev)
 	device_unregister(&rbd_dev->dev);
 }

-static int rbd_init_watch_dev(struct rbd_device *rbd_dev)
-{
-	int ret, rc;
-
-	do {
-		ret = rbd_req_sync_watch(rbd_dev);
-		if (ret == -ERANGE) {
-			rc = rbd_refresh_header(rbd_dev, NULL);
-			if (rc < 0)
-				return rc;
-		}
-	} while (ret == -ERANGE);
-
-	return ret;
-}
-
 static atomic64_t rbd_id_max = ATOMIC64_INIT(0);

 /*
@@ -2510,7 +2494,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 	if (rc)
 		goto err_out_bus;

-	rc = rbd_init_watch_dev(rbd_dev);
+	rc = rbd_req_sync_watch(rbd_dev);
 	if (rc)
 		goto err_out_bus;

-- 
1.7.9.5

