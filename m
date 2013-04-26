From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/7] rbd: define rbd snap context routines
Date: Fri, 26 Apr 2013 13:00:36 -0500
Message-ID: <517AC0C4.9080403@inktank.com>
References: <517AC047.6060000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:46350 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab3DZSAi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 14:00:38 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so3991191iag.0
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 11:00:37 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id fl5sm4340163igb.9.2013.04.26.11.00.36
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 11:00:37 -0700 (PDT)
In-Reply-To: <517AC047.6060000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Encapsulate the creation of a snapshot context for rbd in a new
function rbd_snap_context_create().  Define rbd wrappers for getting
and dropping references to them once they're created.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   65
++++++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fe84975..63040fd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -671,6 +671,35 @@ static void rbd_client_release(struct kref *kref)
 	kfree(rbdc);
 }

+/* Caller has to fill in snapc->seq and snapc->snaps[0..snap_count-1] */
+
+static struct ceph_snap_context *rbd_snap_context_create(u32 snap_count)
+{
+	struct ceph_snap_context *snapc;
+	size_t size;
+
+	size = sizeof (struct ceph_snap_context);
+	size += snap_count * sizeof (snapc->snaps[0]);
+	snapc = kzalloc(size, GFP_KERNEL);
+	if (!snapc)
+		return NULL;
+
+	atomic_set(&snapc->nref, 1);
+	snapc->num_snaps = snap_count;
+
+	return snapc;
+}
+
+static inline void rbd_snap_context_get(struct ceph_snap_context *snapc)
+{
+	(void)ceph_get_snap_context(snapc);
+}
+
+static inline void rbd_snap_context_put(struct ceph_snap_context *snapc)
+{
+	ceph_put_snap_context(snapc);
+}
+
 /*
  * Drop reference to ceph client node. If it's not referenced anymore,
release
  * it.
@@ -789,18 +818,13 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 	/* Allocate and fill in the snapshot context */

 	header->image_size = le64_to_cpu(ondisk->image_size);
-	size = sizeof (struct ceph_snap_context);
-	size += snap_count * sizeof (header->snapc->snaps[0]);
-	header->snapc = kzalloc(size, GFP_KERNEL);
+
+	header->snapc = rbd_snap_context_create(snap_count);
 	if (!header->snapc)
 		goto out_err;
-
-	atomic_set(&header->snapc->nref, 1);
 	header->snapc->seq = le64_to_cpu(ondisk->snap_seq);
-	header->snapc->num_snaps = snap_count;
 	for (i = 0; i < snap_count; i++)
-		header->snapc->snaps[i] =
-			le64_to_cpu(ondisk->snaps[i].id);
+		header->snapc->snaps[i] = le64_to_cpu(ondisk->snaps[i].id);

 	return 0;

@@ -870,7 +894,7 @@ static void rbd_header_free(struct rbd_image_header
*header)
 	header->snap_sizes = NULL;
 	kfree(header->snap_names);
 	header->snap_names = NULL;
-	ceph_put_snap_context(header->snapc);
+	rbd_snap_context_put(header->snapc);
 	header->snapc = NULL;
 }

@@ -1720,7 +1744,6 @@ static struct rbd_img_request *rbd_img_request_create(
 					bool child_request)
 {
 	struct rbd_img_request *img_request;
-	struct ceph_snap_context *snapc = NULL;

 	img_request = kmalloc(sizeof (*img_request), GFP_ATOMIC);
 	if (!img_request)
@@ -1728,13 +1751,8 @@ static struct rbd_img_request
*rbd_img_request_create(

 	if (write_request) {
 		down_read(&rbd_dev->header_rwsem);
-		snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+		rbd_snap_context_get(rbd_dev->header.snapc);
 		up_read(&rbd_dev->header_rwsem);
-		if (WARN_ON(!snapc)) {
-			kfree(img_request);
-			return NULL;	/* Shouldn't happen */
-		}
-
 	}

 	img_request->rq = NULL;
@@ -1744,7 +1762,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	img_request->flags = 0;
 	if (write_request) {
 		img_request_write_set(img_request);
-		img_request->snapc = snapc;
+		img_request->snapc = rbd_dev->header.snapc;
 	} else {
 		img_request->snap_id = rbd_dev->spec->snap_id;
 	}
@@ -1785,7 +1803,7 @@ static void rbd_img_request_destroy(struct kref *kref)
 	rbd_assert(img_request->obj_request_count == 0);

 	if (img_request_write_test(img_request))
-		ceph_put_snap_context(img_request->snapc);
+		rbd_snap_context_put(img_request->snapc);

 	if (img_request_child_test(img_request))
 		rbd_obj_request_put(img_request->obj_request);
@@ -3049,7 +3067,7 @@ static int rbd_dev_v1_refresh(struct rbd_device
*rbd_dev, u64 *hver)
 	kfree(rbd_dev->header.snap_sizes);
 	kfree(rbd_dev->header.snap_names);
 	/* osd requests may still refer to snapc */
-	ceph_put_snap_context(rbd_dev->header.snapc);
+	rbd_snap_context_put(rbd_dev->header.snapc);

 	if (hver)
 		*hver = h.obj_version;
@@ -3889,19 +3907,14 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev, u64 *ver)
 	}
 	if (!ceph_has_room(&p, end, snap_count * sizeof (__le64)))
 		goto out;
+	ret = 0;

-	size = sizeof (struct ceph_snap_context) +
-				snap_count * sizeof (snapc->snaps[0]);
-	snapc = kmalloc(size, GFP_KERNEL);
+	snapc = rbd_snap_context_create(snap_count);
 	if (!snapc) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = 0;
-
-	atomic_set(&snapc->nref, 1);
 	snapc->seq = seq;
-	snapc->num_snaps = snap_count;
 	for (i = 0; i < snap_count; i++)
 		snapc->snaps[i] = ceph_decode_64(&p);

-- 
1.7.9.5

