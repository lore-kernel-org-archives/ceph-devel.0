From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 1/2] rbd: define helpers for read_only flag
Date: Tue, 28 Feb 2012 20:41:52 -0800
Message-ID: <4F4DAC90.2000005@dreamhost.com>
References: <4F4DAC48.7060804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47076 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab2B2Elx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:41:53 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 4C17424318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:41:53 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 4227924314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:41:53 -0800 (PST)
In-Reply-To: <4F4DAC48.7060804@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In anticipation of replacing the "read_only" field with a "flags"
field, write some trivial wrapper routines for operating on the
read-only state of an rbd_device.

Change the variable name "dev" in rbd_header_set_snap() to be
"rbd_dev" to follow convention.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |   35 ++++++++++++++++++++++++++---------
  1 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 229f974..e7b443a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -187,6 +187,21 @@ struct rbd_device {
  	struct device		dev;
  };

+static inline bool rbd_dev_is_readonly(struct rbd_device *rbd_dev)
+{
+	return rbd_dev->read_only;
+}
+
+static inline void rbd_dev_set_readonly(struct rbd_device *rbd_dev)
+{
+	rbd_dev->read_only = true;
+}
+
+static inline void rbd_dev_clear_readonly(struct rbd_device *rbd_dev)
+{
+	rbd_dev->read_only = false;
+}
+
  static DEFINE_MUTEX(ctl_mutex);	  /* Serialize 
open/close/setup/teardown */

  static LIST_HEAD(rbd_dev_list);    /* devices */
@@ -245,12 +260,14 @@ static int __rbd_update_snaps(struct rbd_device 
*rbd_dev);
  static int rbd_open(struct block_device *bdev, fmode_t mode)
  {
  	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
+	bool read_only;

  	rbd_get_dev(rbd_dev);

-	set_device_ro(bdev, rbd_dev->read_only);
+	read_only = rbd_dev_is_readonly(rbd_dev);
+	set_device_ro(bdev, read_only);

-	if ((mode & FMODE_WRITE) && rbd_dev->read_only)
+	if ((mode & FMODE_WRITE) && read_only)
  		return -EROFS;

  	return 0;
@@ -589,11 +606,11 @@ static int snap_by_name(struct rbd_image_header 
*header, const char *snap_name,
  	return -ENOENT;
  }

-static int rbd_header_set_snap(struct rbd_device *dev,
+static int rbd_header_set_snap(struct rbd_device *rbd_dev,
  			       const char *snap_name,
  			       u64 *size)
  {
-	struct rbd_image_header *header = &dev->header;
+	struct rbd_image_header *header = &rbd_dev->header;
  	struct ceph_snap_context *snapc = header->snapc;
  	int ret = -ENOENT;

@@ -604,8 +621,8 @@ static int rbd_header_set_snap(struct rbd_device *dev,
  			snapc->seq = header->snap_seq;
  		else
  			snapc->seq = 0;
-		dev->cur_snap = 0;
-		dev->read_only = 0;
+		rbd_dev->cur_snap = 0;
+		rbd_dev_clear_readonly(rbd_dev);
  		if (size)
  			*size = header->image_size;
  	} else {
@@ -613,8 +630,8 @@ static int rbd_header_set_snap(struct rbd_device *dev,
  		if (ret < 0)
  			goto done;

-		dev->cur_snap = header->total_snaps - ret;
-		dev->read_only = 1;
+		rbd_dev->cur_snap = header->total_snaps - ret;
+		rbd_dev_set_readonly(rbd_dev);
  	}

  	ret = 0;
@@ -1476,7 +1493,7 @@ static void rbd_rq_fn(struct request_queue *q)
  		size = blk_rq_bytes(rq);
  		ofs = blk_rq_pos(rq) * SECTOR_SIZE;
  		rq_bio = rq->bio;
-		if (do_write && rbd_dev->read_only) {
+		if (do_write && rbd_dev_is_readonly(rbd_dev)) {
  			__blk_end_request_all(rq, -EROFS);
  			continue;
  		}
-- 
1.7.5.4

