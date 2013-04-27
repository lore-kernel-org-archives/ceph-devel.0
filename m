From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] rbd: define rbd_header_name()
Date: Sat, 27 Apr 2013 14:39:31 -0500
Message-ID: <517C2973.3080803@inktank.com>
References: <517C2914.8030400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:53029 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab3D0Tjd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 15:39:33 -0400
Received: by mail-ia0-f176.google.com with SMTP id l27so4088549iae.21
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 12:39:32 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id wx2sm10130390igb.4.2013.04.27.12.39.31
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 12:39:31 -0700 (PDT)
In-Reply-To: <517C2914.8030400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Set an rbd device's image format value in rbd_dev_probe_image(), and
use it in a new function rbd_header_name(), which allocates and
formats the name of the header object for the rbd device.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   77
++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8a9ad60..c72dcdf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4575,18 +4575,6 @@ out:
 static int rbd_dev_v1_probe(struct rbd_device *rbd_dev)
 {
 	int ret;
-	size_t size;
-
-	/* Record the header object name for this rbd image. */
-
-	size = strlen(rbd_dev->spec->image_name) + sizeof (RBD_SUFFIX);
-	rbd_dev->header_name = kmalloc(size, GFP_KERNEL);
-	if (!rbd_dev->header_name) {
-		ret = -ENOMEM;
-		goto out_err;
-	}
-	sprintf(rbd_dev->header_name, "%s%s",
-		rbd_dev->spec->image_name, RBD_SUFFIX);

 	/* Populate rbd image metadata */

@@ -4599,8 +4587,6 @@ static int rbd_dev_v1_probe(struct rbd_device
*rbd_dev)
 	rbd_dev->parent_spec = NULL;
 	rbd_dev->parent_overlap = 0;

-	rbd_dev->image_format = 1;
-
 	dout("discovered version 1 image, header name is %s\n",
 		rbd_dev->header_name);

@@ -4617,22 +4603,9 @@ out_err:

 static int rbd_dev_v2_probe(struct rbd_device *rbd_dev)
 {
-	size_t size;
 	int ret;
 	u64 ver = 0;

-	/*
-	 * Image id was filled in by the caller.  Record the header
-	 * object name for this rbd image.
-	 */
-	size = sizeof (RBD_HEADER_PREFIX) + strlen(rbd_dev->spec->image_id);
-	rbd_dev->header_name = kmalloc(size, GFP_KERNEL);
-	if (!rbd_dev->header_name)
-		return -ENOMEM;
-	sprintf(rbd_dev->header_name, "%s%s",
-			RBD_HEADER_PREFIX, rbd_dev->spec->image_id);
-
-	/* Get the size and object order for the image */
 	ret = rbd_dev_v2_image_size(rbd_dev);
 	if (ret)
 		goto out_err;
@@ -4679,8 +4652,6 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 		goto out_err;
 	rbd_dev->header.obj_version = ver;

-	rbd_dev->image_format = 2;
-
 	dout("discovered version 2 image, header name is %s\n",
 		rbd_dev->header_name);

@@ -4808,6 +4779,33 @@ err_out_id:
 	return ret;
 }

+static int rbd_dev_header_name(struct rbd_device *rbd_dev)
+{
+	struct rbd_spec *spec = rbd_dev->spec;
+	size_t size;
+
+	/* Record the header object name for this rbd image. */
+
+	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
+
+	if (rbd_dev->image_format == 1)
+		size = strlen(spec->image_name) + sizeof (RBD_SUFFIX);
+	else
+		size = sizeof (RBD_HEADER_PREFIX) + strlen(spec->image_id);
+
+	rbd_dev->header_name = kmalloc(size, GFP_KERNEL);
+	if (!rbd_dev->header_name)
+		return -ENOMEM;
+
+	if (rbd_dev->image_format == 1)
+		sprintf(rbd_dev->header_name, "%s%s",
+			spec->image_name, RBD_SUFFIX);
+	else
+		sprintf(rbd_dev->header_name, "%s%s",
+			RBD_HEADER_PREFIX, spec->image_id);
+	return 0;
+}
+
 /*
  * Probe for the existence of the header object for the given rbd
  * device.  For format 2 images this includes determining the image
@@ -4825,18 +4823,24 @@ static int rbd_dev_probe_image(struct rbd_device
*rbd_dev)
 	ret = rbd_dev_image_id(rbd_dev);
 	if (ret)
 		return ret;
-
 	rbd_assert(rbd_dev->spec->image_id);
-	if (*rbd_dev->spec->image_id)
-		ret = rbd_dev_v2_probe(rbd_dev);
-	else
-		ret = rbd_dev_v1_probe(rbd_dev);
+
+	rbd_dev->image_format = *rbd_dev->spec->image_id ? 2 : 1;
+
+	ret = rbd_dev_header_name(rbd_dev);
 	if (ret)
 		goto out_err;

+	if (rbd_dev->image_format == 1)
+		ret = rbd_dev_v1_probe(rbd_dev);
+	else
+		ret = rbd_dev_v2_probe(rbd_dev);
+	if (ret)
+		goto out_header_name;
+
 	ret = rbd_dev_snaps_update(rbd_dev);
 	if (ret)
-		goto out_err;
+		goto out_header_name;

 	ret = rbd_dev_spec_update(rbd_dev);
 	if (ret)
@@ -4857,6 +4861,9 @@ err_out_parent:
 		rbd_dev_remove_parent(rbd_dev);
 err_out_snaps:
 	rbd_remove_all_snaps(rbd_dev);
+out_header_name:
+	kfree(rbd_dev->header_name);
+	rbd_dev->header_name = NULL;
 out_err:
 	kfree(rbd_dev->spec->image_id);
 	rbd_dev->spec->image_id = NULL;
-- 
1.7.9.5

