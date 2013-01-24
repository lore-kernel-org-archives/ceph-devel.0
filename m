From: Alex Elder <elder@inktank.com>
Subject: [PATCH 03/12, v2] rbd: kill rbd_req_coll and rbd_request
Date: Thu, 24 Jan 2013 10:32:52 -0600
Message-ID: <51016234.5050805@inktank.com>
References: <50FF11EA.3000808@inktank.com> <50FF128B.1030405@inktank.com> <5101406E.4060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:47080 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab3AXQcz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 11:32:55 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so4961605iaj.20
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 08:32:54 -0800 (PST)
In-Reply-To: <5101406E.4060602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The two remaining callers of rbd_do_request() always pass a null
collection pointer, so the "coll" and "coll_index" parameters are
not needed.  There is no other use of that data structure, so it
can be eliminated.

Deleting them means there is no need to allocate a rbd_request
structure for the callback function.  And since that's the only use
of *that* structure, it too can be eliminated.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   58
+++------------------------------------------------
 1 file changed, 3 insertions(+), 55 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7caddea..3302cea 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -162,25 +162,6 @@ struct rbd_client {
 	struct list_head	node;
 };

-/*
- * a request completion status
- */
-struct rbd_req_status {
-	int done;
-	s32 rc;
-	u64 bytes;
-};
-
-/*
- * a collection of requests
- */
-struct rbd_req_coll {
-	int			total;
-	int			num_done;
-	struct kref		kref;
-	struct rbd_req_status	status[0];
-};
-
 struct rbd_img_request;
 typedef void (*rbd_img_callback_t)(struct rbd_img_request *);

@@ -242,18 +223,6 @@ struct rbd_img_request {
 #define for_each_obj_request_safe(ireq, oreq, n) \
 	list_for_each_entry_safe_reverse(oreq, n, &ireq->obj_requests, links)

-/*
- * a single io request
- */
-struct rbd_request {
-	struct request		*rq;		/* blk layer request */
-	struct bio		*bio;		/* cloned bio */
-	struct page		**pages;	/* list of used pages */
-	u64			len;
-	int			coll_index;
-	struct rbd_req_coll	*coll;
-};
-
 struct rbd_snap {
 	struct	device		dev;
 	const char		*name;
@@ -1195,21 +1164,18 @@ static int rbd_do_request(struct request *rq,
 			  int num_pages,
 			  int flags,
 			  struct ceph_osd_req_op *op,
-			  struct rbd_req_coll *coll,
-			  int coll_index,
 			  void (*rbd_cb)(struct ceph_osd_request *,
 					 struct ceph_msg *),
 			  u64 *ver)
 {
 	struct ceph_osd_client *osdc;
 	struct ceph_osd_request *osd_req;
-	struct rbd_request *rbd_req = NULL;
 	struct timespec mtime = CURRENT_TIME;
 	int ret;

-	dout("rbd_do_request object_name=%s ofs=%llu len=%llu coll=%p[%d]\n",
+	dout("rbd_do_request object_name=%s ofs=%llu len=%llu\n",
 		object_name, (unsigned long long) ofs,
-		(unsigned long long) len, coll, coll_index);
+		(unsigned long long) len);

 	osdc = &rbd_dev->rbd_client->client->osdc;
 	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_NOIO);
@@ -1223,22 +1189,8 @@ static int rbd_do_request(struct request *rq,
 		bio_get(osd_req->r_bio);
 	}

-	if (coll) {
-		ret = -ENOMEM;
-		rbd_req = kmalloc(sizeof(*rbd_req), GFP_NOIO);
-		if (!rbd_req)
-			goto done_osd_req;
-
-		rbd_req->rq = rq;
-		rbd_req->bio = bio;
-		rbd_req->pages = pages;
-		rbd_req->len = len;
-		rbd_req->coll = coll;
-		rbd_req->coll_index = coll_index;
-	}
-
 	osd_req->r_callback = rbd_cb;
-	osd_req->r_priv = rbd_req;
+	osd_req->r_priv = NULL;

 	strncpy(osd_req->r_oid, object_name, sizeof(osd_req->r_oid));
 	osd_req->r_oid_len = strlen(osd_req->r_oid);
@@ -1274,8 +1226,6 @@ static int rbd_do_request(struct request *rq,
 done_err:
 	if (bio)
 		bio_chain_put(osd_req->r_bio);
-	kfree(rbd_req);
-done_osd_req:
 	ceph_osdc_put_request(osd_req);

 	return ret;
@@ -1314,7 +1264,6 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,
 			  pages, num_pages,
 			  flags,
 			  op,
-			  NULL, 0,
 			  NULL,
 			  ver);
 	if (ret < 0)
@@ -1390,7 +1339,6 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 			  NULL, 0,
 			  CEPH_OSD_FLAG_READ,
 			  op,
-			  NULL, 0,
 			  rbd_simple_req_cb, NULL);

 	rbd_osd_req_op_destroy(op);
-- 
1.7.9.5

