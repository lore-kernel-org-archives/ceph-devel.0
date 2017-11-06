From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/2] rbd: get rid of rbd_mapping::read_only
Date: Mon,  6 Nov 2017 16:49:30 +0100
Message-ID: <1509983370-1853-2-git-send-email-idryomov@gmail.com>
References: <1509983370-1853-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:47284 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbdKFPtz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Nov 2017 10:49:55 -0500
Received: by mail-wm0-f68.google.com with SMTP id r196so14741801wmf.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Nov 2017 07:49:54 -0800 (PST)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t66sm3349198wme.33.2017.11.06.07.49.52
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2017 07:49:53 -0800 (PST)
In-Reply-To: <1509983370-1853-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It is redundant -- rw/ro state is stored in hd_struct and managed by
the block layer.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 832b235b2dc3..8a39c399e4ae 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -348,7 +348,6 @@ struct rbd_client_id {
 struct rbd_mapping {
 	u64                     size;
 	u64                     features;
-	bool			read_only;
 };
 
 /*
@@ -608,9 +607,6 @@ static int rbd_open(struct block_device *bdev, fmode_t mode)
 	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
 	bool removing = false;
 
-	if ((mode & FMODE_WRITE) && rbd_dev->mapping.read_only)
-		return -EROFS;
-
 	spin_lock_irq(&rbd_dev->lock);
 	if (test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags))
 		removing = true;
@@ -4028,15 +4024,8 @@ static void rbd_queue_workfn(struct work_struct *work)
 		goto err_rq;
 	}
 
-	/* Only reads are allowed to a read-only device */
-
-	if (op_type != OBJ_OP_READ) {
-		if (rbd_dev->mapping.read_only) {
-			result = -EROFS;
-			goto err_rq;
-		}
-		rbd_assert(rbd_dev->spec->snap_id == CEPH_NOSNAP);
-	}
+	rbd_assert(op_type == OBJ_OP_READ ||
+		   rbd_dev->spec->snap_id == CEPH_NOSNAP);
 
 	/*
 	 * Quit early if the mapped snapshot no longer exists.  It's
@@ -5972,7 +5961,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 		goto err_out_disk;
 
 	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
-	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
+	set_disk_ro(rbd_dev->disk, rbd_dev->opts->read_only);
 
 	ret = dev_set_name(&rbd_dev->dev, "%d", rbd_dev->dev_id);
 	if (ret)
@@ -6123,7 +6112,6 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	struct rbd_options *rbd_opts = NULL;
 	struct rbd_spec *spec = NULL;
 	struct rbd_client *rbdc;
-	bool read_only;
 	int rc;
 
 	if (!try_module_get(THIS_MODULE))
@@ -6172,11 +6160,8 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	}
 
 	/* If we are mapping a snapshot it must be marked read-only */
-
-	read_only = rbd_dev->opts->read_only;
 	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
-		read_only = true;
-	rbd_dev->mapping.read_only = read_only;
+		rbd_dev->opts->read_only = true;
 
 	rc = rbd_dev_device_setup(rbd_dev);
 	if (rc)
-- 
2.4.3

