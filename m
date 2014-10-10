From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/3] rbd: rbd workqueues need a resque worker
Date: Fri, 10 Oct 2014 22:27:05 +0400
Message-ID: <1412965626-11165-3-git-send-email-idryomov@redhat.com>
References: <1412965626-11165-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:38118 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbaJJS1W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 14:27:22 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so3672339lab.41
        for <ceph-devel@vger.kernel.org>; Fri, 10 Oct 2014 11:27:20 -0700 (PDT)
In-Reply-To: <1412965626-11165-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Micha Krause <micha@krausam.de>

Need to use WQ_MEM_RECLAIM for our workqueues to prevent I/O lockups
under memory pressure - we sit on the memory reclaim path.

Cc: stable@vger.kernel.org # 3.17, needs backporting for 3.16
Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
Tested-by: Micha Krause <micha@krausam.de>
---
 drivers/block/rbd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7712ae65753c..0a54c588e433 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5242,7 +5242,8 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
 	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
 
-	rbd_dev->rq_wq = alloc_workqueue("%s", 0, 0, rbd_dev->disk->disk_name);
+	rbd_dev->rq_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
+					 rbd_dev->disk->disk_name);
 	if (!rbd_dev->rq_wq) {
 		ret = -ENOMEM;
 		goto err_out_mapping;
-- 
1.7.10.4

