From: Luis Henriques <luis.henriques@canonical.com>
Subject: [3.16.y-ckt stable] Patch "rbd: Fix error recovery in rbd_obj_read_sync()" has been added to staging queue
Date: Mon, 17 Nov 2014 11:14:50 +0000
Message-ID: <1416222890-20485-1-git-send-email-luis.henriques@canonical.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36494 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbaKQLOx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 06:14:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@redhat.com>, Luis Henriques <luis.henriques@canonical.com>, kernel-team@lists.ubuntu.com

This is a note to let you know that I have just added a patch titled

    rbd: Fix error recovery in rbd_obj_read_sync()

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.16.y-queue

This patch is scheduled to be released in version 3.16.7-ckt2.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

From c71e0efe1eeb425d5c5c21f491455522737b3e2c Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 22 Oct 2014 09:17:24 +0200
Subject: rbd: Fix error recovery in rbd_obj_read_sync()

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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9dc02c429771..a15500662f4c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3389,7 +3389,7 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	page_count = (u32) calc_pages_for(offset, length);
 	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
 	if (IS_ERR(pages))
-		ret = PTR_ERR(pages);
+		return PTR_ERR(pages);

 	ret = -ENOMEM;
 	obj_request = rbd_obj_request_create(object_name, offset, length,
--
2.1.0

