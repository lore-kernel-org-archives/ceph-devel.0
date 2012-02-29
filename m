From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/5] rbd: rework calculation of new rbd id's
Date: Tue, 28 Feb 2012 19:40:09 -0800
Message-ID: <4F4D9E19.9070204@dreamhost.com>
References: <4F4D9DA5.8050101@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54322 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030724Ab2B2DkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:40:09 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id C756524318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:40:09 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id ACFFC24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:40:09 -0800 (PST)
In-Reply-To: <4F4D9DA5.8050101@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In order to select a new unique identifier for an added rbd device,
the list of all existing ones is searched and a value one greater
than the highest id is used.

The list search can be avoided by using an atomic variable that
keeps track of the current highest id.  Using a get/put model for
id's we can limit the boundless growth of id numbers a bit by
arranging to reuse the current highest id once it gets released.
Add these calls to "put" the id when an rbd is getting removed.

Note that this changes the pattern of device id's used--new values
will never be below the highest one seen so far (even if there
exists an unused lower one).  I assert this is OK because the key
property of an rbd id is its uniqueness, not its magnitude.

Regardless, a follow-on patch will restore the old way of doing
things, I just think this commit just makes the incremental change
to atomics a little easier to understand.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   35 +++++++++++++++++++++++------------
  1 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 35290b1..0c492e4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2148,21 +2148,29 @@ static int rbd_init_watch_dev(struct rbd_device 
*rbd_dev)
  	return ret;
  }

-/* caller must hold ctl_mutex */
+static atomic_t rbd_id_max = ATOMIC_INIT(0);
+
+/*
+ * Get a unique rbd identifier.  The minimum rbd id is 1.
+ */
  static int rbd_id_get(void)
  {
-	struct list_head *tmp;
-	int new_id = 0;
-
-	list_for_each(tmp, &rbd_dev_list) {
-		struct rbd_device *rbd_dev;
+	return atomic_inc_return(&rbd_id_max);
+}

-		rbd_dev = list_entry(tmp, struct rbd_device, node);
-		if (rbd_dev->id >= new_id)
-			new_id = rbd_dev->id + 1;
-	}
+/*
+ * Record that an rbd identifier is no longer in use.
+ */
+static void rbd_id_put(int rbd_id)
+{
+	BUG_ON(rbd_id < 1);

-	return new_id;
+	/*
+	 * New id's are always one more than the current maximum.
+	 * If the id being "put" *is* that maximum, decrement the
+	 * maximum so the next one requested just reuses this one.
+	 */
+	atomic_cmpxchg(&rbd_id_max, rbd_id, rbd_id - 1);
  }

  static ssize_t rbd_add(struct bus_type *bus,
@@ -2197,7 +2205,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  	INIT_LIST_HEAD(&rbd_dev->node);
  	INIT_LIST_HEAD(&rbd_dev->snaps);

-	/* generate unique id: find highest unique id, add one */
+	/* generate unique id: one more than highest used so far */
  	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);

  	rbd_dev->id = rbd_id_get();
@@ -2267,6 +2275,7 @@ err_out_bus:
  	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
  	list_del_init(&rbd_dev->node);
  	mutex_unlock(&ctl_mutex);
+	rbd_id_put(target_id);

  	/* this will also clean up rest of rbd_dev stuff */

@@ -2283,6 +2292,7 @@ err_out_client:
  err_out_slot:
  	list_del_init(&rbd_dev->node);
  	mutex_unlock(&ctl_mutex);
+	rbd_id_put(target_id);

  	kfree(rbd_dev);
  err_out_opt:
@@ -2360,6 +2370,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
  	}

  	list_del_init(&rbd_dev->node);
+	rbd_id_put(target_id);

  	__rbd_remove_all_snaps(rbd_dev);
  	rbd_bus_del_dev(rbd_dev);
-- 
1.7.5.4

