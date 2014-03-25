From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] rbd: assert next_completion under completion_lock
Date: Tue, 25 Mar 2014 15:47:48 +0200
Message-ID: <1395755268-11908-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:47438 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbaCYNrv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 09:47:51 -0400
Received: by mail-ee0-f48.google.com with SMTP id b57so465223eek.35
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 06:47:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Olivier Bonvalet <ceph.list@daevel.fr>

completion_lock is there specifically to protect next_completion.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fbf41e058bfd..f044fab3da99 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2123,12 +2123,12 @@ static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
 	rbd_assert(img_request->obj_request_count > 0);
 	rbd_assert(which != BAD_WHICH);
 	rbd_assert(which < img_request->obj_request_count);
-	rbd_assert(which >= img_request->next_completion);
 
 	spin_lock_irq(&img_request->completion_lock);
-	if (which != img_request->next_completion)
+	if (which > img_request->next_completion)
 		goto out;
 
+	rbd_assert(which == img_request->next_completion);
 	for_each_obj_request_from(img_request, obj_request) {
 		rbd_assert(more);
 		rbd_assert(which < img_request->obj_request_count);
-- 
1.7.10.4

