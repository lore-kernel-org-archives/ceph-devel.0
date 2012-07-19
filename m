From: Alex Elder <elder@inktank.com>
Subject: [PATCH 07/12] rbd: drop rbd_dev parameter in snap functions
Date: Thu, 19 Jul 2012 16:08:44 -0500
Message-ID: <5008775C.2060309@inktank.com>
References: <500874F5.4090205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40265 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab2GSVIq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 17:08:46 -0400
Received: by yenl2 with SMTP id l2so3302595yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 14:08:46 -0700 (PDT)
In-Reply-To: <500874F5.4090205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Both rbd_register_snap_dev() and __rbd_remove_snap_dev() have
rbd_dev parameters that are unused.  Remove them.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3b4b4d2..955d75d 100644
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
@@ -1692,7 +1691,7 @@ static void __rbd_remove_all_snaps(struct
rbd_device *rbd_dev)
 	struct rbd_snap *next;

 	list_for_each_entry_safe(snap, next, &rbd_dev->snaps, node)
-		__rbd_remove_snap_dev(rbd_dev, snap);
+		__rbd_remove_snap_dev(snap);
 }

 /*
@@ -2000,15 +1999,13 @@ static struct device_type rbd_snap_device_type = {
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
@@ -2035,8 +2032,7 @@ static int __rbd_add_snap_dev(struct rbd_device
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
@@ -2101,7 +2097,7 @@ static int __rbd_init_snaps_header(struct
rbd_device *rbd_dev)
 			 */
 			if (rbd_dev->snap_id == old_snap->id)
 				rbd_dev->snap_exists = false;
-			__rbd_remove_snap_dev(rbd_dev, old_snap);
+			__rbd_remove_snap_dev(old_snap);
 			continue;
 		}
 		if (old_snap->id == cur_id) {
@@ -2165,8 +2161,7 @@ static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
 		goto out;

 	list_for_each_entry(snap, &rbd_dev->snaps, node) {
-		ret = rbd_register_snap_dev(rbd_dev, snap,
-					     &rbd_dev->dev);
+		ret = rbd_register_snap_dev(snap, &rbd_dev->dev);
 		if (ret < 0)
 			break;
 	}
-- 
1.7.5.4

