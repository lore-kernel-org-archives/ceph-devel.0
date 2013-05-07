From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/7] rbd: get rid of trivial v1 header wrappers
Date: Mon, 06 May 2013 20:53:48 -0500
Message-ID: <51885EAC.4010006@inktank.com>
References: <51885E06.8020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:48512 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759121Ab3EGBxu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:53:50 -0400
Received: by mail-qc0-f172.google.com with SMTP id z1so29529qcx.31
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:53:49 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id bc5sm41649923qeb.3.2013.05.06.18.53.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:53:49 -0700 (PDT)
In-Reply-To: <51885E06.8020201@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Get rid of the trivial wrapper functions rbd_dev_v1_refresh() and
rbd_dev_v1_probe(), substituting rbd_dev_v1_header_read() calls
in their place.

Rename rbd_dev_v1_header_read() to be rbd_dev_v1_header_info(), to
be more generic (it will better reflect what happens with format 2
images).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ed18888..9e667c5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -788,7 +788,7 @@ static int rbd_header_from_disk(struct rbd_device
*rbd_dev,
 		 * Copy the names, and fill in each snapshot's id
 		 * and size.
 		 *
-		 * Note that rbd_dev_v1_header_read() guarantees the
+		 * Note that rbd_dev_v1_header_info() guarantees the
 		 * ondisk buffer we're working with has
 		 * snap_names_len bytes beyond the end of the
 		 * snapshot id array, this memcpy() is safe.
@@ -3050,7 +3050,7 @@ out:
  * return, the rbd_dev->header field will contain up-to-date
  * information about the image.
  */
-static int rbd_dev_v1_header_read(struct rbd_device *rbd_dev)
+static int rbd_dev_v1_header_info(struct rbd_device *rbd_dev)
 {
 	struct rbd_image_header_ondisk *ondisk = NULL;
 	u32 snap_count = 0;
@@ -3106,14 +3106,6 @@ out:
 }

 /*
- * only read the first part of the ondisk header, without the snaps info
- */
-static int rbd_dev_v1_refresh(struct rbd_device *rbd_dev)
-{
-	return rbd_dev_v1_header_read(rbd_dev);
-}
-
-/*
  * Clear the rbd device's EXISTS flag if the snapshot it's mapped to
  * has disappeared from the (just updated) snapshot context.
  */
@@ -3141,7 +3133,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	mapping_size = rbd_dev->mapping.size;
 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 	if (rbd_dev->image_format == 1)
-		ret = rbd_dev_v1_refresh(rbd_dev);
+		ret = rbd_dev_v1_header_info(rbd_dev);
 	else
 		ret = rbd_dev_v2_refresh(rbd_dev);

@@ -4467,11 +4459,6 @@ static void rbd_dev_unprobe(struct rbd_device
*rbd_dev)
 	memset(header, 0, sizeof (*header));
 }

-static int rbd_dev_v1_probe(struct rbd_device *rbd_dev)
-{
-	return rbd_dev_v1_header_read(rbd_dev);
-}
-
 static int rbd_dev_v2_probe(struct rbd_device *rbd_dev)
 {
 	int ret;
@@ -4714,7 +4701,7 @@ static int rbd_dev_image_probe(struct rbd_device
*rbd_dev, bool read_only)
 		goto out_header_name;

 	if (rbd_dev->image_format == 1)
-		ret = rbd_dev_v1_probe(rbd_dev);
+		ret = rbd_dev_v1_header_info(rbd_dev);
 	else
 		ret = rbd_dev_v2_probe(rbd_dev);
 	if (ret)
-- 
1.7.9.5

