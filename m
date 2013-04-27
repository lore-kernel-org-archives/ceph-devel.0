From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/5] rbd: don't clean up watch in device release function
Date: Sat, 27 Apr 2013 14:39:42 -0500
Message-ID: <517C297E.30608@inktank.com>
References: <517C2914.8030400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:37381 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab3D0Tp3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 15:45:29 -0400
Received: by mail-ia0-f173.google.com with SMTP id 21so1210843iay.32
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 12:45:28 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id c2sm9308529igv.1.2013.04.27.12.39.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 12:39:43 -0700 (PDT)
In-Reply-To: <517C2914.8030400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently, a watch on an rbd device header object gets torn down
when its final Linux device reference gets dropped.  Instead, tear
it down when removing the device.  If an error occurs cleaning up
the watch event, abort the unmap request.

All images (including parents) still get watch requests set up, so
tear these down also, in rbd_dev_remove_parent().  For now, ignore
any errors that occur in this case.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c72dcdf..d7a36d1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4713,6 +4713,10 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 {
 	int ret;

+	ret = rbd_dev_header_watch_sync(rbd_dev, 1);
+	if (ret)
+		return ret;
+
 	/* generate unique id: find highest unique id, add one */
 	rbd_dev_id_get(rbd_dev);

@@ -4743,10 +4747,6 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)
 	 * of the sysfs code (initiated by rbd_bus_del_dev()).
 	 */

-	ret = rbd_dev_header_watch_sync(rbd_dev, 1);
-	if (ret)
-		goto err_out_bus;
-
 	ret = rbd_dev_set_mapping(rbd_dev);
 	if (ret)
 		goto err_out_bus;
@@ -4775,6 +4775,7 @@ err_out_id:
 	rbd_dev_id_put(rbd_dev);
 	if (rbd_dev->parent);
 		rbd_dev_remove_parent(rbd_dev);
+	(void)rbd_dev_header_watch_sync(rbd_dev, 0);

 	return ret;
 }
@@ -4970,9 +4971,6 @@ static void rbd_dev_release(struct device *dev)
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

-	if (rbd_dev->watch_event)
-		rbd_dev_header_watch_sync(rbd_dev, 0);
-
 	/* clean up and free blkdev */
 	rbd_free_disk(rbd_dev);
 	unregister_blkdev(rbd_dev->major, rbd_dev->name);
@@ -5007,6 +5005,7 @@ static void rbd_dev_remove_parent(struct
rbd_device *rbd_dev)
 			second = third;
 		}
 		rbd_assert(second);
+		(void)rbd_dev_header_watch_sync(second, 0);
 		rbd_remove_all_snaps(second);
 		rbd_bus_del_dev(second);
 		first->parent = NULL;
@@ -5023,13 +5022,13 @@ static ssize_t rbd_remove(struct bus_type *bus,
 			  size_t count)
 {
 	struct rbd_device *rbd_dev = NULL;
-	int target_id, rc;
+	int target_id;
 	unsigned long ul;
-	int ret = count;
+	int ret;

-	rc = strict_strtoul(buf, 10, &ul);
-	if (rc)
-		return rc;
+	ret = strict_strtoul(buf, 10, &ul);
+	if (ret)
+		return ret;

 	/* convert to int; abort if we lost anything in the conversion */
 	target_id = (int) ul;
@@ -5053,6 +5052,15 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	if (ret < 0)
 		goto done;

+	ret = rbd_dev_header_watch_sync(rbd_dev, 0);
+	if (ret) {
+		rbd_warn(rbd_dev, "error dropping header watch (%d)\n", ret);
+		clear_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
+		smp_mb();
+		return ret;
+	}
+	ret = count;
+
 	if (rbd_dev->parent)
 		rbd_dev_remove_parent(rbd_dev);

-- 
1.7.9.5

