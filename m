From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/4] rbd: rename "node_lock"
Date: Tue, 28 Feb 2012 19:45:45 -0800
Message-ID: <4F4D9F69.9090503@dreamhost.com>
References: <4F4D9F0E.4080804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46384 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030471Ab2B2Dpq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:45:46 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id EADC824314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:45:45 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id CD1FD242C3
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:45:45 -0800 (PST)
In-Reply-To: <4F4D9F0E.4080804@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The spinlock used to protect rbd_client_list is named "node_lock".
Rename it to "rbd_client_list_lock" to make it more obvious what
it's for.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   20 ++++++++++----------
  1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b3c4140..f6dba36 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -179,8 +179,8 @@ static DEFINE_MUTEX(ctl_mutex);	  /* Serialize 
open/close/setup/teardown */
  static LIST_HEAD(rbd_dev_list);    /* devices */
  static DEFINE_SPINLOCK(rbd_dev_list_lock);

-static LIST_HEAD(rbd_client_list);      /* clients */
-static DEFINE_SPINLOCK(node_lock);      /* protects client get/put */
+static LIST_HEAD(rbd_client_list);      	/* clients */
+static DEFINE_SPINLOCK(rbd_client_list_lock);

  static int __rbd_init_snaps_header(struct rbd_device *rbd_dev);
  static void rbd_dev_release(struct device *dev);
@@ -270,9 +270,9 @@ static struct rbd_client *rbd_client_create(struct 
ceph_options *opt,

  	rbdc->rbd_opts = rbd_opts;

-	spin_lock(&node_lock);
+	spin_lock(&rbd_client_list_lock);
  	list_add_tail(&rbdc->node, &rbd_client_list);
-	spin_unlock(&node_lock);
+	spin_unlock(&rbd_client_list_lock);

  	mutex_unlock(&ctl_mutex);

@@ -385,12 +385,12 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,
  		goto done_err;
  	}

-	spin_lock(&node_lock);
+	spin_lock(&rbd_client_list_lock);
  	rbdc = __rbd_client_find(opt);
  	if (rbdc) {
  		/* using an existing client */
  		kref_get(&rbdc->kref);
-		spin_unlock(&node_lock);
+		spin_unlock(&rbd_client_list_lock);

  		rbd_dev->rbd_client = rbdc;

@@ -399,7 +399,7 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,

  		return 0;
  	}
-	spin_unlock(&node_lock);
+	spin_unlock(&rbd_client_list_lock);

  	rbdc = rbd_client_create(opt, rbd_opts);

@@ -418,7 +418,7 @@ done_err:
  /*
   * Destroy ceph client
   *
- * Caller must hold node_lock.
+ * Caller must hold rbd_client_list_lock.
   */
  static void rbd_client_release(struct kref *kref)
  {
@@ -438,9 +438,9 @@ static void rbd_client_release(struct kref *kref)
   */
  static void rbd_put_client(struct rbd_device *rbd_dev)
  {
-	spin_lock(&node_lock);
+	spin_lock(&rbd_client_list_lock);
  	kref_put(&rbd_dev->rbd_client->kref, rbd_client_release);
-	spin_unlock(&node_lock);
+	spin_unlock(&rbd_client_list_lock);
  	rbd_dev->rbd_client = NULL;
  }

-- 
1.7.5.4

