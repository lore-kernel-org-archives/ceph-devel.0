From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: detect when clone image is flattened
Date: Sat, 11 May 2013 12:47:07 -0500
Message-ID: <518E841B.4040002@inktank.com>
References: <518E83D3.4050709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:50188 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab3EKRrJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:47:09 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so9685745iec.6
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:47:09 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xc3sm5602490igb.10.2013.05.11.10.47.07
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:47:08 -0700 (PDT)
In-Reply-To: <518E83D3.4050709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A format 2 clone image can be the subject of a "flatten" operation,
during which all of its data gets "copied up" from its parent image,
leaving the image fully populated.  Once this is complete, the
clone's association with the parent is abolished.

Since this can occur when a clone is mapped, we need to detect when
it has occurred and handle it accordingly.  We know an image has
been flattened when we know it at one time had a parent, but we have
learned (via a "get_parent" object class method call) it no longer
has one.

There might be in-flight requests at the point we learn an image has
been flattened, so we can't simply clean up parent data structures
right away.  Instead, we'll drop the initial parent reference when
the parent has disappeared (rather than when the image gets
destroyed), which will allow the last in-flight reference to clean
things up when it's complete.

We leverage the fact that a zero parent overlap renders an image
effectively unlayered.  We set the overlap to 0 at the point we
detect the clone image has flattened, which allows the unlayered
behavior to take effect immediately, while keeping other parent
structures in place until in-flight requests to complete.

This and the next few patches resolve:
    http://tracker.ceph.com/issues/3763

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 71705f3..6cd08ba 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1927,6 +1927,11 @@ static void rbd_dev_parent_put(struct rbd_device
*rbd_dev)
  * If an image has a non-zero parent overlap, get a reference to its
  * parent.
  *
+ * We must get the reference before checking for the overlap to
+ * coordinate properly with zeroing the parent overlap in
+ * rbd_dev_v2_parent_info() when an image gets flattened.  We
+ * drop it again if there is no overlap.
+ *
  * Returns true if the rbd device has a parent with a non-zero
  * overlap and a reference for it was successfully taken, or
  * false otherwise.
@@ -3771,8 +3776,26 @@ static int rbd_dev_v2_parent_info(struct
rbd_device *rbd_dev)
 	end = reply_buf + ret;
 	ret = -ERANGE;
 	ceph_decode_64_safe(&p, end, parent_spec->pool_id, out_err);
-	if (parent_spec->pool_id == CEPH_NOPOOL)
+	if (parent_spec->pool_id == CEPH_NOPOOL) {
+		/*
+		 * Either the parent never existed, or we have
+		 * record of it but the image got flattened so it no
+		 * longer has a parent.  When the parent of a
+		 * layered image disappears we immediately set the
+		 * overlap to 0.  The effect of this is that all new
+		 * requests will be treated as if the image had no
+		 * parent.
+		 */
+		if (rbd_dev->parent_overlap) {
+			rbd_dev->parent_overlap = 0;
+			smp_mb();
+			rbd_dev_parent_put(rbd_dev);
+			pr_info("%s: clone image has been flattened\n",
+				rbd_dev->disk->disk_name);
+		}
+
 		goto out;	/* No parent?  No problem. */
+	}

 	/* The ceph file layout needs to fit pool id in 32 bits */

@@ -4632,7 +4655,10 @@ static void rbd_dev_unprobe(struct rbd_device
*rbd_dev)
 {
 	struct rbd_image_header	*header;

-	rbd_dev_parent_put(rbd_dev);
+	/* Drop parent reference unless it's already been done (or none) */
+
+	if (rbd_dev->parent_overlap)
+		rbd_dev_parent_put(rbd_dev);

 	/* Free dynamic fields from the header, then zero it out */

-- 
1.7.9.5

