From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH] rbd: fix buffer size for writes to images with snapshots
Date: Tue, 27 Aug 2013 15:06:55 -0700
Message-ID: <1377641215-29459-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:47510 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab3H0WTo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 18:19:44 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id E6D5A26403
	for <ceph-devel@vger.kernel.org>; Tue, 27 Aug 2013 15:23:29 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id D8AF9263F5
	for <ceph-devel@vger.kernel.org>; Tue, 27 Aug 2013 15:23:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_osd_req_create() needs to know the snapshot context size to create
a buffer large enough to send it with the message front. It gets this
from the img_request, which was not set for the obj_request yet. This
resulted in trying to write past the end of the front payload, hitting
this BUG:

libceph: BUG_ON(p > msg->front.iov_base + msg->front.iov_len);

Fix this by associating the obj_request with its img_request
immediately after it's created, before the osd request is created.

Fixes: http://tracker.ceph.com/issues/5760
Suggested-by: Alex Elder <alex.elder@linaro.org>
Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f8fd7d3..80f787b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2203,6 +2203,11 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 		rbd_segment_name_free(object_name);
 		if (!obj_request)
 			goto out_unwind;
+		/*
+		 * set obj_request->img_request before creating the
+		 * osd_request so that it gets the right snapc
+		 */
+		rbd_img_obj_request_add(img_request, obj_request);
 
 		if (type == OBJ_REQUEST_BIO) {
 			unsigned int clone_size;
@@ -2244,11 +2249,6 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 					obj_request->pages, length,
 					offset & ~PAGE_MASK, false, false);
 
-		/*
-		 * set obj_request->img_request before formatting
-		 * the osd_request so that it gets the right snapc
-		 */
-		rbd_img_obj_request_add(img_request, obj_request);
 		if (write_request)
 			rbd_osd_req_format_write(obj_request);
 		else
-- 
1.7.2.5

