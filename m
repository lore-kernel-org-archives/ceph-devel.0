From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 7/8] rbd: do not read in parent info before snap context
Date: Thu, 24 Jul 2014 12:42:48 +0400
Message-ID: <1406191369-6746-8-git-send-email-ilya.dryomov@inktank.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:64098 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934456AbaGXInO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:43:14 -0400
Received: by mail-lb0-f172.google.com with SMTP id z11so2021086lbi.31
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:43:12 -0700 (PDT)
Received: from localhost ([109.110.66.237])
        by mx.google.com with ESMTPSA id a2sm3877747lak.28.2014.07.24.01.43.11
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 01:43:12 -0700 (PDT)
In-Reply-To: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently rbd_dev_v2_header_info() reads in parent info before the snap
context is read in.  This is wrong, because we may need to look at the
the parent_overlap value of the snapshot instead of that of the base
image, for example when mapping a snapshot - see next commit.  (When
mapping a snapshot, all we got is its name and we need the snap context
to translate that name into an id to know which parent info to look
for).

The approach taken here is to make sure rbd_dev_v2_parent_info() is
called after the snap context has been read in.  The other approach
would be to add a parent_overlap field to struct rbd_mapping and
maintain it the same way rbd_mapping::size is maintained.  The reason
I chose the first approach is that the value of keeping around both
base image values and the actual mapping values is unclear to me.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   64 ++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 16f388f2960b..c4606987e9d1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -515,6 +515,7 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev);
 static int rbd_dev_refresh(struct rbd_device *rbd_dev);
 static int rbd_dev_v2_header_onetime(struct rbd_device *rbd_dev);
 static int rbd_dev_header_info(struct rbd_device *rbd_dev);
+static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev);
 static const char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev,
 					u64 snap_id);
 static int _rbd_dev_v2_snap_size(struct rbd_device *rbd_dev, u64 snap_id,
@@ -3513,6 +3514,18 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	mapping_size = rbd_dev->mapping.size;
 
 	ret = rbd_dev_header_info(rbd_dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * If there is a parent, see if it has disappeared due to the
+	 * mapped image getting flattened.
+	 */
+	if (rbd_dev->parent) {
+		ret = rbd_dev_v2_parent_info(rbd_dev);
+		if (ret)
+			return ret;
+	}
 
 	if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
 		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
@@ -3524,11 +3537,10 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 
 	up_write(&rbd_dev->header_rwsem);
 
-	if (mapping_size != rbd_dev->mapping.size) {
+	if (mapping_size != rbd_dev->mapping.size)
 		rbd_dev_update_size(rbd_dev);
-	}
 
-	return ret;
+	return 0;
 }
 
 static int rbd_init_disk(struct rbd_device *rbd_dev)
@@ -4477,33 +4489,6 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 			return ret;
 	}
 
-	/*
-	 * If the image supports layering, get the parent info.  We
-	 * need to probe the first time regardless.  Thereafter we
-	 * only need to if there's a parent, to see if it has
-	 * disappeared due to the mapped image getting flattened.
-	 */
-	if (rbd_dev->header.features & RBD_FEATURE_LAYERING &&
-			(first_time || rbd_dev->parent_spec)) {
-		bool warn;
-
-		ret = rbd_dev_v2_parent_info(rbd_dev);
-		if (ret)
-			return ret;
-
-		/*
-		 * Print a warning if this is the initial probe and
-		 * the image has a parent.  Don't print it if the
-		 * image now being probed is itself a parent.  We
-		 * can tell at this point because we won't know its
-		 * pool name yet (just its pool id).
-		 */
-		warn = rbd_dev->parent_spec && rbd_dev->spec->pool_name;
-		if (first_time && warn)
-			rbd_warn(rbd_dev, "WARNING: kernel layering "
-					"is EXPERIMENTAL!");
-	}
-
 	ret = rbd_dev_v2_snap_context(rbd_dev);
 	dout("rbd_dev_v2_snap_context returned %d\n", ret);
 
@@ -5183,14 +5168,28 @@ static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
 	if (ret)
 		goto err_out_probe;
 
+	if (rbd_dev->header.features & RBD_FEATURE_LAYERING) {
+		ret = rbd_dev_v2_parent_info(rbd_dev);
+		if (ret)
+			goto err_out_probe;
+
+		/*
+		 * Need to warn users if this image is the one being
+		 * mapped and has a parent.
+		 */
+		if (mapping && rbd_dev->parent_spec)
+			rbd_warn(rbd_dev,
+				 "WARNING: kernel layering is EXPERIMENTAL!");
+	}
+
 	ret = rbd_dev_probe_parent(rbd_dev);
 	if (ret)
 		goto err_out_probe;
 
 	dout("discovered format %u image, header name is %s\n",
 		rbd_dev->image_format, rbd_dev->header_name);
-
 	return 0;
+
 err_out_probe:
 	rbd_dev_unprobe(rbd_dev);
 err_out_watch:
@@ -5203,9 +5202,6 @@ err_out_format:
 	rbd_dev->image_format = 0;
 	kfree(rbd_dev->spec->image_id);
 	rbd_dev->spec->image_id = NULL;
-
-	dout("probe failed, returning %d\n", ret);
-
 	return ret;
 }
 
-- 
1.7.10.4

