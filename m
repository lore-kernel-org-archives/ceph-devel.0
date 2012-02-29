From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/5] rbd: encapsulate new rbd id selection
Date: Tue, 28 Feb 2012 19:40:07 -0800
Message-ID: <4F4D9E17.6000302@dreamhost.com>
References: <4F4D9DA5.8050101@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54319 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030724Ab2B2DkI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:40:08 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 1AFFF24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:40:08 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 11A7A24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:40:08 -0800 (PST)
In-Reply-To: <4F4D9DA5.8050101@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move the loop that finds a new unique rbd id to use into
its own helper function.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   30 +++++++++++++++++++-----------
  1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 25ed3c0..35290b1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2148,6 +2148,23 @@ static int rbd_init_watch_dev(struct rbd_device 
*rbd_dev)
  	return ret;
  }

+/* caller must hold ctl_mutex */
+static int rbd_id_get(void)
+{
+	struct list_head *tmp;
+	int new_id = 0;
+
+	list_for_each(tmp, &rbd_dev_list) {
+		struct rbd_device *rbd_dev;
+
+		rbd_dev = list_entry(tmp, struct rbd_device, node);
+		if (rbd_dev->id >= new_id)
+			new_id = rbd_dev->id + 1;
+	}
+
+	return new_id;
+}
+
  static ssize_t rbd_add(struct bus_type *bus,
  		       const char *buf,
  		       size_t count)
@@ -2155,8 +2172,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  	struct ceph_osd_client *osdc;
  	struct rbd_device *rbd_dev;
  	ssize_t rc = -ENOMEM;
-	int irc, new_id = 0;
-	struct list_head *tmp;
+	int irc;
  	char *mon_dev_name;
  	char *options;

@@ -2184,15 +2200,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  	/* generate unique id: find highest unique id, add one */
  	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);

-	list_for_each(tmp, &rbd_dev_list) {
-		struct rbd_device *rbd_dev;
-
-		rbd_dev = list_entry(tmp, struct rbd_device, node);
-		if (rbd_dev->id >= new_id)
-			new_id = rbd_dev->id + 1;
-	}
-
-	rbd_dev->id = new_id;
+	rbd_dev->id = rbd_id_get();

  	/* add to global list */
  	list_add_tail(&rbd_dev->node, &rbd_dev_list);
-- 
1.7.5.4

