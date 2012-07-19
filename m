From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: don't use snapc->seq that way
Date: Thu, 19 Jul 2012 12:11:33 -0500
Message-ID: <50083FC5.3050902@inktank.com>
References: <50083F65.5030104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:58965 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab2GSRLf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 13:11:35 -0400
Received: by ghrr11 with SMTP id r11so3011822ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 10:11:35 -0700 (PDT)
In-Reply-To: <50083F65.5030104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In what appears to be an artifact of a different way of encoding
whether an rbd image maps a snapshot, __rbd_refresh_header() has
code that arranges to update the seq value in an rbd image's
snapshot context to point to the first entry in its snapshot
array if that's where it was pointing initially.

We now use rbd_dev->snap_id to record the snapshot id--using
the special value SNAP_NONE to indicate the rbd_dev is not mapping
a snapshot at all.

There is therefore no need to check for this case, nor to update the
seq value, in __rbd_refresh_header().  Just preserve the seq value
that rbd_read_header() provides (which, at the moment, is nothing).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4d3a1e0..8a46599 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1718,8 +1718,6 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev)
 {
 	int ret;
 	struct rbd_image_header h;
-	u64 snap_seq;
-	int follow_seq = 0;

 	ret = rbd_read_header(rbd_dev, &h);
 	if (ret < 0)
@@ -1735,13 +1733,6 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev)
 		set_capacity(rbd_dev->disk, size);
 	}

-	snap_seq = rbd_dev->header.snapc->seq;
-	if (rbd_dev->header.total_snaps &&
-	    rbd_dev->header.snapc->snaps[0] == snap_seq)
-		/* pointing at the head, will need to follow that
-		   if head moves */
-		follow_seq = 1;
-
 	/* rbd_dev->header.object_prefix shouldn't change */
 	kfree(rbd_dev->header.snap_sizes);
 	kfree(rbd_dev->header.snap_names);
@@ -1759,11 +1750,6 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev)
 	WARN_ON(strcmp(rbd_dev->header.object_prefix, h.object_prefix));
 	kfree(h.object_prefix);

-	if (follow_seq)
-		rbd_dev->header.snapc->seq = rbd_dev->header.snapc->snaps[0];
-	else
-		rbd_dev->header.snapc->seq = snap_seq;
-
 	ret = __rbd_init_snaps_header(rbd_dev);

 	up_write(&rbd_dev->header_rwsem);
-- 
1.7.5.4

