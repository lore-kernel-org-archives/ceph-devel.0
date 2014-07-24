From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 6/8] rbd: update mapping size only on refresh
Date: Thu, 24 Jul 2014 12:42:47 +0400
Message-ID: <1406191369-6746-7-git-send-email-ilya.dryomov@inktank.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:59506 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934448AbaGXInL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:43:11 -0400
Received: by mail-lb0-f179.google.com with SMTP id v6so2010712lbi.10
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:43:09 -0700 (PDT)
Received: from localhost ([109.110.66.237])
        by mx.google.com with ESMTPSA id qa9sm9604849lbb.35.2014.07.24.01.43.08
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 01:43:09 -0700 (PDT)
In-Reply-To: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is no sense in trying to update the mapping size before it's even
been set.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 5dd6f5057ef4..16f388f2960b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -971,12 +971,6 @@ static int rbd_header_from_disk(struct rbd_device *rbd_dev,
 	header->snap_names = snap_names;
 	header->snap_sizes = snap_sizes;
 
-	/* Make sure mapping size is consistent with header info */
-
-	if (rbd_dev->spec->snap_id == CEPH_NOSNAP || first_time)
-		if (rbd_dev->mapping.size != header->image_size)
-			rbd_dev->mapping.size = header->image_size;
-
 	return 0;
 out_2big:
 	ret = -EIO;
@@ -3520,9 +3514,14 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 
 	ret = rbd_dev_header_info(rbd_dev);
 
-	/* If it's a mapped snapshot, validate its EXISTS flag */
+	if (rbd_dev->spec->snap_id == CEPH_NOSNAP) {
+		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
+			rbd_dev->mapping.size = rbd_dev->header.image_size;
+	} else {
+		/* validate mapped snapshot's EXISTS flag */
+		rbd_exists_validate(rbd_dev);
+	}
 
-	rbd_exists_validate(rbd_dev);
 	up_write(&rbd_dev->header_rwsem);
 
 	if (mapping_size != rbd_dev->mapping.size) {
@@ -4505,10 +4504,6 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 					"is EXPERIMENTAL!");
 	}
 
-	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
-		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
-			rbd_dev->mapping.size = rbd_dev->header.image_size;
-
 	ret = rbd_dev_v2_snap_context(rbd_dev);
 	dout("rbd_dev_v2_snap_context returned %d\n", ret);
 
-- 
1.7.10.4

