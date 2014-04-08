From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 08/11] rbd: make discard trigger copy-on-write
Date: Tue,  8 Apr 2014 13:42:52 -0700
Message-ID: <64163d8bfafd6d576218cffe5687e23043b4f675.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56378 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757152AbaDHWCZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:25 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DE8E3267DC
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id D86BA267D8
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Discard requests are a form of write, so they should go through the
same process as plain write requests and trigger copy-on-write for
layered images.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4f6f48a..78433df 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2755,7 +2755,8 @@ static bool rbd_img_obj_request_simple(struct rbd_obj_request *obj_request)
 	obj_size = (u64) 1 << rbd_dev->header.obj_order;
 
 	/* Read requests didn't need special handling */
-	if (!img_request_write_test(img_request))
+	if (!img_request_write_test(img_request) &&
+		!img_request_discard_test(img_request))
 		return true;
 	/* No-layered writes are simple requests*/
 	if (!img_request_layered_test(img_request))
-- 
1.7.10.4

