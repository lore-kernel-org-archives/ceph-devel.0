From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 32/47] block-rbd: Rename a jump label in
 rbd_img_obj_parent_read_full_callback()
Date: Mon, 12 Sep 2016 21:20:58 +0200
Message-ID: <44a40a9a-22c1-989c-10b8-dfd630aeb093@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:64948 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751244AbcILTVJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 15:21:09 -0400
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 19:49:33 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1b8a8c5..7a43711 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2687,7 +2687,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	}
 
 	if (img_result)
-		goto out_err;
+		goto status_indication;
 
 	/*
 	 * The original osd request is of no use to use any more.
@@ -2698,7 +2698,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	img_result = -ENOMEM;
 	osd_req = rbd_osd_req_create_copyup(orig_request);
 	if (!osd_req)
-		goto out_err;
+		goto status_indication;
 	rbd_osd_req_destroy(orig_request->osd_req);
 	orig_request->osd_req = osd_req;
 	orig_request->copyup_pages = pages;
@@ -2721,7 +2721,7 @@ rbd_img_obj_parent_read_full_callback(struct rbd_img_request *img_request)
 	img_result = rbd_obj_request_submit(osdc, orig_request);
 	if (!img_result)
 		return;
-out_err:
+ status_indication:
 	/* Record the error code and complete the request */
 
 	orig_request->result = img_result;
-- 
2.10.0

