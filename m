From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/7] rbd: refactor rbd_header_from_disk()
Date: Mon, 06 May 2013 20:53:04 -0500
Message-ID: <51885E80.4050906@inktank.com>
References: <51885E06.8020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:54745 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760Ab3EGBxH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:53:07 -0400
Received: by mail-qe0-f44.google.com with SMTP id s14so31173qeb.31
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:53:06 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id do6sm42745248qab.12.2013.05.06.18.53.05
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:53:05 -0700 (PDT)
In-Reply-To: <51885E06.8020201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This rearranges rbd_header_from_disk so that it:
    - allocates the snapshot context right away
    - keeps results in local variables, not changing the passed-in
      header until it's known we'll succeed
    - does initialization of set-once fields in a header only if
      they have not already been set

The last point is moot at the moment, because rbd_read_header()
(the only caller) always supplies a zero-filled header buffer.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |  127
++++++++++++++++++++++++++++++---------------------
 1 file changed, 75 insertions(+), 52 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cdba93b..2403098 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -727,86 +727,109 @@ static bool rbd_dev_ondisk_valid(struct
rbd_image_header_ondisk *ondisk)
 }

 /*
- * Create a new header structure, translate header format from the on-disk
- * header.
+ * Fill an rbd image header with information from the given format 1
+ * on-disk header.
  */
 static int rbd_header_from_disk(struct rbd_image_header *header,
 				 struct rbd_image_header_ondisk *ondisk)
 {
+	bool first_time = header->object_prefix == NULL;
+	struct ceph_snap_context *snapc;
+	char *object_prefix = NULL;
+	char *snap_names = NULL;
+	u64 *snap_sizes = NULL;
 	u32 snap_count;
-	size_t len;
 	size_t size;
+	int ret = -ENOMEM;
 	u32 i;

-	snap_count = le32_to_cpu(ondisk->snap_count);
+	/* Allocate this now to avoid having to handle failure below */

-	len = strnlen(ondisk->object_prefix, sizeof (ondisk->object_prefix));
-	header->object_prefix = kmalloc(len + 1, GFP_KERNEL);
-	if (!header->object_prefix)
-		return -ENOMEM;
-	memcpy(header->object_prefix, ondisk->object_prefix, len);
-	header->object_prefix[len] = '\0';
+	if (first_time) {
+		size_t len;

+		len = strnlen(ondisk->object_prefix,
+				sizeof (ondisk->object_prefix));
+		object_prefix = kmalloc(len + 1, GFP_KERNEL);
+		if (!object_prefix)
+			return -ENOMEM;
+		memcpy(object_prefix, ondisk->object_prefix, len);
+		object_prefix[len] = '\0';
+	}
+
+	/* Allocate the snapshot context and fill it in */
+
+	snap_count = le32_to_cpu(ondisk->snap_count);
+	snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);
+	if (!snapc)
+		goto out_err;
+	snapc->seq = le64_to_cpu(ondisk->snap_seq);
 	if (snap_count) {
+		struct rbd_image_snap_ondisk *snaps;
 		u64 snap_names_len = le64_to_cpu(ondisk->snap_names_len);

-		/* Save a copy of the snapshot names */
+		/* We'll keep a copy of the snapshot names... */

-		if (snap_names_len > (u64) SIZE_MAX)
-			return -EIO;
-		header->snap_names = kmalloc(snap_names_len, GFP_KERNEL);
-		if (!header->snap_names)
+		if (snap_names_len > (u64)SIZE_MAX)
+			goto out_2big;
+		snap_names = kmalloc(snap_names_len, GFP_KERNEL);
+		if (!snap_names)
 			goto out_err;
-		/*
-		 * Note that rbd_dev_v1_header_read() guarantees
-		 * the ondisk buffer we're working with has
-		 * snap_names_len bytes beyond the end of the
-		 * snapshot id array, this memcpy() is safe.
-		 */
-		memcpy(header->snap_names, &ondisk->snaps[snap_count],
-			snap_names_len);

-		/* Record each snapshot's size */
+		/* ...as well as the array of their sizes. */

 		size = snap_count * sizeof (*header->snap_sizes);
-		header->snap_sizes = kmalloc(size, GFP_KERNEL);
-		if (!header->snap_sizes)
+		snap_sizes = kmalloc(size, GFP_KERNEL);
+		if (!snap_sizes)
 			goto out_err;
-		for (i = 0; i < snap_count; i++)
-			header->snap_sizes[i] =
-				le64_to_cpu(ondisk->snaps[i].image_size);
-	} else {
-		header->snap_names = NULL;
-		header->snap_sizes = NULL;
+
+		/*
+		 * Copy the names, and fill in each snapshot's id
+		 * and size.
+		 *
+		 * Note that rbd_dev_v1_header_read() guarantees the
+		 * ondisk buffer we're working with has
+		 * snap_names_len bytes beyond the end of the
+		 * snapshot id array, this memcpy() is safe.
+		 */
+		memcpy(snap_names, &ondisk->snaps[snap_count], snap_names_len);
+		snaps = ondisk->snaps;
+		for (i = 0; i < snap_count; i++) {
+			snapc->snaps[i] = le64_to_cpu(snaps[i].id);
+			snap_sizes[i] = le64_to_cpu(snaps[i].image_size);
+		}
 	}

-	header->features = 0;	/* No features support in v1 images */
-	header->obj_order = ondisk->options.order;
-	header->crypt_type = ondisk->options.crypt_type;
-	header->comp_type = ondisk->options.comp_type;
+	/* We won't fail any more, fill in the header */
+
+	if (first_time) {
+		header->object_prefix = object_prefix;
+		header->obj_order = ondisk->options.order;
+		header->crypt_type = ondisk->options.crypt_type;
+		header->comp_type = ondisk->options.comp_type;
+		/* The rest aren't used for format 1 images */
+		header->stripe_unit = 0;
+		header->stripe_count = 0;
+		header->features = 0;
+	}

-	/* Allocate and fill in the snapshot context */
+	/* The remaining fields always get updated (when we refresh) */

 	header->image_size = le64_to_cpu(ondisk->image_size);
-
-	header->snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);
-	if (!header->snapc)
-		goto out_err;
-	header->snapc->seq = le64_to_cpu(ondisk->snap_seq);
-	for (i = 0; i < snap_count; i++)
-		header->snapc->snaps[i] = le64_to_cpu(ondisk->snaps[i].id);
+	header->snapc = snapc;
+	header->snap_names = snap_names;
+	header->snap_sizes = snap_sizes;

 	return 0;
-
+out_2big:
+	ret = -EIO;
 out_err:
-	kfree(header->snap_sizes);
-	header->snap_sizes = NULL;
-	kfree(header->snap_names);
-	header->snap_names = NULL;
-	kfree(header->object_prefix);
-	header->object_prefix = NULL;
+	kfree(snap_sizes);
+	kfree(snap_names);
+	ceph_put_snap_context(snapc);
+	kfree(object_prefix);

-	return -ENOMEM;
+	return ret;
 }

 static const char *_rbd_dev_v1_snap_name(struct rbd_device *rbd_dev,
u32 which)
-- 
1.7.9.5

