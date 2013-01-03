From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 1/2] rbd: standardize rbd_request variable names
Date: Thu, 03 Jan 2013 16:38:54 -0600
Message-ID: <50E6087E.7000709@inktank.com>
References: <50E60842.2040204@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:57322 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab3ACWi6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 17:38:58 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so19099717iec.27
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 14:38:56 -0800 (PST)
In-Reply-To: <50E60842.2040204@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There are two names used for items of rbd_request structure type:
"req" and "req_data".  The former name is also used to represent
items of pointers to struct ceph_osd_request.

Change all variables that have these names so they are instead
called "rbd_req" consistently.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   50
++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 530a121..0091fa4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1088,10 +1088,12 @@ static void rbd_coll_end_req_index(struct
request *rq,
 	spin_unlock_irq(q->queue_lock);
 }

-static void rbd_coll_end_req(struct rbd_request *req,
+static void rbd_coll_end_req(struct rbd_request *rbd_req,
 			     int ret, u64 len)
 {
-	rbd_coll_end_req_index(req->rq, req->coll, req->coll_index, ret, len);
+	rbd_coll_end_req_index(rbd_req->rq,
+				rbd_req->coll, rbd_req->coll_index,
+				ret, len);
 }

 /*
@@ -1119,12 +1121,12 @@ static int rbd_do_request(struct request *rq,
 	int ret;
 	u64 bno;
 	struct timespec mtime = CURRENT_TIME;
-	struct rbd_request *req_data;
+	struct rbd_request *rbd_req;
 	struct ceph_osd_request_head *reqhead;
 	struct ceph_osd_client *osdc;

-	req_data = kzalloc(sizeof(*req_data), GFP_NOIO);
-	if (!req_data) {
+	rbd_req = kzalloc(sizeof(*rbd_req), GFP_NOIO);
+	if (!rbd_req) {
 		if (coll)
 			rbd_coll_end_req_index(rq, coll, coll_index,
 					       -ENOMEM, len);
@@ -1132,8 +1134,8 @@ static int rbd_do_request(struct request *rq,
 	}

 	if (coll) {
-		req_data->coll = coll;
-		req_data->coll_index = coll_index;
+		rbd_req->coll = coll;
+		rbd_req->coll_index = coll_index;
 	}

 	dout("rbd_do_request object_name=%s ofs=%llu len=%llu coll=%p[%d]\n",
@@ -1150,12 +1152,12 @@ static int rbd_do_request(struct request *rq,

 	req->r_callback = rbd_cb;

-	req_data->rq = rq;
-	req_data->bio = bio;
-	req_data->pages = pages;
-	req_data->len = len;
+	rbd_req->rq = rq;
+	rbd_req->bio = bio;
+	rbd_req->pages = pages;
+	rbd_req->len = len;

-	req->r_priv = req_data;
+	req->r_priv = rbd_req;

 	reqhead = req->r_request->front.iov_base;
 	reqhead->snapid = cpu_to_le64(CEPH_NOSNAP);
@@ -1200,11 +1202,11 @@ static int rbd_do_request(struct request *rq,
 	return ret;

 done_err:
-	bio_chain_put(req_data->bio);
+	bio_chain_put(rbd_req->bio);
 	ceph_osdc_put_request(req);
 done_pages:
-	rbd_coll_end_req(req_data, ret, len);
-	kfree(req_data);
+	rbd_coll_end_req(rbd_req, ret, len);
+	kfree(rbd_req);
 	return ret;
 }

@@ -1213,7 +1215,7 @@ done_pages:
  */
 static void rbd_req_cb(struct ceph_osd_request *req, struct ceph_msg *msg)
 {
-	struct rbd_request *req_data = req->r_priv;
+	struct rbd_request *rbd_req = req->r_priv;
 	struct ceph_osd_reply_head *replyhead;
 	struct ceph_osd_op *op;
 	__s32 rc;
@@ -1232,20 +1234,20 @@ static void rbd_req_cb(struct ceph_osd_request
*req, struct ceph_msg *msg)
 		(unsigned long long) bytes, read_op, (int) rc);

 	if (rc == -ENOENT && read_op) {
-		zero_bio_chain(req_data->bio, 0);
+		zero_bio_chain(rbd_req->bio, 0);
 		rc = 0;
-	} else if (rc == 0 && read_op && bytes < req_data->len) {
-		zero_bio_chain(req_data->bio, bytes);
-		bytes = req_data->len;
+	} else if (rc == 0 && read_op && bytes < rbd_req->len) {
+		zero_bio_chain(rbd_req->bio, bytes);
+		bytes = rbd_req->len;
 	}

-	rbd_coll_end_req(req_data, rc, bytes);
+	rbd_coll_end_req(rbd_req, rc, bytes);

-	if (req_data->bio)
-		bio_chain_put(req_data->bio);
+	if (rbd_req->bio)
+		bio_chain_put(rbd_req->bio);

 	ceph_osdc_put_request(req);
-	kfree(req_data);
+	kfree(rbd_req);
 }

 static void rbd_simple_req_cb(struct ceph_osd_request *req, struct
ceph_msg *msg)
-- 
1.7.9.5

