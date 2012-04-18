From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/6] rbd: store snapshot id instead of index
Date: Wed, 18 Apr 2012 09:41:02 -0500
Message-ID: <4F8ED27E.8020901@dreamhost.com>
References: <4F8ED154.6050500@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39328 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab2DROlD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:41:03 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 9AFC52449D
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:05 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 6EF112444A
	for <ceph-devel@vger.kernel.org>; Wed, 18 Apr 2012 07:44:05 -0700 (PDT)
In-Reply-To: <4F8ED154.6050500@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a device was open at a snapshot, and snapshots were deleted or
added, data from the wrong snapshot could be read. Instead of
assuming the snap context is constant, store the actual snap id when
the device is initialized, and rely on the OSDs to signal an error
if we try reading from a snapshot that was deleted.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
Reviewed-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   27 +++++----------------------
  1 file changed, 5 insertions(+), 22 deletions(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -175,8 +175,7 @@
  	/* protects updating the header */
  	struct rw_semaphore     header_rwsem;
  	char                    snap_name[RBD_MAX_SNAP_NAME_LEN];
-	u32 cur_snap;	/* index+1 of current snapshot within snap context
-			   0 - for the head */
+	u64                     snap_id;	/* current snapshot id */
  	int read_only;

  	struct list_head	node;
@@ -554,21 +553,6 @@
  	return -ENOMEM;
  }

-static int snap_index(struct rbd_image_header *header, int snap_num)
-{
-	return header->total_snaps - snap_num;
-}
-
-static u64 cur_snap_id(struct rbd_device *rbd_dev)
-{
-	struct rbd_image_header *header = &rbd_dev->header;
-
-	if (!rbd_dev->cur_snap)
-		return 0;
-
-	return header->snapc->snaps[snap_index(header, rbd_dev->cur_snap)];
-}
-
  static int snap_by_name(struct rbd_image_header *header, const char 
*snap_name,
  			u64 *seq, u64 *size)
  {
@@ -607,7 +591,7 @@
  			snapc->seq = header->snap_seq;
  		else
  			snapc->seq = 0;
-		dev->cur_snap = 0;
+		dev->snap_id = CEPH_NOSNAP;
  		dev->read_only = 0;
  		if (size)
  			*size = header->image_size;
@@ -615,8 +599,7 @@
  		ret = snap_by_name(header, dev->snap_name, &snapc->seq, size);
  		if (ret < 0)
  			goto done;
-
-		dev->cur_snap = header->total_snaps - ret;
+		dev->snap_id = snapc->seq;
  		dev->read_only = 1;
  	}

@@ -1523,7 +1506,7 @@
  					      coll, cur_seg);
  			else
  				rbd_req_read(rq, rbd_dev,
-					     cur_snap_id(rbd_dev),
+					     rbd_dev->snap_id,
  					     ofs,
  					     op_size, bio,
  					     coll, cur_seg);
@@ -1658,7 +1641,7 @@
  	struct ceph_mon_client *monc;

  	/* we should create a snapshot only if we're pointing at the head */
-	if (dev->cur_snap)
+	if (dev->snap_id != CEPH_NOSNAP)
  		return -EINVAL;

  	monc = &dev->rbd_client->client->monc;
