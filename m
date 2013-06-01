From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] rbd: set removing flag while holding list lock
Date: Fri, 31 May 2013 20:18:55 -0500
Message-ID: <51A94BFF.5050406@inktank.com>
References: <51A94BC0.4080703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48357 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab3FABS5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 21:18:57 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so5774290ief.12
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 18:18:57 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id r20sm5829664ign.8.2013.05.31.18.18.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 May 2013 18:18:56 -0700 (PDT)
In-Reply-To: <51A94BC0.4080703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

When unmapping a device, its id is supplied, and that is used to
look up which rbd device should be unmapped.  Looking up the
device involves searching the rbd device list while holding
a spinlock that protects access to that list.

Currently all of this is done under protection of the control lock,
but that protection is going away soon.  To ensure the rbd_dev is
still valid (still on the list) while setting its REMOVING flag, do
so while still holding the list lock.  To do so, get rid of
__rbd_get_dev(), and open code what it did in the one place it
was used.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   53
+++++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index aace658..716ef1f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5106,23 +5106,6 @@ err_out_module:
 	return (ssize_t)rc;
 }

-static struct rbd_device *__rbd_get_dev(unsigned long dev_id)
-{
-	struct list_head *tmp;
-	struct rbd_device *rbd_dev;
-
-	spin_lock(&rbd_dev_list_lock);
-	list_for_each(tmp, &rbd_dev_list) {
-		rbd_dev = list_entry(tmp, struct rbd_device, node);
-		if (rbd_dev->dev_id == dev_id) {
-			spin_unlock(&rbd_dev_list_lock);
-			return rbd_dev;
-		}
-	}
-	spin_unlock(&rbd_dev_list_lock);
-	return NULL;
-}
-
 static void rbd_dev_device_release(struct device *dev)
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
@@ -5167,7 +5150,8 @@ static ssize_t rbd_remove(struct bus_type *bus,
 			  size_t count)
 {
 	struct rbd_device *rbd_dev = NULL;
-	int target_id;
+	struct list_head *tmp;
+	int dev_id;
 	unsigned long ul;
 	int ret;

@@ -5176,26 +5160,33 @@ static ssize_t rbd_remove(struct bus_type *bus,
 		return ret;

 	/* convert to int; abort if we lost anything in the conversion */
-	target_id = (int) ul;
-	if (target_id != ul)
+	dev_id = (int)ul;
+	if (dev_id != ul)
 		return -EINVAL;

 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);

-	rbd_dev = __rbd_get_dev(target_id);
-	if (!rbd_dev) {
-		ret = -ENOENT;
-		goto done;
+	ret = -ENOENT;
+	spin_lock(&rbd_dev_list_lock);
+	list_for_each(tmp, &rbd_dev_list) {
+		rbd_dev = list_entry(tmp, struct rbd_device, node);
+		if (rbd_dev->dev_id == dev_id) {
+			ret = 0;
+			break;
+		}
 	}
-
-	spin_lock_irq(&rbd_dev->lock);
-	if (rbd_dev->open_count)
-		ret = -EBUSY;
-	else
-		set_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
-	spin_unlock_irq(&rbd_dev->lock);
+	if (!ret) {
+		spin_lock_irq(&rbd_dev->lock);
+		if (rbd_dev->open_count)
+			ret = -EBUSY;
+		else
+			set_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
+		spin_unlock_irq(&rbd_dev->lock);
+	}
+	spin_unlock(&rbd_dev_list_lock);
 	if (ret < 0)
 		goto done;
+
 	rbd_bus_del_dev(rbd_dev);
 	ret = rbd_dev_header_watch_sync(rbd_dev, false);
 	if (ret)
-- 
1.7.9.5

