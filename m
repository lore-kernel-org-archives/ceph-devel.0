From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/8] rbd: add reference counting to rbd_spec
Date: Fri, 26 Oct 2012 18:03:37 -0500
Message-ID: <508B16C9.8040708@inktank.com>
References: <508B11E3.3040108@inktank.com> <508B1505.20209@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:61295 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934218Ab2JZXDn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 19:03:43 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so2579560iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 16:03:43 -0700 (PDT)
In-Reply-To: <508B1505.20209@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

With layered images we'll share rbd_spec structures, so add a
reference count to it.  It neatens up some code also.

A silly get/put pair is added to the alloc routine just to avoid
"defined but not used" warnings.  It will go away soon.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   52
+++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c39e238..19c7c6b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2134,6 +2134,45 @@ static struct device_type rbd_snap_device_type = {
 	.release	= rbd_snap_dev_release,
 };

+static struct rbd_spec *rbd_spec_get(struct rbd_spec *spec)
+{
+	kref_get(&spec->kref);
+
+	return spec;
+}
+
+static void rbd_spec_free(struct kref *kref);
+static void rbd_spec_put(struct rbd_spec *spec)
+{
+	if (spec)
+		kref_put(&spec->kref, rbd_spec_free);
+}
+
+static struct rbd_spec *rbd_spec_alloc(void)
+{
+	struct rbd_spec *spec;
+
+	spec = kzalloc(sizeof (*spec), GFP_KERNEL);
+	if (!spec)
+		return NULL;
+	kref_init(&spec->kref);
+
+	rbd_spec_put(rbd_spec_get(spec));	/* TEMPORARY */
+
+	return spec;
+}
+
+static void rbd_spec_free(struct kref *kref)
+{
+	struct rbd_spec *spec = container_of(kref, struct rbd_spec, kref);
+
+	kfree(spec->pool_name);
+	kfree(spec->image_id);
+	kfree(spec->image_name);
+	kfree(spec->snap_name);
+	kfree(spec);
+}
+
 static bool rbd_snap_registered(struct rbd_snap *snap)
 {
 	bool ret = snap->dev.type == &rbd_snap_device_type;
@@ -3165,7 +3204,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 	rbd_dev = kzalloc(sizeof(*rbd_dev), GFP_KERNEL);
 	if (!rbd_dev)
 		return -ENOMEM;
-	rbd_dev->spec = kzalloc(sizeof (*rbd_dev->spec), GFP_KERNEL);
+	rbd_dev->spec = rbd_spec_alloc();
 	if (!rbd_dev->spec)
 		goto err_out_mem;

@@ -3278,16 +3317,12 @@ err_out_probe:
 err_out_client:
 	kfree(rbd_dev->header_name);
 	rbd_put_client(rbd_dev);
-	kfree(rbd_dev->spec->image_id);
 err_out_args:
 	if (ceph_opts)
 		ceph_destroy_options(ceph_opts);
-	kfree(rbd_dev->spec->snap_name);
-	kfree(rbd_dev->spec->image_name);
-	kfree(rbd_dev->spec->pool_name);
 	kfree(rbd_opts);
 err_out_mem:
-	kfree(rbd_dev->spec);
+	rbd_spec_put(rbd_dev->spec);
 	kfree(rbd_dev);

 	dout("Error adding device %s\n", buf);
@@ -3336,12 +3371,9 @@ static void rbd_dev_release(struct device *dev)
 	rbd_header_free(&rbd_dev->header);

 	/* done with the id, and with the rbd_dev */
-	kfree(rbd_dev->spec->snap_name);
-	kfree(rbd_dev->spec->image_id);
 	kfree(rbd_dev->header_name);
-	kfree(rbd_dev->spec->pool_name);
-	kfree(rbd_dev->spec->image_name);
 	rbd_dev_id_put(rbd_dev);
+	rbd_spec_put(rbd_dev->spec);
 	kfree(rbd_dev);

 	/* release module ref */
-- 
1.7.9.5

