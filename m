From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/5] rbd: tie rbd_dev_list changes to rbd_id operations
Date: Tue, 28 Feb 2012 19:40:12 -0800
Message-ID: <4F4D9E1C.2070906@dreamhost.com>
References: <4F4D9DA5.8050101@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54342 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030724Ab2B2DkM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:40:12 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 9122724314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:40:12 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 722292432C
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:40:12 -0800 (PST)
In-Reply-To: <4F4D9DA5.8050101@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The only time entries are added to or removed from the global
rbd_dev_list is exactly when a "put" or "get" operation is being
performed on a rbd_dev's id.  So just move the list management code
into get/put routines.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   47 +++++++++++++++++++++--------------------------
  1 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e839289..042377b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2153,26 +2153,36 @@ static int rbd_init_watch_dev(struct rbd_device 
*rbd_dev)
  static atomic_t rbd_id_max = ATOMIC_INIT(0);

  /*
- * Get a unique rbd identifier.  The minimum rbd id is 1.
+ * Get a unique rbd identifier for the given new rbd_dev, and add
+ * the rbd_dev to the global list.  The minimum rbd id is 1.
   */
-static int rbd_id_get(void)
+static void rbd_id_get(struct rbd_device *rbd_dev)
  {
-	return atomic_inc_return(&rbd_id_max);
+	rbd_dev->id = atomic_inc_return(&rbd_id_max);
+
+	spin_lock(&rbd_dev_list_lock);
+	list_add_tail(&rbd_dev->node, &rbd_dev_list);
+	spin_unlock(&rbd_dev_list_lock);
  }

  /*
- * Record that an rbd identifier is no longer in use.
+ * Remove an rbd_dev from the global list, and record that its
+ * identifier is no longer in use.
   */
-static void rbd_id_put(int rbd_id)
+static void rbd_id_put(struct rbd_device *rbd_dev)
  {
-	BUG_ON(rbd_id < 1);
+	BUG_ON(rbd_dev->id < 1);
+
+	spin_lock(&rbd_dev_list_lock);
+	list_del_init(&rbd_dev->node);
+	spin_unlock(&rbd_dev_list_lock);

  	/*
  	 * New id's are always one more than the current maximum.
  	 * If the id being "put" *is* that maximum, decrement the
  	 * maximum so the next one requested just reuses this one.
  	 */
-	atomic_cmpxchg(&rbd_id_max, rbd_id, rbd_id - 1);
+	atomic_cmpxchg(&rbd_id_max, rbd_dev->id, rbd_dev->id - 1);
  }

  static ssize_t rbd_add(struct bus_type *bus,
@@ -2208,12 +2218,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  	INIT_LIST_HEAD(&rbd_dev->snaps);

  	/* generate unique id: one more than highest used so far */
-	rbd_dev->id = rbd_id_get();
-
-	/* add to global list */
-	spin_lock(&rbd_dev_list_lock);
-	list_add_tail(&rbd_dev->node, &rbd_dev_list);
-	spin_unlock(&rbd_dev_list_lock);
+	rbd_id_get(rbd_dev);

  	/* parse add command */
  	if (sscanf(buf, "%" __stringify(RBD_MAX_OPT_LEN) "s "
@@ -2276,10 +2281,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  	return count;

  err_out_bus:
-	spin_lock(&rbd_dev_list_lock);
-	list_del_init(&rbd_dev->node);
-	spin_unlock(&rbd_dev_list_lock);
-	rbd_id_put(target_id);
+	rbd_id_put(rbd_dev);

  	/* this will also clean up rest of rbd_dev stuff */

@@ -2293,10 +2295,7 @@ err_out_blkdev:
  err_out_client:
  	rbd_put_client(rbd_dev);
  err_out_slot:
-	spin_lock(&rbd_dev_list_lock);
-	list_del_init(&rbd_dev->node);
-	spin_unlock(&rbd_dev_list_lock);
-	rbd_id_put(target_id);
+	rbd_id_put(rbd_dev);

  	kfree(rbd_dev);
  err_out_opt:
@@ -2377,11 +2376,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
  		goto done;
  	}

-	spin_lock(&rbd_dev_list_lock);
-	list_del_init(&rbd_dev->node);
-	spin_unlock(&rbd_dev_list_lock);
-
-	rbd_id_put(target_id);
+	rbd_id_put(rbd_dev);

  	__rbd_remove_all_snaps(rbd_dev);
  	rbd_bus_del_dev(rbd_dev);
-- 
1.7.5.4

