From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/7] rbd: update in-core header directly
Date: Mon, 06 May 2013 20:53:20 -0500
Message-ID: <51885E90.3080706@inktank.com>
References: <51885E06.8020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:64731 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760Ab3EGBxW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:53:22 -0400
Received: by mail-qa0-f51.google.com with SMTP id hu16so132399qab.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:53:22 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id n9sm19673116qej.7.2013.05.06.18.53.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:53:21 -0700 (PDT)
In-Reply-To: <51885E06.8020201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now that rbd_header_from_disk() only fills in one-time fields once,
we can extend it slightly so it releases the other fields before
replacing their values.  This way there's no need to pass a
temporary buffer and then copy all the results in.  Just use the rbd
device header structure in rbd_header_from_disk() so its values get
updated directly.

Note that this means we need to take the header semaphore at the
point we update things.  So pass the rbd_dev rather than the address
of its header as its first argument to rbd_header_from_disk(), and
have it return an error code.

As a result, rbd_dev_v1_header_read() does all the work,
rbd_read_header() becomes unnecessary, and rbd_dev_v1_refresh()
becomes a very simple wrapper.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   98
++++++++++++++-------------------------------------
 1 file changed, 27 insertions(+), 71 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2403098..a7985d9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -730,9 +730,10 @@ static bool rbd_dev_ondisk_valid(struct
rbd_image_header_ondisk *ondisk)
  * Fill an rbd image header with information from the given format 1
  * on-disk header.
  */
-static int rbd_header_from_disk(struct rbd_image_header *header,
+static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 				 struct rbd_image_header_ondisk *ondisk)
 {
+	struct rbd_image_header *header = &rbd_dev->header;
 	bool first_time = header->object_prefix == NULL;
 	struct ceph_snap_context *snapc;
 	char *object_prefix = NULL;
@@ -802,6 +803,7 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,

 	/* We won't fail any more, fill in the header */

+	down_write(&rbd_dev->header_rwsem);
 	if (first_time) {
 		header->object_prefix = object_prefix;
 		header->obj_order = ondisk->options.order;
@@ -811,6 +813,10 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 		header->stripe_unit = 0;
 		header->stripe_count = 0;
 		header->features = 0;
+	} else {
+		ceph_put_snap_context(header->snapc);
+		kfree(header->snap_names);
+		kfree(header->snap_sizes);
 	}

 	/* The remaining fields always get updated (when we refresh) */
@@ -820,6 +826,14 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 	header->snap_names = snap_names;
 	header->snap_sizes = snap_sizes;

+	/* Make sure mapping size is consistent with header info */
+
+	if (rbd_dev->spec->snap_id == CEPH_NOSNAP || first_time)
+		if (rbd_dev->mapping.size != header->image_size)
+			rbd_dev->mapping.size = header->image_size;
+
+	up_write(&rbd_dev->header_rwsem);
+
 	return 0;
 out_2big:
 	ret = -EIO;
@@ -3032,17 +3046,11 @@ out:
 }

 /*
- * Read the complete header for the given rbd device.
- *
- * Returns a pointer to a dynamically-allocated buffer containing
- * the complete and validated header.  Caller can pass the address
- * of a variable that will be filled in with the version of the
- * header object at the time it was read.
- *
- * Returns a pointer-coded errno if a failure occurs.
+ * Read the complete header for the given rbd device.  On successful
+ * return, the rbd_dev->header field will contain up-to-date
+ * information about the image.
  */
-static struct rbd_image_header_ondisk *
-rbd_dev_v1_header_read(struct rbd_device *rbd_dev)
+static int rbd_dev_v1_header_read(struct rbd_device *rbd_dev)
 {
 	struct rbd_image_header_ondisk *ondisk = NULL;
 	u32 snap_count = 0;
@@ -3067,22 +3075,22 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev)
 		size += names_size;
 		ondisk = kmalloc(size, GFP_KERNEL);
 		if (!ondisk)
-			return ERR_PTR(-ENOMEM);
+			return -ENOMEM;

 		ret = rbd_obj_read_sync(rbd_dev, rbd_dev->header_name,
 				       0, size, ondisk);
 		if (ret < 0)
-			goto out_err;
+			goto out;
 		if ((size_t)ret < size) {
 			ret = -ENXIO;
 			rbd_warn(rbd_dev, "short header read (want %zd got %d)",
 				size, ret);
-			goto out_err;
+			goto out;
 		}
 		if (!rbd_dev_ondisk_valid(ondisk)) {
 			ret = -ENXIO;
 			rbd_warn(rbd_dev, "invalid header");
-			goto out_err;
+			goto out;
 		}

 		names_size = le64_to_cpu(ondisk->snap_names_len);
@@ -3090,27 +3098,8 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev)
 		snap_count = le32_to_cpu(ondisk->snap_count);
 	} while (snap_count != want_count);

-	return ondisk;
-
-out_err:
-	kfree(ondisk);
-
-	return ERR_PTR(ret);
-}
-
-/*
- * reload the ondisk the header
- */
-static int rbd_read_header(struct rbd_device *rbd_dev,
-			   struct rbd_image_header *header)
-{
-	struct rbd_image_header_ondisk *ondisk;
-	int ret;
-
-	ondisk = rbd_dev_v1_header_read(rbd_dev);
-	if (IS_ERR(ondisk))
-		return PTR_ERR(ondisk);
-	ret = rbd_header_from_disk(header, ondisk);
+	ret = rbd_header_from_disk(rbd_dev, ondisk);
+out:
 	kfree(ondisk);

 	return ret;
@@ -3121,40 +3110,7 @@ static int rbd_read_header(struct rbd_device
*rbd_dev,
  */
 static int rbd_dev_v1_refresh(struct rbd_device *rbd_dev)
 {
-	int ret;
-	struct rbd_image_header h;
-
-	memset(&h, 0, sizeof (h));
-	ret = rbd_read_header(rbd_dev, &h);
-	if (ret < 0)
-		return ret;
-
-	down_write(&rbd_dev->header_rwsem);
-
-	/* Update image size, and check for resize of mapped image */
-	rbd_dev->header.image_size = h.image_size;
-	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
-		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
-			rbd_dev->mapping.size = rbd_dev->header.image_size;
-
-	/* rbd_dev->header.object_prefix shouldn't change */
-	kfree(rbd_dev->header.snap_sizes);
-	kfree(rbd_dev->header.snap_names);
-	/* osd requests may still refer to snapc */
-	ceph_put_snap_context(rbd_dev->header.snapc);
-
-	rbd_dev->header.image_size = h.image_size;
-	rbd_dev->header.snapc = h.snapc;
-	rbd_dev->header.snap_names = h.snap_names;
-	rbd_dev->header.snap_sizes = h.snap_sizes;
-	/* Free the extra copy of the object prefix */
-	if (strcmp(rbd_dev->header.object_prefix, h.object_prefix))
-		rbd_warn(rbd_dev, "object prefix changed (ignoring)");
-	kfree(h.object_prefix);
-
-	up_write(&rbd_dev->header_rwsem);
-
-	return ret;
+	return rbd_dev_v1_header_read(rbd_dev);
 }

 /*
@@ -4517,7 +4473,7 @@ static int rbd_dev_v1_probe(struct rbd_device
*rbd_dev)

 	/* Populate rbd image metadata */

-	ret = rbd_read_header(rbd_dev, &rbd_dev->header);
+	ret = rbd_dev_v1_header_read(rbd_dev);
 	if (ret < 0)
 		goto out_err;

-- 
1.7.9.5

