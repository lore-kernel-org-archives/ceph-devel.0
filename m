From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] rbd: rename rbd_id_get()
Date: Fri, 07 Sep 2012 08:39:24 -0500
Message-ID: <5049F90C.5040504@inktank.com>
References: <5049F7F5.1070609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60946 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759156Ab2IGNjZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 09:39:25 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so5001652iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 06:39:25 -0700 (PDT)
In-Reply-To: <5049F7F5.1070609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This should have been done as part of this commit:

    commit de71a2970d57463d3d965025e33ec3adcf391248
    Author: Alex Elder <elder@inktank.com>
    Date:   Tue Jul 3 16:01:19 2012 -0500
    rbd: rename rbd_device->id

rbd_id_get() is assigning the rbd_dev->dev_id field.  Change the
name of that function as well as rbd_id_put() and rbd_id_max
to reflect what they are affecting.

Add some dynamic debug statements related to rbd device id activity.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d84b534..8cb8e0a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2304,26 +2304,28 @@ static int rbd_init_watch_dev(struct rbd_device
*rbd_dev)
 	return ret;
 }

-static atomic64_t rbd_id_max = ATOMIC64_INIT(0);
+static atomic64_t rbd_dev_id_max = ATOMIC64_INIT(0);

 /*
  * Get a unique rbd identifier for the given new rbd_dev, and add
  * the rbd_dev to the global list.  The minimum rbd id is 1.
  */
-static void rbd_id_get(struct rbd_device *rbd_dev)
+static void rbd_dev_id_get(struct rbd_device *rbd_dev)
 {
-	rbd_dev->dev_id = atomic64_inc_return(&rbd_id_max);
+	rbd_dev->dev_id = atomic64_inc_return(&rbd_dev_id_max);

 	spin_lock(&rbd_dev_list_lock);
 	list_add_tail(&rbd_dev->node, &rbd_dev_list);
 	spin_unlock(&rbd_dev_list_lock);
+	dout("rbd_dev %p given dev id %llu\n", rbd_dev,
+		(unsigned long long) rbd_dev->dev_id);
 }

 /*
  * Remove an rbd_dev from the global list, and record that its
  * identifier is no longer in use.
  */
-static void rbd_id_put(struct rbd_device *rbd_dev)
+static void rbd_dev_id_put(struct rbd_device *rbd_dev)
 {
 	struct list_head *tmp;
 	int rbd_id = rbd_dev->dev_id;
@@ -2331,6 +2333,8 @@ static void rbd_id_put(struct rbd_device *rbd_dev)

 	rbd_assert(rbd_id > 0);

+	dout("rbd_dev %p released dev id %llu\n", rbd_dev,
+		(unsigned long long) rbd_dev->dev_id);
 	spin_lock(&rbd_dev_list_lock);
 	list_del_init(&rbd_dev->node);

@@ -2338,7 +2342,7 @@ static void rbd_id_put(struct rbd_device *rbd_dev)
 	 * If the id being "put" is not the current maximum, there
 	 * is nothing special we need to do.
 	 */
-	if (rbd_id != atomic64_read(&rbd_id_max)) {
+	if (rbd_id != atomic64_read(&rbd_dev_id_max)) {
 		spin_unlock(&rbd_dev_list_lock);
 		return;
 	}
@@ -2359,12 +2363,13 @@ static void rbd_id_put(struct rbd_device *rbd_dev)
 	spin_unlock(&rbd_dev_list_lock);

 	/*
-	 * The max id could have been updated by rbd_id_get(), in
+	 * The max id could have been updated by rbd_dev_id_get(), in
 	 * which case it now accurately reflects the new maximum.
 	 * Be careful not to overwrite the maximum value in that
 	 * case.
 	 */
-	atomic64_cmpxchg(&rbd_id_max, rbd_id, max_id);
+	atomic64_cmpxchg(&rbd_dev_id_max, rbd_id, max_id);
+	dout("  max dev id has been reset\n");
 }

 /*
@@ -2563,7 +2568,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 	init_rwsem(&rbd_dev->header_rwsem);

 	/* generate unique id: find highest unique id, add one */
-	rbd_id_get(rbd_dev);
+	rbd_dev_id_get(rbd_dev);

 	/* Fill in the device name, now that we have its id. */
 	BUILD_BUG_ON(DEV_NAME_LEN
@@ -2631,7 +2636,7 @@ err_put_id:
 		kfree(rbd_dev->image_name);
 		kfree(rbd_dev->pool_name);
 	}
-	rbd_id_put(rbd_dev);
+	rbd_dev_id_put(rbd_dev);
 err_nomem:
 	kfree(rbd_dev);
 	kfree(options);
@@ -2683,7 +2688,7 @@ static void rbd_dev_release(struct device *dev)
 	kfree(rbd_dev->header_name);
 	kfree(rbd_dev->pool_name);
 	kfree(rbd_dev->image_name);
-	rbd_id_put(rbd_dev);
+	rbd_dev_id_put(rbd_dev);
 	kfree(rbd_dev);

 	/* release module ref */
-- 
1.7.9.5

