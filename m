From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] rbd: get parent info on refresh
Date: Sat, 11 May 2013 12:43:51 -0500
Message-ID: <518E8357.7010506@inktank.com>
References: <518E831E.6000206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53217 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419Ab3EKRnw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:43:52 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so9891468iec.39
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:43:52 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ct8sm6065998igb.7.2013.05.11.10.43.51
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:43:51 -0700 (PDT)
In-Reply-To: <518E831E.6000206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Get parent info for format 2 images on every refresh (rather than
just during the initial probe).  This will be needed to detect the
disappearance of the parent image in the event a mapped image
becomes unlayered (i.e., flattened).

Switch to using a non-zero parent overlap value rather than the
existence of a parent (a non-null parent_spec pointer) to determine
whether to mark a request layered.  It will soon be possible for
a layered image to become unlayered while a request is in flight.

This means that the layered flag for an image request indicates that
there was a non-zero parent overlap at the time the image request
was created.  The parent overlap can change thereafter, which may
lead to special handling at request submission or completion time.

Flesh out and fix the rbd_dev_v2_header_info() error handling path.

This and the next several pages are related to:
    http://tracker.ceph.com/issues/3763

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   72
++++++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3a8135f..06d49b5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1871,7 +1871,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	}
 	if (child_request)
 		img_request_child_set(img_request);
-	if (rbd_dev->parent_spec)
+	if (rbd_dev->parent_overlap)
 		img_request_layered_set(img_request);
 	spin_lock_init(&img_request->completion_lock);
 	img_request->next_completion = 0;
@@ -4021,20 +4021,60 @@ static int rbd_dev_v2_header_info(struct
rbd_device *rbd_dev)
 	if (first_time) {
 		ret = rbd_dev_v2_header_onetime(rbd_dev);
 		if (ret)
-			goto out;
+			goto out_err;
+	}
+
+	/*
+	 * If the image supports layering, get the parent info.  We
+	 * need to probe the first time regardless.  Thereafter we
+	 * only need to if there's a parent, to see if it has
+	 * disappeared due to the mapped image getting flattened.
+	 */
+	if (rbd_dev->header.features & RBD_FEATURE_LAYERING &&
+			(first_time || rbd_dev->parent_spec)) {
+		bool warn;
+
+		ret = rbd_dev_v2_parent_info(rbd_dev);
+		if (ret)
+			goto out_err;
+
+		/*
+		 * Print a warning if this is the initial probe and
+		 * the image has a parent.  Don't print it if the
+		 * image now being probed is itself a parent.  We
+		 * can tell at this point because we won't know its
+		 * pool name yet (just its pool id).
+		 */
+		warn = rbd_dev->parent_spec && rbd_dev->spec->pool_name;
+		if (first_time && warn)
+			rbd_warn(rbd_dev, "WARNING: kernel layering "
+					"is EXPERIMENTAL!");
 	}

 	ret = rbd_dev_v2_image_size(rbd_dev);
 	if (ret)
-		goto out;
+		goto out_err;
+
 	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
 		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
 			rbd_dev->mapping.size = rbd_dev->header.image_size;

 	ret = rbd_dev_v2_snap_context(rbd_dev);
 	dout("rbd_dev_v2_snap_context returned %d\n", ret);
-	if (ret)
+	if (!ret)
 		goto out;
+out_err:
+	rbd_dev->mapping.size = 0;
+	rbd_dev->header.image_size = 0;
+	rbd_dev->header.obj_order = 0;
+	rbd_dev->parent_overlap = 0;
+	rbd_spec_put(rbd_dev->parent_spec);
+	rbd_dev->parent_spec = NULL;
+	rbd_dev->header.stripe_count = 0;
+	rbd_dev->header.stripe_unit = 0;
+	rbd_dev->header.features = 0;
+	kfree(rbd_dev->header.object_prefix);
+	rbd_dev->header.object_prefix = NULL;
 out:
 	up_write(&rbd_dev->header_rwsem);

@@ -4488,24 +4528,6 @@ static int rbd_dev_v2_header_onetime(struct
rbd_device *rbd_dev)
 	if (ret)
 		goto out_err;

-	/* If the image supports layering, get the parent info */
-
-	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
-		ret = rbd_dev_v2_parent_info(rbd_dev);
-		if (ret)
-			goto out_err;
-		/*
-		 * Print a warning if this image has a parent.
-		 * Don't print it if the image now being probed
-		 * is itself a parent.  We can tell at this point
-		 * because we won't know its pool name yet (just its
-		 * pool id).
-		 */
-		if (rbd_dev->parent_spec && rbd_dev->spec->pool_name)
-			rbd_warn(rbd_dev, "WARNING: kernel layering "
-					"is EXPERIMENTAL!");
-	}
-
 	/* If the image supports fancy striping, get its parameters */

 	if (rbd_dev->header.features & RBD_FEATURE_STRIPINGV2) {
@@ -4517,11 +4539,7 @@ static int rbd_dev_v2_header_onetime(struct
rbd_device *rbd_dev)

 	return 0;
 out_err:
-	rbd_dev->parent_overlap = 0;
-	rbd_spec_put(rbd_dev->parent_spec);
-	rbd_dev->parent_spec = NULL;
-	kfree(rbd_dev->header_name);
-	rbd_dev->header_name = NULL;
+	rbd_dev->header.features = 0;
 	kfree(rbd_dev->header.object_prefix);
 	rbd_dev->header.object_prefix = NULL;

-- 
1.7.9.5

