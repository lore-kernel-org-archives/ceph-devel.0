From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] ceph: use ceph_create_snap_context()
Date: Tue, 30 Apr 2013 07:19:19 -0500
Message-ID: <517FB6C7.3070105@inktank.com>
References: <517FB65D.5040309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:47530 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760235Ab3D3MTW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:19:22 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so476103ief.35
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:19:21 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id p10sm19508589igj.5.2013.04.30.05.19.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:19:20 -0700 (PDT)
In-Reply-To: <517FB65D.5040309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now that we have a library routine to create snap contexts, use it.

This is part of:
    http://tracker.ceph.com/issues/4857

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   41 ++++++-----------------------------------
 fs/ceph/snap.c      |    3 +--
 2 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8b680ad..8b30d83 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -672,35 +672,6 @@ static void rbd_client_release(struct kref *kref)
 	kfree(rbdc);
 }

-/* Caller has to fill in snapc->seq and snapc->snaps[0..snap_count-1] */
-
-static struct ceph_snap_context *rbd_snap_context_create(u32 snap_count)
-{
-	struct ceph_snap_context *snapc;
-	size_t size;
-
-	size = sizeof (struct ceph_snap_context);
-	size += snap_count * sizeof (snapc->snaps[0]);
-	snapc = kzalloc(size, GFP_KERNEL);
-	if (!snapc)
-		return NULL;
-
-	atomic_set(&snapc->nref, 1);
-	snapc->num_snaps = snap_count;
-
-	return snapc;
-}
-
-static inline void rbd_snap_context_get(struct ceph_snap_context *snapc)
-{
-	(void)ceph_get_snap_context(snapc);
-}
-
-static inline void rbd_snap_context_put(struct ceph_snap_context *snapc)
-{
-	ceph_put_snap_context(snapc);
-}
-
 /*
  * Drop reference to ceph client node. If it's not referenced anymore,
release
  * it.
@@ -820,7 +791,7 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,

 	header->image_size = le64_to_cpu(ondisk->image_size);

-	header->snapc = rbd_snap_context_create(snap_count);
+	header->snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);
 	if (!header->snapc)
 		goto out_err;
 	header->snapc->seq = le64_to_cpu(ondisk->snap_seq);
@@ -1753,7 +1724,7 @@ static struct rbd_img_request *rbd_img_request_create(

 	if (write_request) {
 		down_read(&rbd_dev->header_rwsem);
-		rbd_snap_context_get(rbd_dev->header.snapc);
+		ceph_get_snap_context(rbd_dev->header.snapc);
 		up_read(&rbd_dev->header_rwsem);
 	}

@@ -1805,7 +1776,7 @@ static void rbd_img_request_destroy(struct kref *kref)
 	rbd_assert(img_request->obj_request_count == 0);

 	if (img_request_write_test(img_request))
-		rbd_snap_context_put(img_request->snapc);
+		ceph_put_snap_context(img_request->snapc);

 	if (img_request_child_test(img_request))
 		rbd_obj_request_put(img_request->obj_request);
@@ -3071,7 +3042,7 @@ static int rbd_dev_v1_refresh(struct rbd_device
*rbd_dev, u64 *hver)
 	kfree(rbd_dev->header.snap_sizes);
 	kfree(rbd_dev->header.snap_names);
 	/* osd requests may still refer to snapc */
-	rbd_snap_context_put(rbd_dev->header.snapc);
+	ceph_put_snap_context(rbd_dev->header.snapc);

 	if (hver)
 		*hver = h.obj_version;
@@ -3914,7 +3885,7 @@ static int rbd_dev_v2_snap_context(struct
rbd_device *rbd_dev, u64 *ver)
 		goto out;
 	ret = 0;

-	snapc = rbd_snap_context_create(snap_count);
+	snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);
 	if (!snapc) {
 		ret = -ENOMEM;
 		goto out;
@@ -4590,7 +4561,7 @@ static void rbd_dev_unprobe(struct rbd_device
*rbd_dev)
 	/* Free dynamic fields from the header, then zero it out */

 	header = &rbd_dev->header;
-	rbd_snap_context_put(header->snapc);
+	ceph_put_snap_context(header->snapc);
 	kfree(header->snap_sizes);
 	kfree(header->snap_names);
 	kfree(header->object_prefix);
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index cbb2f54..f01645a 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -332,10 +332,9 @@ static int build_snap_context(struct
ceph_snap_realm *realm)
 	err = -ENOMEM;
 	if (num > (SIZE_MAX - sizeof(*snapc)) / sizeof(u64))
 		goto fail;
-	snapc = kzalloc(sizeof(*snapc) + num*sizeof(u64), GFP_NOFS);
+	snapc = ceph_create_snap_context(num, GFP_NOFS);
 	if (!snapc)
 		goto fail;
-	atomic_set(&snapc->nref, 1);

 	/* build (reverse sorted) snap vector */
 	num = 0;
-- 
1.7.9.5

