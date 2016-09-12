From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 47/47] block-rbd: Delete unwanted spaces behind usages of the
 sizeof operator
Date: Mon, 12 Sep 2016 21:36:08 +0200
Message-ID: <06c045b8-a1d4-8ae9-e5e1-67d11d814451@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 20:10:13 +0200

* Replace the source code "sizeof (" by "sizeof("
  according to the Linux coding style convention.

* Improve indentation at some places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 112 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8897815..4ed6983 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -101,7 +101,7 @@ static int atomic_dec_return_safe(atomic_t *v)
 
 #define RBD_SNAP_DEV_NAME_PREFIX	"snap_"
 #define RBD_MAX_SNAP_NAME_LEN	\
-			(NAME_MAX - (sizeof (RBD_SNAP_DEV_NAME_PREFIX) - 1))
+			(NAME_MAX - (sizeof(RBD_SNAP_DEV_NAME_PREFIX) - 1))
 
 #define RBD_MAX_SNAP_COUNT	510	/* allows max snapc to fit in 4KB */
 
@@ -110,7 +110,7 @@ static int atomic_dec_return_safe(atomic_t *v)
 #define	BAD_SNAP_INDEX	U32_MAX		/* invalid index into snap array */
 
 /* This allows a single page to hold an image name sent by OSD */
-#define RBD_IMAGE_NAME_LEN_MAX	(PAGE_SIZE - sizeof (__le32) - 1)
+#define RBD_IMAGE_NAME_LEN_MAX	(PAGE_SIZE - sizeof(__le32) - 1)
 #define RBD_IMAGE_ID_LEN_MAX	64
 
 #define RBD_OBJ_PREFIX_LEN_MAX	64
@@ -931,7 +931,7 @@ static bool rbd_dev_ondisk_valid(struct rbd_image_header_ondisk *ondisk)
 	u32 snap_count;
 
 	/* The header has to start with the magic rbd header text */
-	if (memcmp(&ondisk->text, RBD_HEADER_TEXT, sizeof (RBD_HEADER_TEXT)))
+	if (memcmp(&ondisk->text, RBD_HEADER_TEXT, sizeof(RBD_HEADER_TEXT)))
 		return false;
 
 	/* The bio layer requires at least sector-sized I/O */
@@ -941,7 +941,7 @@ static bool rbd_dev_ondisk_valid(struct rbd_image_header_ondisk *ondisk)
 
 	/* If we use u64 in a few spots we may be able to loosen this */
 
-	if (ondisk->options.order > 8 * sizeof (int) - 1)
+	if (ondisk->options.order > 8 * sizeof(int) - 1)
 		return false;
 
 	/*
@@ -949,15 +949,15 @@ static bool rbd_dev_ondisk_valid(struct rbd_image_header_ondisk *ondisk)
 	 * that limits the number of snapshots.
 	 */
 	snap_count = le32_to_cpu(ondisk->snap_count);
-	size = SIZE_MAX - sizeof (struct ceph_snap_context);
-	if (snap_count > size / sizeof (__le64))
+	size = SIZE_MAX - sizeof(struct ceph_snap_context);
+	if (snap_count > size / sizeof(__le64))
 		return false;
 
 	/*
 	 * Not only that, but the size of the entire the snapshot
 	 * header must also be representable in a size_t.
 	 */
-	size -= snap_count * sizeof (__le64);
+	size -= snap_count * sizeof(__le64);
 	if ((u64) size < le64_to_cpu(ondisk->snap_names_len))
 		return false;
 
@@ -987,7 +987,7 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 		size_t len;
 
 		len = strnlen(ondisk->object_prefix,
-				sizeof (ondisk->object_prefix));
+			      sizeof(ondisk->object_prefix));
 		object_prefix = kmalloc(len + 1, GFP_KERNEL);
 		if (!object_prefix)
 			return -ENOMEM;
@@ -1121,7 +1121,7 @@ static u32 rbd_dev_snap_index(struct rbd_device *rbd_dev, u64 snap_id)
 	u64 *found;
 
 	found = bsearch(&snap_id, &snapc->snaps, snapc->num_snaps,
-				sizeof (snap_id), snapid_compare_reverse);
+			sizeof(snap_id), snapid_compare_reverse);
 
 	return found ? (u32)(found - &snapc->snaps[0]) : BAD_SNAP_INDEX;
 }
@@ -2906,7 +2906,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 	 *         le32 tv_nsec;
 	 *     } mtime;
 	 */
-	size = sizeof (__le64) + sizeof (__le32) + sizeof (__le32);
+	size = sizeof(__le64) + sizeof(__le32) + sizeof(__le32);
 	page_count = (u32)calc_pages_for(0, size);
 	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
 	if (IS_ERR(pages))
@@ -4023,7 +4023,7 @@ static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
 	if (outbound_size) {
 		struct ceph_pagelist *pagelist;
 
-		pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
+		pagelist = kmalloc(sizeof(*pagelist), GFP_NOFS);
 		if (!pagelist)
 			goto out;
 
@@ -4332,8 +4332,8 @@ static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 
 		kfree(ondisk);
 
-		size = sizeof (*ondisk);
-		size += snap_count * sizeof (struct rbd_image_snap_ondisk);
+		size = sizeof(*ondisk);
+		size += snap_count * sizeof(struct rbd_image_snap_ondisk);
 		size += names_size;
 		ondisk = kmalloc(size, GFP_KERNEL);
 		if (!ondisk)
@@ -4797,7 +4797,7 @@ static struct rbd_spec *rbd_spec_alloc(void)
 {
 	struct rbd_spec *spec;
 
-	spec = kzalloc(sizeof (*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return NULL;
 
@@ -4961,14 +4961,18 @@ static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
 		__le64 size;
 	} __attribute__ ((packed)) size_buf = { 0 };
 
-	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_oid.name,
-				"rbd", "get_size",
-				&snapid, sizeof (snapid),
-				&size_buf, sizeof (size_buf));
+	ret = rbd_obj_method_sync(rbd_dev,
+				  rbd_dev->header_oid.name,
+				  "rbd",
+				  "get_size",
+				  &snapid,
+				  sizeof(snapid),
+				  &size_buf,
+				  sizeof(size_buf));
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
-	if (ret < sizeof (size_buf))
+	if (ret < sizeof(size_buf))
 		return -ERANGE;
 
 	if (order) {
@@ -5036,14 +5040,18 @@ static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
 	u64 unsup;
 	int ret;
 
-	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_oid.name,
-				"rbd", "get_features",
-				&snapid, sizeof (snapid),
-				&features_buf, sizeof (features_buf));
+	ret = rbd_obj_method_sync(rbd_dev,
+				  rbd_dev->header_oid.name,
+				  "rbd",
+				  "get_features",
+				  &snapid,
+				  sizeof(snapid),
+				  &features_buf,
+				  sizeof(features_buf));
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		return ret;
-	if (ret < sizeof (features_buf))
+	if (ret < sizeof(features_buf))
 		return -ERANGE;
 
 	unsup = le64_to_cpu(features_buf.incompat) & ~RBD_FEATURES_SUPPORTED;
@@ -5087,10 +5095,10 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	if (!parent_spec)
 		return -ENOMEM;
 
-	size = sizeof (__le64) +				/* pool_id */
-		sizeof (__le32) + RBD_IMAGE_ID_LEN_MAX +	/* image_id */
-		sizeof (__le64) +				/* snap_id */
-		sizeof (__le64);				/* overlap */
+	size = sizeof(__le64) +				/* pool_id */
+	       sizeof(__le32) + RBD_IMAGE_ID_LEN_MAX +	/* image_id */
+	       sizeof(__le64) +				/* snap_id */
+	       sizeof(__le64);				/* overlap */
 	reply_buf = kmalloc(size, GFP_KERNEL);
 	if (!reply_buf) {
 		ret = -ENOMEM;
@@ -5098,10 +5106,14 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 	}
 
 	snapid = cpu_to_le64(rbd_dev->spec->snap_id);
-	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_oid.name,
-				"rbd", "get_parent",
-				&snapid, sizeof (snapid),
-				reply_buf, size);
+	ret = rbd_obj_method_sync(rbd_dev,
+				  rbd_dev->header_oid.name,
+				  "rbd",
+				  "get_parent",
+				  &snapid,
+				  sizeof(snapid),
+				  reply_buf,
+				  size);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0)
 		goto free_buffer;
@@ -5194,7 +5206,7 @@ static int rbd_dev_v2_striping_info(struct rbd_device *rbd_dev)
 		__le64 stripe_unit;
 		__le64 stripe_count;
 	} __attribute__ ((packed)) striping_info_buf = { 0 };
-	size_t size = sizeof (striping_info_buf);
+	size_t size = sizeof(striping_info_buf);
 	void *p;
 	u64 obj_size;
 	u64 stripe_unit;
@@ -5253,7 +5265,7 @@ static char *rbd_dev_image_name(struct rbd_device *rbd_dev)
 	rbd_assert(!rbd_dev->spec->image_name);
 
 	len = strlen(rbd_dev->spec->image_id);
-	image_id_size = sizeof (__le32) + len;
+	image_id_size = sizeof(__le32) + len;
 	image_id = kmalloc(image_id_size, GFP_KERNEL);
 	if (!image_id)
 		return NULL;
@@ -5262,7 +5274,7 @@ static char *rbd_dev_image_name(struct rbd_device *rbd_dev)
 	end = image_id + image_id_size;
 	ceph_encode_string(&p, end, rbd_dev->spec->image_id, (u32)len);
 
-	size = sizeof (__le32) + RBD_IMAGE_NAME_LEN_MAX;
+	size = sizeof(__le32) + RBD_IMAGE_NAME_LEN_MAX;
 	reply_buf = kmalloc(size, GFP_KERNEL);
 	if (!reply_buf)
 		goto free_id;
@@ -5443,8 +5455,8 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
 	 * For now we have a fixed upper limit on the number we're
 	 * prepared to receive.
 	 */
-	size = sizeof (__le64) + sizeof (__le32) +
-			RBD_MAX_SNAP_COUNT * sizeof (__le64);
+	size = sizeof(__le64) + sizeof(__le32) +
+	       RBD_MAX_SNAP_COUNT * sizeof(__le64);
 	reply_buf = kzalloc(size, GFP_KERNEL);
 	if (!reply_buf)
 		return -ENOMEM;
@@ -5468,12 +5480,12 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev)
 	 * make sure the computed size of the snapshot context we
 	 * allocate is representable in a size_t.
 	 */
-	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
-				 / sizeof (u64)) {
+	if (snap_count > (SIZE_MAX - sizeof(struct ceph_snap_context))
+			 / sizeof(u64)) {
 		ret = -EINVAL;
 		goto free_buffer;
 	}
-	if (!ceph_has_room(&p, end, snap_count * sizeof (__le64)))
+	if (!ceph_has_room(&p, end, snap_count * sizeof(__le64)))
 		goto free_buffer;
 	ret = 0;
 
@@ -5508,16 +5520,20 @@ static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 	void *end;
 	char *snap_name;
 
-	size = sizeof (__le32) + RBD_MAX_SNAP_NAME_LEN;
+	size = sizeof(__le32) + RBD_MAX_SNAP_NAME_LEN;
 	reply_buf = kmalloc(size, GFP_KERNEL);
 	if (!reply_buf)
 		return ERR_PTR(-ENOMEM);
 
 	snapid = cpu_to_le64(snap_id);
-	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_oid.name,
-				"rbd", "get_snapshot_name",
-				&snapid, sizeof (snapid),
-				reply_buf, size);
+	ret = rbd_obj_method_sync(rbd_dev,
+				  rbd_dev->header_oid.name,
+				  "rbd",
+				  "get_snapshot_name",
+				  &snapid,
+				  sizeof(snapid),
+				  reply_buf,
+				  size);
 	dout("%s: rbd_obj_method_sync returned %d\n", __func__, ret);
 	if (ret < 0) {
 		snap_name = ERR_PTR(ret);
@@ -5728,7 +5744,7 @@ static int rbd_add_parse_args(const char *buf,
 	len = next_token(&buf);
 	if (!len) {
 		buf = RBD_SNAP_HEAD_NAME; /* No snapshot supplied */
-		len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
+		len = sizeof(RBD_SNAP_HEAD_NAME) - 1;
 	} else if (len > RBD_MAX_SNAP_NAME_LEN) {
 		ret = -ENAMETOOLONG;
 		goto free_options;
@@ -5741,7 +5757,7 @@ static int rbd_add_parse_args(const char *buf,
 
 	/* Initialize all rbd options to the defaults */
 
-	rbd_opts = kzalloc(sizeof (*rbd_opts), GFP_KERNEL);
+	rbd_opts = kzalloc(sizeof(*rbd_opts), GFP_KERNEL);
 	if (!rbd_opts)
 		goto status_indication;
 
@@ -5906,7 +5922,7 @@ static void rbd_dev_unprobe(struct rbd_device *rbd_dev)
 	kfree(header->snap_sizes);
 	kfree(header->snap_names);
 	kfree(header->object_prefix);
-	memset(header, 0, sizeof (*header));
+	memset(header, 0, sizeof(*header));
 }
 
 static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev)
-- 
2.10.0
