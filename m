From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 07/11] rbd: tolerate -ENOENT for discard operations
Date: Tue,  8 Apr 2014 13:42:51 -0700
Message-ID: <4133c45e4dc91d3b1668522dcd88e1d7e5ce41e4.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56381 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287AbaDHWC0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:26 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D830C267BC
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id C5259267C6
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Discard may try to delete an object from a non-layered image that does not exist.
If this occurs, the image already has no data in that range, so change the
result to success.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 234ffbb..4f6f48a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1671,6 +1671,9 @@ static void rbd_osd_discard_callback(struct rbd_obj_request *obj_request)
 	 * it to our originally-requested length.
 	 */
 	obj_request->xferred = obj_request->length;
+	/* discarding a non-existent object is not a problem */
+	if (obj_request->result == -ENOENT)
+		obj_request->result = 0;
 	obj_request_done_set(obj_request);
 }
 
-- 
1.7.10.4

