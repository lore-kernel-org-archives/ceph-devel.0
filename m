From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/7] rbd: define rbd_dev_v1_header_info()
Date: Mon, 06 May 2013 20:54:09 -0500
Message-ID: <51885EC1.8050803@inktank.com>
References: <51885E06.8020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:35146 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759121Ab3EGByL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:54:11 -0400
Received: by mail-qa0-f52.google.com with SMTP id g10so129917qah.18
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:54:10 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id do6sm42748987qab.12.2013.05.06.18.54.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:54:09 -0700 (PDT)
In-Reply-To: <51885E06.8020201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This rearranges rbd_dev_v2_refresh() so it works more like
rbd_dev_v1_header_info().  While format 1 images need to read the
whole header object to get any information, format 2 can collect
almost all information selectively.  So the one-time initialization
will remain in a separate function--based on rbd_dev_v2_probe().

Rename rbd_dev_v2_refresh() to be rbd_dev_v2_header_info(), and have
it call rbd_dev_v2_header_onetime() if it's being called for the
first time for the given rbd device.

Rename rbd_dev_v2_probe() to be rbd_dev_v2_header_onetime() and
remove the image size and snapshot context calls it held in
common with the refresh function.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9e667c5..a300c03 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -425,7 +425,8 @@ static void rbd_img_parent_read(struct
rbd_obj_request *obj_request);
 static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);

 static int rbd_dev_refresh(struct rbd_device *rbd_dev);
-static int rbd_dev_v2_refresh(struct rbd_device *rbd_dev);
+static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
+static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id);
 static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
@@ -3135,7 +3136,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	if (rbd_dev->image_format == 1)
 		ret = rbd_dev_v1_header_info(rbd_dev);
 	else
-		ret = rbd_dev_v2_refresh(rbd_dev);
+		ret = rbd_dev_v2_header_info(rbd_dev);

 	/* If it's a mapped snapshot, validate its EXISTS flag */

@@ -4005,12 +4006,19 @@ out:
 	return snap_name;
 }

-static int rbd_dev_v2_refresh(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 {
+	bool first_time = rbd_dev->header.object_prefix == NULL;
 	int ret;

 	down_write(&rbd_dev->header_rwsem);

+	if (first_time) {
+		ret = rbd_dev_v2_header_onetime(rbd_dev);
+		if (ret)
+			goto out;
+	}
+
 	ret = rbd_dev_v2_image_size(rbd_dev);
 	if (ret)
 		goto out;
@@ -4459,22 +4467,18 @@ static void rbd_dev_unprobe(struct rbd_device
*rbd_dev)
 	memset(header, 0, sizeof (*header));
 }

-static int rbd_dev_v2_probe(struct rbd_device *rbd_dev)
+static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev)
 {
 	int ret;

-	ret = rbd_dev_v2_image_size(rbd_dev);
-	if (ret)
-		goto out_err;
-
-	/* Get the object prefix (a.k.a. block_name) for the image */
-
 	ret = rbd_dev_v2_object_prefix(rbd_dev);
 	if (ret)
 		goto out_err;

-	/* Get the and check features for the image */
-
+	/*
+	 * Get the and check features for the image.  Currently the
+	 * features are assumed to never change.
+	 */
 	ret = rbd_dev_v2_features(rbd_dev);
 	if (ret)
 		goto out_err;
@@ -4504,17 +4508,7 @@ static int rbd_dev_v2_probe(struct rbd_device
*rbd_dev)
 		if (ret < 0)
 			goto out_err;
 	}
-
-	/* crypto and compression type aren't (yet) supported for v2 images */
-
-	rbd_dev->header.crypt_type = 0;
-	rbd_dev->header.comp_type = 0;
-
-	/* Get the snapshot context, plus the header version */
-
-	ret = rbd_dev_v2_snap_context(rbd_dev);
-	if (ret)
-		goto out_err;
+	/* No support for crypto and compression type format 2 images */

 	return 0;
 out_err:
@@ -4703,7 +4697,7 @@ static int rbd_dev_image_probe(struct rbd_device
*rbd_dev, bool read_only)
 	if (rbd_dev->image_format == 1)
 		ret = rbd_dev_v1_header_info(rbd_dev);
 	else
-		ret = rbd_dev_v2_probe(rbd_dev);
+		ret = rbd_dev_v2_header_info(rbd_dev);
 	if (ret)
 		goto err_out_watch;

-- 
1.7.9.5

