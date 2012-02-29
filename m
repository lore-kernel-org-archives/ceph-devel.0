From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/2] rbd: do some refactoring
Date: Tue, 28 Feb 2012 20:37:14 -0800
Message-ID: <4F4DAB7A.3020808@dreamhost.com>
References: <4F4DA340.3040202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54632 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756456Ab2B2EhU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:37:20 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 83B362431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:37:20 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 725B124314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:37:20 -0800 (PST)
In-Reply-To: <4F4DA340.3040202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A few blocks of code are rearranged a bit here:
     - In rbd_header_from_disk():
	- Don't bother computing snap_count until we're sure the
	  on-disk header starts with a good signature.
	- Move a few independent lines of code so they are *after* a
	  check for a failed memory allocation.
	- Get rid of unnecessary local variable "ret".
     - Make a few other changes in rbd_read_header(), similar to the
       above--just moving things around a bit while preserving the
       functionality.
     - In rbd_rq_fn(), just assign rq in the while loop's controlling
       expression rather than duplicating it before and at the end of
       the loop body.  This allows the use of "continue" rather than
       "goto next" in a number of spots.
     - Rearrange the logic in snap_by_name().  End result is the same.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   80 
+++++++++++++++++++++++++-------------------------
  1 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b7c9af5..a04322c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -486,19 +486,20 @@ static int rbd_header_from_disk(struct 
rbd_image_header *header,
  				 gfp_t gfp_flags)
  {
  	int i;
-	u32 snap_count = le32_to_cpu(ondisk->snap_count);
-	int ret = -ENOMEM;
+	u32 snap_count;

  	if (memcmp(ondisk, RBD_HEADER_TEXT, sizeof(RBD_HEADER_TEXT)))
  		return -ENXIO;

-	init_rwsem(&header->snap_rwsem);
-	header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
+	snap_count = le32_to_cpu(ondisk->snap_count);
  	header->snapc = kmalloc(sizeof(struct ceph_snap_context) +
  				snap_count * sizeof *ondisk,
  				gfp_flags);
  	if (!header->snapc)
  		return -ENOMEM;
+
+	init_rwsem(&header->snap_rwsem);
+	header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
  	if (snap_count) {
  		header->snap_names = kmalloc(header->snap_names_len,
  					     GFP_KERNEL);
@@ -544,7 +545,7 @@ err_names:
  	kfree(header->snap_names);
  err_snapc:
  	kfree(header->snapc);
-	return ret;
+	return -ENOMEM;
  }

  static int snap_index(struct rbd_image_header *header, int snap_num)
@@ -568,19 +569,20 @@ static int snap_by_name(struct rbd_image_header 
*header, const char *snap_name,
  	int i;
  	char *p = header->snap_names;

-	for (i = 0; i < header->total_snaps; i++, p += strlen(p) + 1) {
-		if (strcmp(snap_name, p) == 0)
-			break;
-	}
-	if (i == header->total_snaps)
-		return -ENOENT;
-	if (seq)
-		*seq = header->snapc->snaps[i];
+	for (i = 0; i < header->total_snaps; i++) {
+		if (!strcmp(snap_name, p)) {

-	if (size)
-		*size = header->snap_sizes[i];
+			/* Found it.  Pass back its id and/or size */

-	return i;
+			if (seq)
+				*seq = header->snapc->snaps[i];
+			if (size)
+				*size = header->snap_sizes[i];
+			return i;
+		}
+		p += strlen(p) + 1;	/* Skip ahead to the next name */
+	}
+	return -ENOENT;
  }

  static int rbd_header_set_snap(struct rbd_device *dev,
@@ -1443,9 +1445,7 @@ static void rbd_rq_fn(struct request_queue *q)
  	struct request *rq;
  	struct bio_pair *bp = NULL;

-	rq = blk_fetch_request(q);
-
-	while (1) {
+	while ((rq = blk_fetch_request(q))) {
  		struct bio *bio;
  		struct bio *rq_bio, *next_bio = NULL;
  		bool do_write;
@@ -1463,7 +1463,7 @@ static void rbd_rq_fn(struct request_queue *q)
  		/* filter out block requests we don't understand */
  		if ((rq->cmd_type != REQ_TYPE_FS)) {
  			__blk_end_request_all(rq, 0);
-			goto next;
+			continue;
  		}

  		/* deduce our operation (read, write) */
@@ -1474,7 +1474,7 @@ static void rbd_rq_fn(struct request_queue *q)
  		rq_bio = rq->bio;
  		if (do_write && rbd_dev->read_only) {
  			__blk_end_request_all(rq, -EROFS);
-			goto next;
+			continue;
  		}

  		spin_unlock_irq(q->queue_lock);
@@ -1488,7 +1488,7 @@ static void rbd_rq_fn(struct request_queue *q)
  		if (!coll) {
  			spin_lock_irq(q->queue_lock);
  			__blk_end_request_all(rq, -ENOMEM);
-			goto next;
+			continue;
  		}

  		do {
@@ -1534,8 +1534,6 @@ next_seg:
  		if (bp)
  			bio_pair_release(bp);
  		spin_lock_irq(q->queue_lock);
-next:
-		rq = blk_fetch_request(q);
  	}
  }

@@ -1587,15 +1585,16 @@ static int rbd_read_header(struct rbd_device 
*rbd_dev,
  	ssize_t rc;
  	struct rbd_image_header_ondisk *dh;
  	int snap_count = 0;
-	u64 snap_names_len = 0;
  	u64 ver;
+	size_t len;

+	/*
+	 * First reads the fixed-size header to determine the number
+	 * of snapshots, then re-reads it, along with all snapshot
+	 * records as well as their stored names.
+	 */
+	len = sizeof *dh;
  	while (1) {
-		int len = sizeof(*dh) +
-			  snap_count * sizeof(struct rbd_image_snap_ondisk) +
-			  snap_names_len;
-
-		rc = -ENOMEM;
  		dh = kmalloc(len, GFP_KERNEL);
  		if (!dh)
  			return -ENOMEM;
@@ -1610,21 +1609,22 @@ static int rbd_read_header(struct rbd_device 
*rbd_dev,

  		rc = rbd_header_from_disk(header, dh, snap_count, GFP_KERNEL);
  		if (rc < 0) {
-			if (rc == -ENXIO) {
+			if (rc == -ENXIO)
  				pr_warning("unrecognized header format"
  					   " for image %s", rbd_dev->obj);
-			}
  			goto out_dh;
  		}

-		if (snap_count != header->total_snaps) {
-			snap_count = header->total_snaps;
-			snap_names_len = header->snap_names_len;
-			rbd_header_free(header);
-			kfree(dh);
-			continue;
-		}
-		break;
+		if (snap_count == header->total_snaps)
+			break;
+
+		snap_count = header->total_snaps;
+		len = sizeof *dh +
+			snap_count * sizeof(struct rbd_image_snap_ondisk) +
+			header->snap_names_len;
+
+		rbd_header_free(header);
+		kfree(dh);
  	}
  	header->obj_version = ver;

-- 
1.7.5.4

