From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH] rbd: send snapshot context with writes
Date: Wed, 26 Jun 2013 13:06:39 -0700
Message-ID: <1372277199-9774-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38808 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab3FZU02 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jun 2013 16:26:28 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 72FF9260DE
	for <ceph-devel@vger.kernel.org>; Wed, 26 Jun 2013 13:37:28 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 65767260D4
	for <ceph-devel@vger.kernel.org>; Wed, 26 Jun 2013 13:37:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sending the right snapshot context with each write is required for
snapshots to work. Due to the ordering of calls, the snapshot context
is never set for any requests. This causes writes to the current
version of the image to be reflected in all snapshots, which are
supposed to be read-only.

This happens because rbd_osd_req_format_write() sets the snapshot
context based on obj_request->img_request. At this point, however,
obj_request->img_request has not been set yet, to the snapshot context
is set to NULL. Fix this by moving rbd_img_obj_request_add(), which
sets obj_request->img_request, before the osd request formatting
calls.

This resolves:
    http://tracker.ceph.com/issues/5465

Reported-by: Karol Jurak <karol.jurak@gmail.com>
Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d79831a..4b03d02 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2266,13 +2266,15 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 					obj_request->pages, length,
 					offset & ~PAGE_MASK, false, false);
 
+		// writes get the snapc from the img_request, so
+		// set it before formatting the osd_req
+		rbd_img_obj_request_add(img_request, obj_request);
 		if (write_request)
 			rbd_osd_req_format_write(obj_request);
 		else
 			rbd_osd_req_format_read(obj_request);
 
 		obj_request->img_offset = img_offset;
-		rbd_img_obj_request_add(img_request, obj_request);
 
 		img_offset += length;
 		resid -= length;
-- 
1.7.2.5

