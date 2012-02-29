From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/3] rbd: have rbd_get_client() return a rbd_client
Date: Tue, 28 Feb 2012 19:52:56 -0800
Message-ID: <4F4DA118.3020201@dreamhost.com>
References: <4F4DA086.7050601@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52322 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030721Ab2B2Dw5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:52:57 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 66DD72431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:52:57 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 5427324318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:52:57 -0800 (PST)
In-Reply-To: <4F4DA086.7050601@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Since rbd_get_client() currently returns an error code.  It assigns
the rbd_client field of the rbd_device structure it is passed if
successful.  Instead, have it return the created rbd_client
structure and return a pointer-coded error if there is an error.
This makes the assignment of the client pointer more obvious at the
call site.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   32 ++++++++++++--------------------
  1 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e7d6dfc..d5b4500 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -384,17 +384,15 @@ static int parse_rbd_opts_token(char *c, void 
*private)
   * Get a ceph client with specific addr and configuration, if one does
   * not exist create it.
   */
-static int rbd_get_client(struct rbd_device *rbd_dev, const char *mon_addr,
-			  char *options)
+static struct rbd_client *rbd_get_client(const char *mon_addr, char 
*options)
  {
  	struct rbd_client *rbdc;
  	struct ceph_options *opt;
-	int ret;
  	struct rbd_options *rbd_opts;

  	rbd_opts = kzalloc(sizeof(*rbd_opts), GFP_KERNEL);
  	if (!rbd_opts)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);

  	rbd_opts->notify_timeout = RBD_NOTIFY_TIMEOUT_DEFAULT;

@@ -402,8 +400,8 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,
  				mon_addr + strlen(mon_addr),
  				parse_rbd_opts_token, rbd_opts);
  	if (IS_ERR(opt)) {
-		ret = PTR_ERR(opt);
-		goto done_err;
+		kfree(rbd_opts);
+		return ERR_CAST(opt);
  	}

  	spin_lock(&rbd_client_list_lock);
@@ -413,27 +411,19 @@ static int rbd_get_client(struct rbd_device 
*rbd_dev, const char *mon_addr,
  		kref_get(&rbdc->kref);
  		spin_unlock(&rbd_client_list_lock);

-		rbd_dev->rbd_client = rbdc;
-
  		ceph_destroy_options(opt);
  		kfree(rbd_opts);

-		return 0;
+		return rbdc;
  	}
  	spin_unlock(&rbd_client_list_lock);

  	rbdc = rbd_client_create(opt, rbd_opts);

-	if (IS_ERR(rbdc)) {
-		ret = PTR_ERR(rbdc);
-		goto done_err;
-	}
+	if (IS_ERR(rbdc))
+		kfree(rbd_opts);

-	rbd_dev->rbd_client = rbdc;
-	return 0;
-done_err:
-	kfree(rbd_opts);
-	return ret;
+	return rbdc;
  }

  /*
@@ -2287,9 +2277,11 @@ static ssize_t rbd_add(struct bus_type *bus,
  	/* initialize rest of new object */
  	snprintf(rbd_dev->name, DEV_NAME_LEN, RBD_DRV_NAME "%d", rbd_dev->id);

-	rc = rbd_get_client(rbd_dev, mon_dev_name, options);
-	if (rc < 0)
+	rbd_dev->rbd_client = rbd_get_client(mon_dev_name, options);
+	if (IS_ERR(rbd_dev->rbd_client)) {
+		rc = PTR_ERR(rbd_dev->rbd_client);
  		goto err_put_id;
+	}

  	/* pick the pool */
  	osdc = &rbd_dev->rbd_client->client->osdc;
-- 
1.7.5.4

