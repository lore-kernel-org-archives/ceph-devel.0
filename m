From: Laurent Barbe <laurent@ksperis.com>
Subject: [PATCH] rbd: revalidate_disk upon rbd resize
Date: Fri, 12 Apr 2013 15:52:46 +0200
Message-ID: <1365774766-29899-1-git-send-email-laurent@ksperis.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:58071 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117Ab3DLNxI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Apr 2013 09:53:08 -0400
Received: by mail-wg0-f43.google.com with SMTP id f12so2628920wgh.34
        for <ceph-devel@vger.kernel.org>; Fri, 12 Apr 2013 06:53:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: ceph-devel@vger.kernel.org, Laurent Barbe <laurent@ksperis.com>

If rbd disk is open and rbd resize is done, new size is not visible by
filesystem.
Like is done in virtio-blk and dm driver, revalidate_disk() permits to
update the bd_inode size.

Signed-off-by: Laurent Barbe <laurent@ksperis.com>
---
 drivers/block/rbd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4daa400..5f88de9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1883,6 +1883,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev, u64 *hver)
 	else
 		ret = rbd_dev_v2_refresh(rbd_dev, hver);
 	mutex_unlock(&ctl_mutex);
+	revalidate_disk(rbd_dev->disk);
 
 	return ret;
 }
-- 
1.7.10.4

