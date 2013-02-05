From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: turn off interrupts for open/remove locking
Date: Tue, 05 Feb 2013 14:52:25 -0600
Message-ID: <51117109.6000504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35206 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300Ab3BEUw2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 15:52:28 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so881765ieb.9
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 12:52:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This commit:
    bc7a62ee5 rbd: prevent open for image being removed
added checking for removing rbd before allowing an open, and used
the same request spinlock for protecting that and updating the open
count as is used for the request queue.

However it used the non-irq protected version of the spinlocks.
Fix that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 14a6967..91983a60 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -394,12 +394,12 @@ static int rbd_open(struct block_device *bdev,
fmode_t mode)
 	if ((mode & FMODE_WRITE) && rbd_dev->mapping.read_only)
 		return -EROFS;

-	spin_lock(&rbd_dev->lock);
+	spin_lock_irq(&rbd_dev->lock);
 	if (test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags))
 		removing = true;
 	else
 		rbd_dev->open_count++;
-	spin_unlock(&rbd_dev->lock);
+	spin_unlock_irq(&rbd_dev->lock);
 	if (removing)
 		return -ENOENT;

@@ -416,9 +416,9 @@ static int rbd_release(struct gendisk *disk, fmode_t
mode)
 	struct rbd_device *rbd_dev = disk->private_data;
 	unsigned long open_count_before;

-	spin_lock(&rbd_dev->lock);
+	spin_lock_irq(&rbd_dev->lock);
 	open_count_before = rbd_dev->open_count--;
-	spin_unlock(&rbd_dev->lock);
+	spin_unlock_irq(&rbd_dev->lock);
 	rbd_assert(open_count_before > 0);

 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
@@ -4099,12 +4099,12 @@ static ssize_t rbd_remove(struct bus_type *bus,
 		goto done;
 	}

-	spin_lock(&rbd_dev->lock);
+	spin_lock_irq(&rbd_dev->lock);
 	if (rbd_dev->open_count)
 		ret = -EBUSY;
 	else
 		set_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags);
-	spin_unlock(&rbd_dev->lock);
+	spin_unlock_irq(&rbd_dev->lock);
 	if (ret < 0)
 		goto done;

-- 
1.7.9.5

