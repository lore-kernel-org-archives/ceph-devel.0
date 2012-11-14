From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] libceph: don't set pages or bio in ceph_osdc_alloc_request()
Date: Wed, 14 Nov 2012 10:23:16 -0600
Message-ID: <50A3C574.1030807@inktank.com>
References: <50A3C524.8070303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37325 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909Ab2KNQXU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:23:20 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so861743iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:23:20 -0800 (PST)
In-Reply-To: <50A3C524.8070303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Only one of the two callers of ceph_osdc_alloc_request() provides
page or bio data for its payload.  And essentially all that function
was doing with those arguments was assigning them to fields in the
osd request structure.

Simplify ceph_osdc_alloc_request() by having the caller take care of
making those assignments

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    8 ++++++--
 include/linux/ceph/osd_client.h |    4 +---
 net/ceph/osd_client.c           |   15 ++-------------
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b6b1522..bdb099c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1150,14 +1150,18 @@ static int rbd_do_request(struct request *rq,
 		(unsigned long long) len, coll, coll_index);

 	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, snapc, ops,
-					false, GFP_NOIO, pages, bio);
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, ops, false, GFP_NOIO);
 	if (!osd_req) {
 		ret = -ENOMEM;
 		goto done_pages;
 	}

 	osd_req->r_flags = flags;
+	osd_req->r_pages = pages;
+	if (bio) {
+		osd_req->r_bio = bio;
+		bio_get(osd_req->r_bio);
+	}
 	osd_req->r_callback = rbd_cb;

 	rbd_req->rq = rq;
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 6ddda5b..75f56d3 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -216,9 +216,7 @@ extern struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *
 					       struct ceph_snap_context *snapc,
 					       struct ceph_osd_req_op *ops,
 					       bool use_mempool,
-					       gfp_t gfp_flags,
-					       struct page **pages,
-					       struct bio *bio);
+					       gfp_t gfp_flags);

 extern void ceph_osdc_build_request(struct ceph_osd_request *req,
 				    u64 off, u64 len,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 3e82e61..5ed9c92 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -166,9 +166,7 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
 					       struct ceph_osd_req_op *ops,
 					       bool use_mempool,
-					       gfp_t gfp_flags,
-					       struct page **pages,
-					       struct bio *bio)
+					       gfp_t gfp_flags)
 {
 	struct ceph_osd_request *req;
 	struct ceph_msg *msg;
@@ -229,13 +227,6 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	memset(msg->front.iov_base, 0, msg->front.iov_len);

 	req->r_request = msg;
-	req->r_pages = pages;
-#ifdef CONFIG_BLOCK
-	if (bio) {
-		req->r_bio = bio;
-		bio_get(req->r_bio);
-	}
-#endif

 	return req;
 }
@@ -431,9 +422,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	} else
 		ops[1].op = 0;

-	req = ceph_osdc_alloc_request(osdc, snapc, ops,
-					 use_mempool,
-					 GFP_NOFS, NULL, NULL);
+	req = ceph_osdc_alloc_request(osdc, snapc, ops, use_mempool, GFP_NOFS);
 	if (!req)
 		return ERR_PTR(-ENOMEM);
 	req->r_flags = flags;
-- 
1.7.9.5

