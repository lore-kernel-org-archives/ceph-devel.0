From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: consolidate rbd_dev init in rbd_add()
Date: Tue, 30 Oct 2012 16:14:19 -0500
Message-ID: <5090432B.4060301@inktank.com>
References: <50904265.2050603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:52430 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934577Ab2J3VOX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 17:14:23 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so527378iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 14:14:23 -0700 (PDT)
In-Reply-To: <50904265.2050603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Group the allocation and initialization of fields of the rbd device
structure created in rbd_add().  Move the grouped code down later in
the function, just prior to the call to rbd_dev_probe().  This is
for the most part simple code movement.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a528d4c..4771de2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3232,29 +3232,16 @@ static ssize_t rbd_add(struct bus_type *bus,
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;

-	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
-	if (!rbd_dev)
-		return -ENOMEM;
-
-	/* static rbd_device initialization */
-	spin_lock_init(&rbd_dev->lock);
-	INIT_LIST_HEAD(&rbd_dev->node);
-	INIT_LIST_HEAD(&rbd_dev->snaps);
-	init_rwsem(&rbd_dev->header_rwsem);
-
 	/* parse add command */
 	rc = rbd_add_parse_args(buf, &ceph_opts, &rbd_opts, &spec);
 	if (rc < 0)
-		goto err_out_mem;
-
-	rbd_dev->mapping.read_only = rbd_opts->read_only;
+		goto err_out_module;

 	rbdc = rbd_get_client(ceph_opts);
 	if (IS_ERR(rbdc)) {
 		rc = PTR_ERR(rbdc);
 		goto err_out_args;
 	}
-	rbd_dev->rbd_client = rbdc;
 	ceph_opts = NULL;	/* ceph_opts now owned by rbd_dev client */

 	/* pick the pool */
@@ -3264,11 +3251,22 @@ static ssize_t rbd_add(struct bus_type *bus,
 		goto err_out_client;
 	spec->pool_id = (u64) rc;

+	rbd_dev = kzalloc(sizeof (*rbd_dev), GFP_KERNEL);
+	if (!rbd_dev)
+		goto err_out_client;
+
+	spin_lock_init(&rbd_dev->lock);
+	INIT_LIST_HEAD(&rbd_dev->node);
+	INIT_LIST_HEAD(&rbd_dev->snaps);
+	init_rwsem(&rbd_dev->header_rwsem);
+	rbd_dev->rbd_client = rbdc;
 	rbd_dev->spec = spec;

+	rbd_dev->mapping.read_only = rbd_opts->read_only;
+
 	rc = rbd_dev_probe(rbd_dev);
 	if (rc < 0)
-		goto err_out_client;
+		goto err_out_mem;

 	/* no need to lock here, as rbd_dev is not registered yet */
 	rc = rbd_dev_snaps_update(rbd_dev);
@@ -3348,19 +3346,20 @@ err_out_snaps:
 	rbd_remove_all_snaps(rbd_dev);
 err_out_probe:
 	rbd_header_free(&rbd_dev->header);
-err_out_client:
 	kfree(rbd_dev->header_name);
+err_out_mem:
+	kfree(rbd_dev);
+err_out_client:
 	rbd_put_client(rbdc);
 err_out_args:
 	if (ceph_opts)
 		ceph_destroy_options(ceph_opts);
 	kfree(rbd_opts);
 	rbd_spec_put(spec);
-err_out_mem:
-	kfree(rbd_dev);
+err_out_module:
+	module_put(THIS_MODULE);

 	dout("Error adding device %s\n", buf);
-	module_put(THIS_MODULE);

 	return (ssize_t) rc;
 }
-- 
1.7.9.5

