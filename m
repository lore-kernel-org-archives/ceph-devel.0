From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH] rbd: clean up a few things in the refresh path
Date: Thu, 30 May 2013 10:35:38 -0700
Message-ID: <0b2ec7a2-c373-4984-88b3-844f075a20a0@email.android.com>
References: <51A66A0A.3010909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58297 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339Ab3E3Sgs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 14:36:48 -0400
In-Reply-To: <51A66A0A.3010909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

Alex Elder <elder@inktank.com> wrote:

>(This and the next two patches I'm about to post are available in
>the "review/wip-rbd" branch of the ceph-client git repository.)
>
>This includes a few relatively small fixes I found while examining
>the code that refreshes image information.
>
>This resolves:
>    http://tracker.ceph.com/issues/5040
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |   53
>+++++++++++++++++++++++++++++++++++++++++----------
> 1 file changed, 43 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index f860dd6..aec2438 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -2876,7 +2876,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
>u8 opcode, void *data)
> 		(unsigned int)opcode);
> 	ret = rbd_dev_refresh(rbd_dev);
> 	if (ret)
>-		rbd_warn(rbd_dev, ": header refresh error (%d)\n", ret);
>+		rbd_warn(rbd_dev, "header refresh error (%d)\n", ret);
>
> 	rbd_obj_notify_ack(rbd_dev, notify_id);
> }
>@@ -3356,8 +3356,8 @@ static int rbd_dev_refresh(struct rbd_device
>*rbd_dev)
> 	int ret;
>
> 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
>-	mapping_size = rbd_dev->mapping.size;
> 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>+	mapping_size = rbd_dev->mapping.size;
> 	if (rbd_dev->image_format == 1)
> 		ret = rbd_dev_v1_header_info(rbd_dev);
> 	else
>@@ -3830,6 +3830,7 @@ static int rbd_dev_v2_parent_info(struct
>rbd_device *rbd_dev)
> 	void *end;
> 	u64 pool_id;
> 	char *image_id;
>+	u64 snap_id;
> 	u64 overlap;
> 	int ret;
>
>@@ -3889,24 +3890,56 @@ static int rbd_dev_v2_parent_info(struct
>rbd_device *rbd_dev)
> 			(unsigned long long)pool_id, U32_MAX);
> 		goto out_err;
> 	}
>-	parent_spec->pool_id = pool_id;
>
> 	image_id = ceph_extract_encoded_string(&p, end, NULL, GFP_KERNEL);
> 	if (IS_ERR(image_id)) {
> 		ret = PTR_ERR(image_id);
> 		goto out_err;
> 	}
>-	parent_spec->image_id = image_id;
>-	ceph_decode_64_safe(&p, end, parent_spec->snap_id, out_err);
>+	ceph_decode_64_safe(&p, end, snap_id, out_err);
> 	ceph_decode_64_safe(&p, end, overlap, out_err);
>
>-	if (overlap) {
>-		rbd_spec_put(rbd_dev->parent_spec);
>+	/*
>+	 * The parent won't change (except when the clone is
>+	 * flattened, already handled that).  So we only need to
>+	 * record the parent spec we have not already done so.
>+	 */
>+	if (!rbd_dev->parent_spec) {
>+		parent_spec->pool_id = pool_id;
>+		parent_spec->image_id = image_id;
>+		parent_spec->snap_id = snap_id;
> 		rbd_dev->parent_spec = parent_spec;
> 		parent_spec = NULL;	/* rbd_dev now owns this */
>-		rbd_dev->parent_overlap = overlap;
>-	} else {
>-		rbd_warn(rbd_dev, "ignoring parent of clone with overlap 0\n");
>+	}
>+
>+	/*
>+	 * We always update the parent overlap.  If it's zero we
>+	 * treat it specially.
>+	 */
>+	rbd_dev->parent_overlap = overlap;
>+	smp_mb();
>+	if (!overlap) {
>+
>+		/* A null parent_spec indicates it's the initial probe */
>+
>+		if (parent_spec) {
>+			/*
>+			 * The overlap has become zero, so the clone
>+			 * must have been resized down to 0 at some
>+			 * point.  Treat this the same as a flatten.
>+			 */
>+			rbd_dev_parent_put(rbd_dev);
>+			pr_info("%s: clone image now standalone\n",
>+				rbd_dev->disk->disk_name);
>+		} else {
>+			/*
>+			 * For the initial probe, if we find the
>+			 * overlap is zero we just pretend there was
>+			 * no parent image.
>+			 */
>+			rbd_warn(rbd_dev, "ignoring parent of "
>+						"clone with overlap 0\n");
>+		}
> 	}
> out:
> 	ret = 0;

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
