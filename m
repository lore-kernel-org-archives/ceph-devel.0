From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 30/47] block-rbd: Refactor a jump target in
 rbd_img_obj_exists_callback()
Date: Mon, 12 Sep 2016 21:16:34 +0200
Message-ID: <0c3708aa-f7b2-0b0f-234d-dd63f44e7072@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:60396 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbcILTQp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 15:16:45 -0400
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 19:46:43 +0200

Adjust a jump target so that a duplicate check can then be avoided
at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f3f2919..7d5f7b9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2879,7 +2879,7 @@ static void rbd_img_obj_exists_callback(struct rbd_obj_request *obj_request)
 		obj_request_existence_set(orig_request, false);
 	} else if (result) {
 		orig_request->result = result;
-		goto out;
+		goto complete_request;
 	}
 
 	/*
@@ -2887,8 +2887,8 @@ static void rbd_img_obj_exists_callback(struct rbd_obj_request *obj_request)
 	 * whether the target object exists.
 	 */
 	orig_request->result = rbd_img_obj_request_submit(orig_request);
-out:
 	if (orig_request->result)
+ complete_request:
 		rbd_obj_request_complete(orig_request);
 }
 
-- 
2.10.0

