From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: end I/O the entire obj_request on error
Date: Sun, 26 Apr 2015 17:10:45 +0300
Message-ID: <1430057445-42944-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33971 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbbDZOLL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Apr 2015 10:11:11 -0400
Received: by lbcga7 with SMTP id ga7so65563164lbc.1
        for <ceph-devel@vger.kernel.org>; Sun, 26 Apr 2015 07:11:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

When we end I/O struct request with error, we need to pass
obj_request->length as @nr_bytes so that the entire obj_request worth
of bytes is completed.  Otherwise block layer ends up confused and we
trip on

    rbd_assert(more ^ (which == img_request->obj_request_count));

in rbd_img_obj_callback() due to more being true no matter what.  We
already do it in most cases but we are missing some, in particular
those where we don't even get a chance to submit any obj_requests, due
to an early -ENOMEM for example.

A number of obj_request->xferred assignments seem to be redundant but
I haven't touched any of obj_request->xferred stuff to keep this small
and isolated.

Cc: Alex Elder <elder@linaro.org>
Cc: stable@vger.kernel.org # 3.10+
Reported-by: Shawn Edwards <lesser.evil@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 812523330a78..ec6c5c6e1ac9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2264,6 +2264,11 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
 			result, xferred);
 		if (!img_request->result)
 			img_request->result = result;
+		/*
+		 * Need to end I/O on the entire obj_request worth of
+		 * bytes in case of error.
+		 */
+		xferred = obj_request->length;
 	}
 
 	/* Image object requests don't own their page array */
-- 
1.9.3

