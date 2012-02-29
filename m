From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/3] rbd: simplify error handling in rbd_add()
Date: Tue, 28 Feb 2012 19:53:00 -0800
Message-ID: <4F4DA11C.1000400@dreamhost.com>
References: <4F4DA086.7050601@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52331 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030721Ab2B2DxB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:53:01 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 369DA24322
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:53:01 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 2892C24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:53:01 -0800 (PST)
In-Reply-To: <4F4DA086.7050601@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If a couple pointers are initialized to NULL then a single
"out_nomem" label can be used for all of the memory allocation
failure cases in rbd_add().

Also, get rid of the "irc" local variable there.  There is no
real need for "rc" to be type ssize_t, and it can be used in
the spot "irc" was.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   40 +++++++++++++++++-----------------------
  1 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1488a52..29bbac1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2223,28 +2223,24 @@ static ssize_t rbd_add(struct bus_type *bus,
  		       const char *buf,
  		       size_t count)
  {
-	struct ceph_osd_client *osdc;
  	struct rbd_device *rbd_dev;
-	ssize_t rc = -ENOMEM;
-	int irc;
-	char *mon_dev_name;
-	char *options;
+	char *mon_dev_name = NULL;
+	char *options = NULL;
+	struct ceph_osd_client *osdc;
+	int rc = -ENOMEM;

  	if (!try_module_get(THIS_MODULE))
  		return -ENODEV;

+	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
+	if (!rbd_dev)
+		goto err_nomem;
  	mon_dev_name = kmalloc(count, GFP_KERNEL);
  	if (!mon_dev_name)
-		goto err_out_mod;
-
+		goto err_nomem;
  	options = kmalloc(count, GFP_KERNEL);
  	if (!options)
-		goto err_mon_dev;
-
-	/* new rbd_device object */
-	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
-	if (!rbd_dev)
-		goto err_out_opt;
+		goto err_nomem;

  	/* static rbd_device initialization */
  	spin_lock_init(&rbd_dev->lock);
@@ -2291,12 +2287,10 @@ static ssize_t rbd_add(struct bus_type *bus,
  	rbd_dev->poolid = rc;

  	/* register our block device */
-	irc = register_blkdev(0, rbd_dev->name);
-	if (irc < 0) {
-		rc = irc;
+	rc = register_blkdev(0, rbd_dev->name);
+	if (rc < 0)
  		goto err_out_client;
-	}
-	rbd_dev->major = irc;
+	rbd_dev->major = rc;

  	rc = rbd_bus_add_dev(rbd_dev);
  	if (rc)
@@ -2329,15 +2323,15 @@ err_out_client:
  	rbd_put_client(rbd_dev);
  err_put_id:
  	rbd_id_put(rbd_dev);
-	kfree(rbd_dev);
-err_out_opt:
+err_nomem:
  	kfree(options);
-err_mon_dev:
  	kfree(mon_dev_name);
-err_out_mod:
+	kfree(rbd_dev);
+
  	dout("Error adding device %s\n", buf);
  	module_put(THIS_MODULE);
-	return rc;
+
+	return (ssize_t) rc;
  }

  static struct rbd_device *__rbd_get_dev(unsigned long id)
-- 
1.7.5.4

