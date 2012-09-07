From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] rbd: kill rbd_dev->q
Date: Fri, 07 Sep 2012 08:39:43 -0500
Message-ID: <5049F91F.3090306@inktank.com>
References: <5049F7F5.1070609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60946 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760641Ab2IGNjp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 09:39:45 -0400
Received: by mail-ie0-f174.google.com with SMTP id e11so5001652iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 06:39:45 -0700 (PDT)
In-Reply-To: <5049F7F5.1070609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A copy of rbd_dev->disk->queue is held in rbd_dev->q, but it's
never actually used.  So get just get rid of the field.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7726368..774a36b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -155,7 +155,6 @@ struct rbd_device {

 	int			major;		/* blkdev assigned major */
 	struct gendisk		*disk;		/* blkdev's gendisk and rq */
-	struct request_queue	*q;

 	struct rbd_options	rbd_opts;
 	struct rbd_client	*rbd_client;
@@ -1923,7 +1922,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	q->queuedata = rbd_dev;

 	rbd_dev->disk = disk;
-	rbd_dev->q = q;

 	/* finally, announce the disk to the world */
 	set_capacity(disk, total_size / SECTOR_SIZE);
-- 
1.7.9.5

