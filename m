From: Jan Kara <jack@suse.cz>
Subject: [PATCH] rbd: Fix error recovery in rbd_obj_read_sync()
Date: Wed, 22 Oct 2014 09:17:24 +0200
Message-ID: <1413962244-25630-1-git-send-email-jack@suse.cz>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32978 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaJVHRe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Oct 2014 03:17:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Jan Kara <jack@suse.cz>, Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org, stable@vger.kernel.org

When we fail to allocate page vector in rbd_obj_read_sync() we just
basically ignore the problem and continue which will result in an oops
later. Fix the problem by returning proper error.

CC: Yehuda Sadeh <yehuda@inktank.com>
CC: Sage Weil <sage@inktank.com>
CC: ceph-devel@vger.kernel.org
CC: stable@vger.kernel.org
Coverity-id: 1226882
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0a54c588e433..8f714c3ed25f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3532,7 +3532,7 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	page_count = (u32) calc_pages_for(offset, length);
 	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
 	if (IS_ERR(pages))
-		ret = PTR_ERR(pages);
+		return PTR_ERR(pages);
 
 	ret = -ENOMEM;
 	obj_request = rbd_obj_request_create(object_name, offset, length,
-- 
1.8.1.4

