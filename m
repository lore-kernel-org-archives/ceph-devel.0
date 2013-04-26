From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: avoid dropping extra reference in rbd_free_disk()
Date: Fri, 26 Apr 2013 09:50:52 -0500
Message-ID: <517A944C.1090503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58904 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab3DZOu4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 10:50:56 -0400
Received: by mail-ia0-f174.google.com with SMTP id h23so3692122iae.5
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 07:50:55 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id dy5sm3562344igc.1.2013.04.26.07.50.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 07:50:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I found during some failure injection testing that the call to
rbd_free_disk() in the error path of rbd_dev_probe_finish() was
dropping an extra reference to the disk queue.  The problem
occurred when put_disk tried to drop a reference to the disk's
queue.  A call to blk_cleanup_queue() just prior to that will have
also dropped a reference to the queue.

The problem is that the reference dropped by put_disk() is assumed
to have been taken by add_disk().  Our code has error paths that can
occur after the disk and its queue are initialized, but before the
call to add_disk(), and in those paths we won't have that extra
reference.

The fix is easy though.  In rbd_free_disk() we're already checking
the disk's GENHD_FL_UP flag.  That flag is an indication that
add_disk() has been called, so just call blk_cleanup_queue()
conditional on that flag being set.

This resolves:
    http://tracker.ceph.com/issues/4800

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index dcd8e58..9e38967 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2844,10 +2844,12 @@ static void rbd_free_disk(struct rbd_device
*rbd_dev)
 	if (!disk)
 		return;

-	if (disk->flags & GENHD_FL_UP)
+	rbd_dev->disk = NULL;
+	if (disk->flags & GENHD_FL_UP) {
 		del_gendisk(disk);
-	if (disk->queue)
-		blk_cleanup_queue(disk->queue);
+		if (disk->queue)
+			blk_cleanup_queue(disk->queue);
+	}
 	put_disk(disk);
 }

-- 
1.7.9.5

