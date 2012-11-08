From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: end request on error in rbd_do_request() caller
Date: Thu, 08 Nov 2012 08:12:20 -0600
Message-ID: <509BBDC4.1070206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57441 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755644Ab2KHOMU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 09:12:20 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so4184469iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 06:12:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Only one of the three callers of rbd_do_request() provide a
collection structure to aggregate status.

If an error occurs in rbd_do_request(), have the caller
take care of calling rbd_coll_end_req() if necessary in
that one spot.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fb727c0..835153e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1128,12 +1128,8 @@ static int rbd_do_request(struct request *rq,
 	struct ceph_osd_client *osdc;

 	rbd_req = kzalloc(sizeof(*rbd_req), GFP_NOIO);
-	if (!rbd_req) {
-		if (coll)
-			rbd_coll_end_req_index(rq, coll, coll_index,
-					       (s32) -ENOMEM, len);
+	if (!rbd_req)
 		return -ENOMEM;
-	}

 	if (coll) {
 		rbd_req->coll = coll;
@@ -1208,7 +1204,6 @@ done_err:
 	bio_chain_put(rbd_req->bio);
 	ceph_osdc_put_request(osd_req);
 done_pages:
-	rbd_coll_end_req(rbd_req, (s32) ret, len);
 	kfree(rbd_req);
 	return ret;
 }
@@ -1361,7 +1356,9 @@ static int rbd_do_op(struct request *rq,
 			     ops,
 			     coll, coll_index,
 			     rbd_req_cb, 0, NULL);
-
+	if (ret < 0)
+		rbd_coll_end_req_index(rq, coll, coll_index,
+					(s32) ret, seg_len);
 	rbd_destroy_ops(ops);
 done:
 	kfree(seg_name);
-- 
1.7.9.5

