From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] rbd: don't leak rbd_req on synchronous requests
Date: Fri, 30 Nov 2012 10:04:58 -0600
Message-ID: <50B8D92A.7040807@inktank.com>
References: <50B8D8D4.9020703@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:65010 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933180Ab2K3QE7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Nov 2012 11:04:59 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so459112iay.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Nov 2012 08:04:58 -0800 (PST)
In-Reply-To: <50B8D8D4.9020703@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

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
---
 drivers/block/rbd.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index acdb4a6..78493e7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1160,20 +1160,11 @@ static int rbd_do_request(struct request *rq,
 					 struct ceph_msg *),
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
@@ -1181,10 +1172,8 @@ static int rbd_do_request(struct request *rq,

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
@@ -1192,13 +1181,22 @@ static int rbd_do_request(struct request *rq,
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
@@ -1233,10 +1231,12 @@ static int rbd_do_request(struct request *rq,
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

