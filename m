From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/7] rbd: drop rbd_dev parameter in snap functions
Date: Thu, 26 Jul 2012 13:57:29 -0500
Message-ID: <50119319.4050400@inktank.com>
References: <50119076.1030307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54228 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab2GZS5b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 14:57:31 -0400
Received: by yhmm54 with SMTP id m54so2338429yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 11:57:30 -0700 (PDT)
In-Reply-To: <50119076.1030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Both rbd_register_snap_dev() and __rbd_remove_snap_dev() have
rbd_dev parameters that are unused.  Remove them.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 597ebaa..a748448 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -202,8 +202,7 @@ static ssize_t rbd_snap_add(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf,
 			    size_t count);
-static void __rbd_remove_snap_dev(struct rbd_device *rbd_dev,
-				  struct rbd_snap *snap);
+static void __rbd_remove_snap_dev(struct rbd_snap *snap);

 static ssize_t rbd_add(struct bus_type *bus, const char *buf,
 		       size_t count);
@@ -1698,7 +1697,7 @@ static void __rbd_remove_all_snaps(struct
rbd_device *rbd_dev)
 	struct rbd_snap *next;

 	list_for_each_entry_safe(snap, next, &rbd_dev->snaps, node)
-		__rbd_remove_snap_dev(rbd_dev, snap);
+		__rbd_remove_snap_dev(snap);
 }

 /*
@@ -2006,15 +2005,13 @@ static struct device_type rbd_snap_device_type = {
 	.release	= rbd_snap_dev_release,
 };

-static void __rbd_remove_snap_dev(struct rbd_device *rbd_dev,
-				  struct rbd_snap *snap)
+static void __rbd_remove_snap_dev(struct rbd_snap *snap)
 {
 	list_del(&snap->node);
 	device_unregister(&snap->dev);
 }

-static int rbd_register_snap_dev(struct rbd_device *rbd_dev,
-				  struct rbd_snap *snap,
+static int rbd_register_snap_dev(struct rbd_snap *snap,
 				  struct device *parent)
 {
 	struct device *dev = &snap->dev;
@@ -2041,8 +2038,7 @@ static int __rbd_add_snap_dev(struct rbd_device
*rbd_dev,
 	snap->size = rbd_dev->header.snap_sizes[i];
 	snap->id = rbd_dev->header.snapc->snaps[i];
 	if (device_is_registered(&rbd_dev->dev)) {
-		ret = rbd_register_snap_dev(rbd_dev, snap,
-					     &rbd_dev->dev);
+		ret = rbd_register_snap_dev(snap, &rbd_dev->dev);
 		if (ret < 0)
 			goto err;
 	}
@@ -2107,7 +2103,7 @@ static int __rbd_init_snaps_header(struct
rbd_device *rbd_dev)
 			 */
 			if (rbd_dev->snap_id == old_snap->id)
 				rbd_dev->snap_exists = false;
-			__rbd_remove_snap_dev(rbd_dev, old_snap);
+			__rbd_remove_snap_dev(old_snap);
 			continue;
 		}
 		if (old_snap->id == cur_id) {
@@ -2171,8 +2167,7 @@ static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
 		goto out;

 	list_for_each_entry(snap, &rbd_dev->snaps, node) {
-		ret = rbd_register_snap_dev(rbd_dev, snap,
-					     &rbd_dev->dev);
+		ret = rbd_register_snap_dev(snap, &rbd_dev->dev);
 		if (ret < 0)
 			break;
 	}
-- 
1.7.9.5

