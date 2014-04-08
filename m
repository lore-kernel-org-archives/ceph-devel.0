From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 06/11] rbd: fix snapshot context reference count for discards
Date: Tue,  8 Apr 2014 13:42:50 -0700
Message-ID: <159f94a567fb1f39373c7038cc29ef58f2c4ef2a.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56379 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757157AbaDHWCZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:25 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id CC24C267B7
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id BC617267DA
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Discards take a reference to the snapshot context of an image when
they are created.  This reference needs to be cleaned up when the
request is done just as it is for regular writes.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 486e4b5..234ffbb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2074,7 +2074,8 @@ static void rbd_img_request_destroy(struct kref *kref)
 		rbd_dev_parent_put(img_request->rbd_dev);
 	}
 
-	if (img_request_write_test(img_request))
+	if (img_request_write_test(img_request) ||
+		img_request_discard_test(img_request))
 		ceph_put_snap_context(img_request->snapc);
 
 	kmem_cache_free(rbd_img_request_cache, img_request);
-- 
1.7.10.4

