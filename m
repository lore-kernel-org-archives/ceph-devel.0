From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH] rbd: fix I/O error propagation for reads
Date: Mon, 26 Aug 2013 18:34:02 -0700
Message-ID: <1377567242-25736-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53221 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab3H0Bwe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Aug 2013 21:52:34 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id CF5C426407
	for <ceph-devel@vger.kernel.org>; Mon, 26 Aug 2013 18:50:20 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id BE4E626406
	for <ceph-devel@vger.kernel.org>; Mon, 26 Aug 2013 18:50:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a request returns an error, the driver needs to report the entire
extent of the request as completed.  Writes already did this, since
they always set xferred = length, but reads were skipping that step if
an error other than -ENOENT occurred.  Instead, rbd would end up
passing 0 xferred to blk_end_request(), which would always report
needing more data.  This resulted in an assert failing when more data
was required by the block layer, but all the object requests were
done:

[ 1868.719077] rbd: obj_request read result -108 xferred 0
[ 1868.719077]
[ 1868.719518] end_request: I/O error, dev rbd1, sector 0
[ 1868.719739]
[ 1868.719739] Assertion failure in rbd_img_obj_callback() at line 1736:
[ 1868.719739]
[ 1868.719739]   rbd_assert(more ^ (which == img_request->obj_request_count));

Without this assert, reads that hit errors would hang forever, since
the block layer considered them incomplete.

Fixes: http://tracker.ceph.com/issues/5647
Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0d669ae..f8fd7d3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1557,11 +1557,12 @@ rbd_img_obj_request_read_callback(struct rbd_obj_request *obj_request)
 		obj_request, obj_request->img_request, obj_request->result,
 		xferred, length);
 	/*
-	 * ENOENT means a hole in the image.  We zero-fill the
-	 * entire length of the request.  A short read also implies
-	 * zero-fill to the end of the request.  Either way we
-	 * update the xferred count to indicate the whole request
-	 * was satisfied.
+	 * ENOENT means a hole in the image.  We zero-fill the entire
+	 * length of the request.  A short read also implies zero-fill
+	 * to the end of the request.  An error requires the whole
+	 * length of the request to be reported finished with an error
+	 * to the block layer.  In each case we update the xferred
+	 * count to indicate the whole request was satisfied.
 	 */
 	rbd_assert(obj_request->type != OBJ_REQUEST_NODATA);
 	if (obj_request->result == -ENOENT) {
@@ -1570,14 +1571,13 @@ rbd_img_obj_request_read_callback(struct rbd_obj_request *obj_request)
 		else
 			zero_pages(obj_request->pages, 0, length);
 		obj_request->result = 0;
-		obj_request->xferred = length;
 	} else if (xferred < length && !obj_request->result) {
 		if (obj_request->type == OBJ_REQUEST_BIO)
 			zero_bio_chain(obj_request->bio_list, xferred);
 		else
 			zero_pages(obj_request->pages, xferred, length);
-		obj_request->xferred = length;
 	}
+	obj_request->xferred = length;
 	obj_request_done_set(obj_request);
 }
 
-- 
1.7.2.5

