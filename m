From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/5] rbd: protect the rbd_dev_list with a spinlock
Date: Tue, 28 Feb 2012 19:40:10 -0800
Message-ID: <4F4D9E1A.3020402@dreamhost.com>
References: <4F4D9DA5.8050101@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54330 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030724Ab2B2DkL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:40:11 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 32B982432A
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:40:11 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 1B80924329
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:40:11 -0800 (PST)
In-Reply-To: <4F4D9DA5.8050101@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The rbd_dev_list is just a simple list of all the current
rbd_devices.  Using the ctl_mutex as a concurrency guard is
overkill.  Instead, use a spinlock for that specific purpose.

This also reduces the window that the ctl_mutex needs to be held in
rbd_add().

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   33 ++++++++++++++++++++++-----------
  1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0c492e4..e839289 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -174,11 +174,13 @@ static struct bus_type rbd_bus_type = {
  	.name		= "rbd",
  };

-static DEFINE_SPINLOCK(node_lock);      /* protects client get/put */
-
  static DEFINE_MUTEX(ctl_mutex);	  /* Serialize 
open/close/setup/teardown */
+
  static LIST_HEAD(rbd_dev_list);    /* devices */
+static DEFINE_SPINLOCK(rbd_dev_list_lock);
+
  static LIST_HEAD(rbd_client_list);      /* clients */
+static DEFINE_SPINLOCK(node_lock);      /* protects client get/put */

  static int __rbd_init_snaps_header(struct rbd_device *rbd_dev);
  static void rbd_dev_release(struct device *dev);
@@ -2206,12 +2208,12 @@ static ssize_t rbd_add(struct bus_type *bus,
  	INIT_LIST_HEAD(&rbd_dev->snaps);

  	/* generate unique id: one more than highest used so far */
-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-
  	rbd_dev->id = rbd_id_get();

  	/* add to global list */
+	spin_lock(&rbd_dev_list_lock);
  	list_add_tail(&rbd_dev->node, &rbd_dev_list);
+	spin_unlock(&rbd_dev_list_lock);

  	/* parse add command */
  	if (sscanf(buf, "%" __stringify(RBD_MAX_OPT_LEN) "s "
@@ -2235,12 +2237,14 @@ static ssize_t rbd_add(struct bus_type *bus,

  	/* initialize rest of new object */
  	snprintf(rbd_dev->name, DEV_NAME_LEN, DRV_NAME "%d", rbd_dev->id);
+
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
  	rc = rbd_get_client(rbd_dev, mon_dev_name, options);
+	mutex_unlock(&ctl_mutex);
+
  	if (rc < 0)
  		goto err_out_slot;

-	mutex_unlock(&ctl_mutex);
-
  	/* pick the pool */
  	osdc = &rbd_dev->rbd_client->client->osdc;
  	rc = ceph_pg_poolid_by_name(osdc->osdmap, rbd_dev->pool_name);
@@ -2272,9 +2276,9 @@ static ssize_t rbd_add(struct bus_type *bus,
  	return count;

  err_out_bus:
-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	spin_lock(&rbd_dev_list_lock);
  	list_del_init(&rbd_dev->node);
-	mutex_unlock(&ctl_mutex);
+	spin_unlock(&rbd_dev_list_lock);
  	rbd_id_put(target_id);

  	/* this will also clean up rest of rbd_dev stuff */
@@ -2288,10 +2292,10 @@ err_out_blkdev:
  	unregister_blkdev(rbd_dev->major, rbd_dev->name);
  err_out_client:
  	rbd_put_client(rbd_dev);
-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
  err_out_slot:
+	spin_lock(&rbd_dev_list_lock);
  	list_del_init(&rbd_dev->node);
-	mutex_unlock(&ctl_mutex);
+	spin_unlock(&rbd_dev_list_lock);
  	rbd_id_put(target_id);

  	kfree(rbd_dev);
@@ -2310,11 +2314,15 @@ static struct rbd_device *__rbd_get_dev(unsigned 
long id)
  	struct list_head *tmp;
  	struct rbd_device *rbd_dev;

+	spin_lock(&rbd_dev_list_lock);
  	list_for_each(tmp, &rbd_dev_list) {
  		rbd_dev = list_entry(tmp, struct rbd_device, node);
-		if (rbd_dev->id == id)
+		if (rbd_dev->id == id) {
+			spin_unlock(&rbd_dev_list_lock);
  			return rbd_dev;
+		}
  	}
+	spin_unlock(&rbd_dev_list_lock);
  	return NULL;
  }

@@ -2369,7 +2377,10 @@ static ssize_t rbd_remove(struct bus_type *bus,
  		goto done;
  	}

+	spin_lock(&rbd_dev_list_lock);
  	list_del_init(&rbd_dev->node);
+	spin_unlock(&rbd_dev_list_lock);
+
  	rbd_id_put(target_id);

  	__rbd_remove_all_snaps(rbd_dev);
-- 
1.7.5.4

