From: Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] rbd: Fix error recovery in rbd_obj_read_sync()
Date: Fri, 14 Nov 2014 13:26:37 +0100
Message-ID: <1415968006-9521-97-git-send-email-jslaby@suse.cz>
References: <1415968006-9521-1-git-send-email-jslaby@suse.cz>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59467 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965372AbaKNM1d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Nov 2014 07:27:33 -0500
In-Reply-To: <1415968006-9521-1-git-send-email-jslaby@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@redhat.com>, Jiri Slaby <jslaby@suse.cz>

From: Jan Kara <jack@suse.cz>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit a8d4205623ae965e36c68629db306ca0695a2771 upstream.

When we fail to allocate page vector in rbd_obj_read_sync() we just
basically ignore the problem and continue which will result in an oops
later. Fix the problem by returning proper error.

CC: Yehuda Sadeh <yehuda@inktank.com>
CC: Sage Weil <sage@inktank.com>
CC: ceph-devel@vger.kernel.org
Coverity-id: 1226882
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index aeeb62e0981a..a86841886acc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3220,7 +3220,7 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	page_count = (u32) calc_pages_for(offset, length);
 	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
 	if (IS_ERR(pages))
-		ret = PTR_ERR(pages);
+		return PTR_ERR(pages);
 
 	ret = -ENOMEM;
 	obj_request = rbd_obj_request_create(object_name, offset, length,
-- 
2.1.3

