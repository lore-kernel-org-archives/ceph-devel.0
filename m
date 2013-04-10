From: Laurent Barbe <laurent@ksperis.com>
Subject: [PATCH] rbd: revalidate_disk upon rbd resize
Date: Wed, 10 Apr 2013 18:06:29 +0200
Message-ID: <1365609989-14493-1-git-send-email-laurent@ksperis.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34664 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936992Ab3DJQGk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Apr 2013 12:06:40 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so646450wiw.13
        for <ceph-devel@vger.kernel.org>; Wed, 10 Apr 2013 09:06:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Laurent Barbe <laurent@ksperis.com>

If rbd disk is open and rbd resize is done, new size is not visible by
filesystem.
Like is done in virtio-blk and dm driver, revalidate_disk() permits to
update the bd_inode size.

Signed-off-by: Laurent Barbe <laurent@ksperis.com>
---
 drivers/block/rbd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f556f8a..1963025 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2293,6 +2293,7 @@ static void rbd_update_mapping_size(struct rbd_device *rbd_dev)
 	dout("setting size to %llu sectors", (unsigned long long) size);
 	rbd_dev->mapping.size = (u64) size;
 	set_capacity(rbd_dev->disk, size);
+	revalidate_disk(rbd_dev->disk);
 }
 
 /*
-- 
1.7.10.4

