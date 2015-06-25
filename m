From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/3] rbd: store rbd_options in rbd_device
Date: Thu, 25 Jun 2015 12:11:19 +0300
Message-ID: <1435223480-35238-3-git-send-email-idryomov@gmail.com>
References: <1435223480-35238-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:33987 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbbFYJLm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 05:11:42 -0400
Received: by lagx9 with SMTP id x9so41037871lag.1
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 02:11:40 -0700 (PDT)
Received: from localhost.localdomain ([109.110.66.238])
        by mx.google.com with ESMTPSA id ew11sm7055678lac.31.2015.06.25.02.11.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2015 02:11:39 -0700 (PDT)
In-Reply-To: <1435223480-35238-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4de8c9167c4b..e502bce02d2c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -346,6 +346,7 @@ struct rbd_device {
 	struct rbd_image_header	header;
 	unsigned long		flags;		/* possibly lock protected */
 	struct rbd_spec		*spec;
+	struct rbd_options	*opts;
 
 	char			*header_name;
 
@@ -4055,7 +4056,8 @@ static void rbd_spec_free(struct kref *kref)
 }
 
 static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
-				struct rbd_spec *spec)
+					 struct rbd_spec *spec,
+					 struct rbd_options *opts)
 {
 	struct rbd_device *rbd_dev;
 
@@ -4069,8 +4071,9 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	INIT_LIST_HEAD(&rbd_dev->node);
 	init_rwsem(&rbd_dev->header_rwsem);
 
-	rbd_dev->spec = spec;
 	rbd_dev->rbd_client = rbdc;
+	rbd_dev->spec = spec;
+	rbd_dev->opts = opts;
 
 	/* Initialize the layout used for all rbd requests */
 
@@ -4086,6 +4089,7 @@ static void rbd_dev_destroy(struct rbd_device *rbd_dev)
 {
 	rbd_put_client(rbd_dev->rbd_client);
 	rbd_spec_put(rbd_dev->spec);
+	kfree(rbd_dev->opts);
 	kfree(rbd_dev);
 }
 
@@ -5160,7 +5164,7 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev)
 	rbdc = __rbd_get_client(rbd_dev->rbd_client);
 
 	ret = -ENOMEM;
-	parent = rbd_dev_create(rbdc, parent_spec);
+	parent = rbd_dev_create(rbdc, parent_spec, NULL);
 	if (!parent)
 		goto out_err;
 
@@ -5406,9 +5410,6 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	rc = rbd_add_parse_args(buf, &ceph_opts, &rbd_opts, &spec);
 	if (rc < 0)
 		goto err_out_module;
-	read_only = rbd_opts->read_only;
-	kfree(rbd_opts);
-	rbd_opts = NULL;	/* done with this */
 
 	rbdc = rbd_get_client(ceph_opts);
 	if (IS_ERR(rbdc)) {
@@ -5434,11 +5435,12 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 		goto err_out_client;
 	}
 
-	rbd_dev = rbd_dev_create(rbdc, spec);
+	rbd_dev = rbd_dev_create(rbdc, spec, rbd_opts);
 	if (!rbd_dev)
 		goto err_out_client;
 	rbdc = NULL;		/* rbd_dev now owns this */
 	spec = NULL;		/* rbd_dev now owns this */
+	rbd_opts = NULL;	/* rbd_dev now owns this */
 
 	rc = rbd_dev_image_probe(rbd_dev, true);
 	if (rc < 0)
@@ -5446,6 +5448,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 
 	/* If we are mapping a snapshot it must be marked read-only */
 
+	read_only = rbd_dev->opts->read_only;
 	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
 		read_only = true;
 	rbd_dev->mapping.read_only = read_only;
@@ -5470,6 +5473,7 @@ err_out_client:
 	rbd_put_client(rbdc);
 err_out_args:
 	rbd_spec_put(spec);
+	kfree(rbd_opts);
 err_out_module:
 	module_put(THIS_MODULE);
 
-- 
1.9.3

