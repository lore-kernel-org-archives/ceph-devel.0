From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] rbd: don't leak rbd_req for rbd_req_sync_notify_ack()
Date: Fri, 30 Nov 2012 10:05:11 -0600
Message-ID: <50B8D937.5060600@inktank.com>
References: <50B8D8D4.9020703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:50845 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933190Ab2K3QFN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Nov 2012 11:05:13 -0500
Received: by mail-gg0-f174.google.com with SMTP id k2so83750ggd.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Nov 2012 08:05:12 -0800 (PST)
In-Reply-To: <50B8D8D4.9020703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

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
---
 drivers/block/rbd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 78493e7..fca0ebf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1182,7 +1182,7 @@ static int rbd_do_request(struct request *rq,
 		bio_get(osd_req->r_bio);
 	}

-	if (rbd_cb) {
+	if (coll) {
 		ret = -ENOMEM;
 		rbd_req = kmalloc(sizeof(*rbd_req), GFP_NOIO);
 		if (!rbd_req)
@@ -1193,7 +1193,7 @@ static int rbd_do_request(struct request *rq,
 		rbd_req->pages = pages;
 		rbd_req->len = len;
 		rbd_req->coll = coll;
-		rbd_req->coll_index = coll ? coll_index : 0;
+		rbd_req->coll_index = coll_index;
 	}

 	osd_req->r_callback = rbd_cb;
-- 
1.7.9.5

