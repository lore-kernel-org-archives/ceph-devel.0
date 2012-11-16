From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: get rid of rbd_{get,put}_dev()
Date: Fri, 16 Nov 2012 09:43:32 -0600
Message-ID: <50A65F24.7000002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35445 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab2KPPnf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 10:43:35 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so3763320iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 07:43:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The functions rbd_get_dev() and rbd_put_dev() are trivial wrappers
that add no values, and their existence suggests they may do more
than what they do.

Get rid of them.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9d9a2f3..f4b5a64 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -337,16 +337,6 @@ void rbd_warn(struct rbd_device *rbd_dev, const
char *fmt, ...)
 #  define rbd_assert(expr)	((void) 0)
 #endif /* !RBD_DEBUG */

-static struct device *rbd_get_dev(struct rbd_device *rbd_dev)
-{
-	return get_device(&rbd_dev->dev);
-}
-
-static void rbd_put_dev(struct rbd_device *rbd_dev)
-{
-	put_device(&rbd_dev->dev);
-}
-
 static int rbd_dev_refresh(struct rbd_device *rbd_dev, u64 *hver);
 static int rbd_dev_v2_refresh(struct rbd_device *rbd_dev, u64 *hver);

@@ -357,7 +347,7 @@ static int rbd_open(struct block_device *bdev,
fmode_t mode)
 	if ((mode & FMODE_WRITE) && rbd_dev->mapping.read_only)
 		return -EROFS;

-	rbd_get_dev(rbd_dev);
+	(void) get_device(&rbd_dev->dev);
 	set_device_ro(bdev, rbd_dev->mapping.read_only);
 	rbd_dev->open_count++;

@@ -370,7 +360,7 @@ static int rbd_release(struct gendisk *disk, fmode_t
mode)

 	rbd_assert(rbd_dev->open_count > 0);
 	rbd_dev->open_count--;
-	rbd_put_dev(rbd_dev);
+	put_device(&rbd_dev->dev);

 	return 0;
 }
-- 
1.7.9.5

