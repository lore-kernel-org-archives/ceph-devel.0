From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: clean up a few things in the refresh path
Date: Wed, 29 May 2013 15:50:18 -0500
Message-ID: <51A66A0A.3010909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:57998 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966493Ab3E2UuF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 16:50:05 -0400
Received: by mail-ve0-f178.google.com with SMTP id pb11so5131951veb.23
        for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 13:50:04 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id l5sm16842599vev.1.2013.05.29.13.50.03
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 13:50:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(This and the next two patches I'm about to post are available in
the "review/wip-rbd" branch of the ceph-client git repository.)

This includes a few relatively small fixes I found while examining
the code that refreshes image information.

This resolves:
    http://tracker.ceph.com/issues/5040

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   53
+++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f860dd6..aec2438 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2876,7 +2876,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 		(unsigned int)opcode);
 	ret = rbd_dev_refresh(rbd_dev);
 	if (ret)
-		rbd_warn(rbd_dev, ": header refresh error (%d)\n", ret);
+		rbd_warn(rbd_dev, "header refresh error (%d)\n", ret);

 	rbd_obj_notify_ack(rbd_dev, notify_id);
 }
@@ -3356,8 +3356,8 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	int ret;

 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
-	mapping_size = rbd_dev->mapping.size;
 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	mapping_size = rbd_dev->mapping.size;
 	if (rbd_dev->image_format == 1)
 		ret = rbd_dev_v1_header_info(rbd_dev);
 	else
@@ -3830,6 +3830,7 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	void *end;
 	u64 pool_id;
 	char *image_id;
+	u64 snap_id;
 	u64 overlap;
 	int ret;

@@ -3889,24 +3890,56 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 			(unsigned long long)pool_id, U32_MAX);
 		goto out_err;
 	}
-	parent_spec->pool_id = pool_id;

 	image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
 	if (IS_ERR(image_id)) {
 		ret = PTR_ERR(image_id);
 		goto out_err;
 	}
-	parent_spec->image_id = image_id;
-	ceph_decode_64_safe(&p, end, parent_spec->snap_id, out_err);
+	ceph_decode_64_safe(&p, end, snap_id, out_err);
 	ceph_decode_64_safe(&p, end, overlap, out_err);

-	if (overlap) {
-		rbd_spec_put(rbd_dev->parent_spec);
+	/*
+	 * The parent won't change (except when the clone is
+	 * flattened, already handled that).  So we only need to
+	 * record the parent spec we have not already done so.
+	 */
+	if (!rbd_dev->parent_spec) {
+		parent_spec->pool_id = pool_id;
+		parent_spec->image_id = image_id;
+		parent_spec->snap_id = snap_id;
 		rbd_dev->parent_spec = parent_spec;
 		parent_spec = NULL;	/* rbd_dev now owns this */
-		rbd_dev->parent_overlap = overlap;
-	} else {
-		rbd_warn(rbd_dev, "ignoring parent of clone with overlap 0\n");
+	}
+
+	/*
+	 * We always update the parent overlap.  If it's zero we
+	 * treat it specially.
+	 */
+	rbd_dev->parent_overlap = overlap;
+	smp_mb();
+	if (!overlap) {
+
+		/* A null parent_spec indicates it's the initial probe */
+
+		if (parent_spec) {
+			/*
+			 * The overlap has become zero, so the clone
+			 * must have been resized down to 0 at some
+			 * point.  Treat this the same as a flatten.
+			 */
+			rbd_dev_parent_put(rbd_dev);
+			pr_info("%s: clone image now standalone\n",
+				rbd_dev->disk->disk_name);
+		} else {
+			/*
+			 * For the initial probe, if we find the
+			 * overlap is zero we just pretend there was
+			 * no parent image.
+			 */
+			rbd_warn(rbd_dev, "ignoring parent of "
+						"clone with overlap 0\n");
+		}
 	}
 out:
 	ret = 0;
-- 
1.7.9.5

