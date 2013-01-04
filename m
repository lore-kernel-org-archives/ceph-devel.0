From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 1/2] rbd: don't leak rbd_req on synchronous requests
Date: Fri, 04 Jan 2013 08:58:26 -0600
Message-ID: <50E6EE12.4090001@inktank.com>
References: <50E6EDCE.8050608@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:35512 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab3ADO63 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:58:29 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so13741973iad.41
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:58:29 -0800 (PST)
In-Reply-To: <50E6EDCE.8050608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When rbd_do_request() is called it allocates and populates an
rbd_req structure to hold information about the osd request to be
sent.  This is done for the benefit of the callback function (in
particular, rbd_req_cb()), which uses this in processing when
the request completes.

Synchronous requests provide no callback function, in which case
rbd_do_request() waits for the request to complete before returning.
This case is not handling the needed free of the rbd_req structure
like it should, so it is getting leaked.

Note however that the synchronous case has no need for the rbd_req
structure at all.  So rather than simply freeing this structure for
synchronous requests, just don't allocate it to begin with.

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c1e5f24..17bf0b4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1113,20 +1113,11 @@ static int rbd_do_request(struct request *rq,
 			  struct ceph_osd_request **linger_req,
 			  u64 *ver)
 {
+	struct ceph_osd_client *osdc;
 	struct ceph_osd_request *osd_req;
-	int ret;
+	struct rbd_request *rbd_req = NULL;
 	struct timespec mtime = CURRENT_TIME;
-	struct rbd_request *rbd_req;
-	struct ceph_osd_client *osdc;
-
-	rbd_req = kzalloc(sizeof(*rbd_req), GFP_NOIO);
-	if (!rbd_req)
-		return -ENOMEM;
-
-	if (coll) {
-		rbd_req->coll = coll;
-		rbd_req->coll_index = coll_index;
-	}
+	int ret;

 	dout("rbd_do_request object_name=%s ofs=%llu len=%llu coll=%p[%d]\n",
 		object_name, (unsigned long long) ofs,
@@ -1134,10 +1125,8 @@ static int rbd_do_request(struct request *rq,

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_NOIO);
-	if (!osd_req) {
-		ret = -ENOMEM;
-		goto done_pages;
-	}
+	if (!osd_req)
+		return -ENOMEM;

 	osd_req->r_flags = flags;
 	osd_req->r_pages = pages;
@@ -1145,13 +1134,22 @@ static int rbd_do_request(struct request *rq,
 		osd_req->r_bio = bio;
 		bio_get(osd_req->r_bio);
 	}
-	osd_req->r_callback = rbd_cb;

-	rbd_req->rq = rq;
-	rbd_req->bio = bio;
-	rbd_req->pages = pages;
-	rbd_req->len = len;
+	if (rbd_cb) {
+		ret = -ENOMEM;
+		rbd_req = kmalloc(sizeof(*rbd_req), GFP_NOIO);
+		if (!rbd_req)
+			goto done_osd_req;
+
+		rbd_req->rq = rq;
+		rbd_req->bio = bio;
+		rbd_req->pages = pages;
+		rbd_req->len = len;
+		rbd_req->coll = coll;
+		rbd_req->coll_index = coll ? coll_index : 0;
+	}

+	osd_req->r_callback = rbd_cb;
 	osd_req->r_priv = rbd_req;

 	strncpy(osd_req->r_oid, object_name, sizeof(osd_req->r_oid));
@@ -1193,10 +1191,12 @@ static int rbd_do_request(struct request *rq,
 	return ret;

 done_err:
-	bio_chain_put(rbd_req->bio);
-	ceph_osdc_put_request(osd_req);
-done_pages:
+	if (bio)
+		bio_chain_put(osd_req->r_bio);
 	kfree(rbd_req);
+done_osd_req:
+	ceph_osdc_put_request(osd_req);
+
 	return ret;
 }

-- 
1.7.9.5

