From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: protect against duplicate client creation
Date: Wed, 29 May 2013 15:50:49 -0500
Message-ID: <51A66A29.6060805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:33401 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966493Ab3E2Uuf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 16:50:35 -0400
Received: by mail-vb0-f43.google.com with SMTP id e12so4319551vbg.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 13:50:35 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id s9sm29812380vdh.4.2013.05.29.13.50.34
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 13:50:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

If more than one rbd image has the same ceph cluster configuration
(same options, same set of monitors, same keys) they normally share
a single rbd client.

When an image is getting mapped, rbd looks to see if an existing
client can be used, and creates a new one if not.

The lookup and creation are not done under a common lock though, so
mapping two images concurrently could lead to duplicate clients
getting set up needlessly.  This isn't a major problem, but it's
wasteful and different from what's intended.

This patch fixes that by using the control mutex to protect
both the lookup and (if needed) creation of the client.  It
was previously used just when creating.

This resolves:
    http://tracker.ceph.com/issues/3094

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index aec2438..d255541 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -522,7 +522,7 @@ static const struct block_device_operations
rbd_bd_ops = {

 /*
  * Initialize an rbd client instance.  Success or not, this function
- * consumes ceph_opts.
+ * consumes ceph_opts.  Caller holds ctl_mutex
  */
 static struct rbd_client *rbd_client_create(struct ceph_options *ceph_opts)
 {
@@ -537,8 +537,6 @@ static struct rbd_client *rbd_client_create(struct
ceph_options *ceph_opts)
 	kref_init(&rbdc->kref);
 	INIT_LIST_HEAD(&rbdc->node);

-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-
 	rbdc->client = ceph_create_client(ceph_opts, rbdc, 0, 0);
 	if (IS_ERR(rbdc->client))
 		goto out_mutex;
@@ -552,7 +550,6 @@ static struct rbd_client *rbd_client_create(struct
ceph_options *ceph_opts)
 	list_add_tail(&rbdc->node, &rbd_client_list);
 	spin_unlock(&rbd_client_list_lock);

-	mutex_unlock(&ctl_mutex);
 	dout("%s: rbdc %p\n", __func__, rbdc);

 	return rbdc;
@@ -684,11 +681,13 @@ static struct rbd_client *rbd_get_client(struct
ceph_options *ceph_opts)
 {
 	struct rbd_client *rbdc;

+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 	rbdc = rbd_client_find(ceph_opts);
 	if (rbdc)	/* using an existing client */
 		ceph_destroy_options(ceph_opts);
 	else
 		rbdc = rbd_client_create(ceph_opts);
+	mutex_unlock(&ctl_mutex);

 	return rbdc;
 }
-- 
1.7.9.5

