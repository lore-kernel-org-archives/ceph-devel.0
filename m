From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] rbd: encapsulate probing for parent devices
Date: Sat, 27 Apr 2013 07:36:30 -0500
Message-ID: <517BC64E.8090806@inktank.com>
References: <517BC608.5030008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59037 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3D0Mgb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:36:31 -0400
Received: by mail-ie0-f180.google.com with SMTP id to1so5790348ieb.25
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:36:31 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xc3sm7687047igb.10.2013.04.27.05.36.30
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:36:30 -0700 (PDT)
In-Reply-To: <517BC608.5030008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Encapsulate the code that probes for an rbd device's parent images
into a new function, rbd_dev_probe_parent().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   77
+++++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b10348c..88cd5f4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4696,11 +4696,49 @@ out_err:
 	return ret;
 }

-static int rbd_dev_probe_finish(struct rbd_device *rbd_dev)
+static int rbd_dev_probe_parent(struct rbd_device *rbd_dev)
 {
 	struct rbd_device *parent = NULL;
-	struct rbd_spec *parent_spec = NULL;
-	struct rbd_client *rbdc = NULL;
+	struct rbd_spec *parent_spec;
+	struct rbd_client *rbdc;
+	int ret;
+
+	if (!rbd_dev->parent_spec)
+		return 0;
+	/*
+	 * We need to pass a reference to the client and the parent
+	 * spec when creating the parent rbd_dev.  Images related by
+	 * parent/child relationships always share both.
+	 */
+	parent_spec = rbd_spec_get(rbd_dev->parent_spec);
+	rbdc = __rbd_get_client(rbd_dev->rbd_client);
+
+	ret = -ENOMEM;
+	parent = rbd_dev_create(rbdc, parent_spec);
+	if (!parent)
+		goto out_err;
+
+	ret = rbd_dev_probe_image(parent);
+	if (ret < 0)
+		goto out_err;
+	rbd_dev->parent = parent;
+
+	return 0;
+out_err:
+	if (parent) {
+		rbd_spec_put(rbd_dev->parent_spec);
+		kfree(rbd_dev->header_name);
+		rbd_dev_destroy(parent);
+	} else {
+		rbd_put_client(rbdc);
+		rbd_spec_put(parent_spec);
+	}
+
+	return ret;
+}
+
+static int rbd_dev_probe_finish(struct rbd_device *rbd_dev)
+{
 	int ret;

 	/* no need to lock here, as rbd_dev is not registered yet */
@@ -4741,30 +4779,10 @@ static int rbd_dev_probe_finish(struct
rbd_device *rbd_dev)
 	 * At this point cleanup in the event of an error is the job
 	 * of the sysfs code (initiated by rbd_bus_del_dev()).
 	 */
-	/* Probe the parent if there is one */
-
-	if (rbd_dev->parent_spec) {
-		/*
-		 * We need to pass a reference to the client and the
-		 * parent spec when creating the parent rbd_dev.
-		 * Images related by parent/child relationships
-		 * always share both.
-		 */
-		parent_spec = rbd_spec_get(rbd_dev->parent_spec);
-		rbdc = __rbd_get_client(rbd_dev->rbd_client);

-		parent = rbd_dev_create(rbdc, parent_spec);
-		if (!parent) {
-			ret = -ENOMEM;
-			goto err_out_spec;
-		}
-		rbdc = NULL;		/* parent now owns reference */
-		parent_spec = NULL;	/* parent now owns reference */
-		ret = rbd_dev_probe_image(parent);
-		if (ret < 0)
-			goto err_out_parent;
-		rbd_dev->parent = parent;
-	}
+	ret = rbd_dev_probe_parent(rbd_dev);
+	if (ret)
+		goto err_out_bus;

 	ret = rbd_dev_header_watch_sync(rbd_dev, 1);
 	if (ret)
@@ -4786,13 +4804,6 @@ static int rbd_dev_probe_finish(struct rbd_device
*rbd_dev)

 	return ret;

-err_out_parent:
-	rbd_spec_put(rbd_dev->parent_spec);
-	kfree(rbd_dev->header_name);
-	rbd_dev_destroy(parent);
-err_out_spec:
-	rbd_spec_put(parent_spec);
-	rbd_put_client(rbdc);
 err_out_bus:
 	/* this will also clean up rest of rbd_dev stuff */

-- 
1.7.9.5

