From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 2/2] rbd: don't leak rbd_req for rbd_req_sync_notify_ack()
Date: Fri, 04 Jan 2013 08:58:43 -0600
Message-ID: <50E6EE23.20502@inktank.com>
References: <50E6EDCE.8050608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:65228 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab3ADO6p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:58:45 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so13742255iad.41
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:58:45 -0800 (PST)
In-Reply-To: <50E6EDCE.8050608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When rbd_req_sync_notify_ack() calls rbd_do_request() it supplies
rbd_simple_req_cb() as its callback function.  Because the callback
is supplied, an rbd_req structure gets allocated and populated so it
can be used by the callback.  However rbd_simple_req_cb() is not
freeing (or even using) the rbd_req structure, so it's getting
leaked.

Since rbd_simple_req_cb() has no need for the rbd_req structure,
just avoid allocating one for this case.  Of the three calls to
rbd_do_request(), only the one from rbd_do_op() needs the rbd_req
structure, and that call can be distinguished from the other two
because it supplies a non-null rbd_collection pointer.

So fix this leak by only allocating the rbd_req structure if a
non-null "coll" value is provided to rbd_do_request().

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 17bf0b4..f0b30b2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1135,7 +1135,7 @@ static int rbd_do_request(struct request *rq,
 		bio_get(osd_req->r_bio);
 	}

-	if (rbd_cb) {
+	if (coll) {
 		ret = -ENOMEM;
 		rbd_req = kmalloc(sizeof(*rbd_req), GFP_NOIO);
 		if (!rbd_req)
@@ -1146,7 +1146,7 @@ static int rbd_do_request(struct request *rq,
 		rbd_req->pages = pages;
 		rbd_req->len = len;
 		rbd_req->coll = coll;
-		rbd_req->coll_index = coll ? coll_index : 0;
+		rbd_req->coll_index = coll_index;
 	}

 	osd_req->r_callback = rbd_cb;
-- 
1.7.9.5

