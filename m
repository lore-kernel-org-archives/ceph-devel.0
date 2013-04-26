From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: have rbd_dev_image_id() set format 1 image id
Date: Fri, 26 Apr 2013 09:52:16 -0500
Message-ID: <517A94A0.3010104@inktank.com>
References: <517A945B.9040304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:54917 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3DZOwT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 10:52:19 -0400
Received: by mail-ia0-f180.google.com with SMTP id t4so2799260iag.11
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 07:52:18 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id p10sm484827igj.5.2013.04.26.07.52.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 07:52:17 -0700 (PDT)
In-Reply-To: <517A945B.9040304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently, rbd_dev_probe() assumes that any error returned by
rbd_dev_image_id() is most likely -ENOENT, and responds by
calling the format 1 probe routine, rbd_dev_v1_probe().  Then,
at the top of rbd_dev_v1_probe(), an empty string is allocated
for the image id.

This is sort of unbalanced.  Fix this by having rbd_dev_image_id()
look for -ENOENT from its "get_id" method call.  If that is seen,
have it allocate the empty string there rather than depending on
rbd_dev_v1_probe() to do it.

Also drop a redundant hunk of code in rbd_dev_image_id().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9e38967..0774ae1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4476,12 +4476,7 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 	size_t size;
 	char *object_name;
 	void *response;
-	void *p;
-
-	/* If we already have it we don't need to look it up */
-
-	if (rbd_dev->spec->image_id)
-		return 0;
+	char *image_id;

 	/*
 	 * When probing a parent image, the image id is already
@@ -4511,24 +4506,28 @@ static int rbd_dev_image_id(struct rbd_device
*rbd_dev)
 		goto out;
 	}

+	/* If it doesn't exist we'll assume it's a format 1 image */
+
 	ret = rbd_obj_method_sync(rbd_dev, object_name,
 				"rbd", "get_id", NULL, 0,
 				response, RBD_IMAGE_ID_LEN_MAX, NULL);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
-	if (ret < 0)
-		goto out;
+	if (ret == -ENOENT) {
+		image_id = kstrdup("", GFP_KERNEL);
+		ret = image_id ? 0 : -ENOMEM;
+	} else if (ret > sizeof (__le32)) {
+		void *p = response;

-	p = response;
-	rbd_dev->spec->image_id = ceph_extract_encoded_string(&p,
-						p + ret,
+		image_id = ceph_extract_encoded_string(&p, p + ret,
 						NULL, GFP_NOIO);
-	ret = 0;
-
-	if (IS_ERR(rbd_dev->spec->image_id)) {
-		ret = PTR_ERR(rbd_dev->spec->image_id);
-		rbd_dev->spec->image_id = NULL;
+		ret = IS_ERR(image_id) ? PTR_ERR(image_id) : 0;
 	} else {
-		dout("image_id is %s\n", rbd_dev->spec->image_id);
+		ret = -EINVAL;
+	}
+
+	if (!ret) {
+		rbd_dev->spec->image_id = image_id;
+		dout("image_id is %s\n", image_id);
 	}
 out:
 	kfree(response);
@@ -4542,12 +4541,6 @@ static int rbd_dev_v1_probe(struct rbd_device
*rbd_dev)
 	int ret;
 	size_t size;

-	/* Version 1 images have no id; empty string is used */
-
-	rbd_dev->spec->image_id = kstrdup("", GFP_KERNEL);
-	if (!rbd_dev->spec->image_id)
-		return -ENOMEM;
-
 	/* Record the header object name for this rbd image. */

 	size = strlen(rbd_dev->spec->image_name) + sizeof (RBD_SUFFIX);
@@ -4794,9 +4787,13 @@ static int rbd_dev_probe(struct rbd_device *rbd_dev)
 	 */
 	ret = rbd_dev_image_id(rbd_dev);
 	if (ret)
-		ret = rbd_dev_v1_probe(rbd_dev);
-	else
+		return ret;
+
+	rbd_assert(rbd_dev->spec->image_id);
+	if (*rbd_dev->spec->image_id)
 		ret = rbd_dev_v2_probe(rbd_dev);
+	else
+		ret = rbd_dev_v1_probe(rbd_dev);
 	if (ret) {
 		dout("probe failed, returning %d\n", ret);

-- 
1.7.9.5

