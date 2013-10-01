From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 2/2] rbd: only set disk to read-only once
Date: Mon, 30 Sep 2013 22:15:59 -0700
Message-ID: <1380604559-5331-3-git-send-email-josh.durgin@inktank.com>
References: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55869 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab3JAF7p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Oct 2013 01:59:45 -0400
In-Reply-To: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@inktank.com>

rbd_open(), called every time the device is opened, calls
set_device_ro().  There's no reason to set the device read-only or
read-write every time it is opened. Just do this once during device
setup, using set_disk_ro() instead because the struct block_device
isn't available to us there.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b3b1b57..fc3ebd9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -490,7 +490,6 @@ static int rbd_open(struct block_device *bdev, fmode_t mode)
 		return -ENOENT;
 
 	(void) get_device(&rbd_dev->dev);
-	set_device_ro(bdev, rbd_dev->mapping.read_only);
 
 	return 0;
 }
@@ -4949,6 +4948,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	if (ret)
 		goto err_out_disk;
 	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
+	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
 
 	ret = rbd_bus_add_dev(rbd_dev);
 	if (ret)
-- 
1.7.2.5

