From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] libceph: don't set flags in ceph_osdc_alloc_request()
Date: Wed, 14 Nov 2012 10:23:03 -0600
Message-ID: <50A3C567.1060801@inktank.com>
References: <50A3C524.8070303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37325 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701Ab2KNQXG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:23:06 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so861743iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:23:05 -0800 (PST)
In-Reply-To: <50A3C524.8070303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The only thing ceph_osdc_alloc_request() really does with the
flags value it is passed is assign it to the newly-created
osd request structure.  Do that in the caller instead.

Both callers subsequently call ceph_osdc_build_request(), so have
that function (instead of ceph_osdc_alloc_request()) issue a warning
if a request comes through with neither the read nor write flags set.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    3 ++-
 include/linux/ceph/osd_client.h |    1 -
 net/ceph/osd_client.c           |   11 ++++-------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2d10504..b6b1522 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1150,13 +1150,14 @@ static int rbd_do_request(struct request *rq,
 		(unsigned long long) len, coll, coll_index);

 	osdc = &rbd_dev->rbd_client->client->osdc;
-	osd_req = ceph_osdc_alloc_request(osdc, flags, snapc, ops,
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, ops,
 					false, GFP_NOIO, pages, bio);
 	if (!osd_req) {
 		ret = -ENOMEM;
 		goto done_pages;
 	}

+	osd_req->r_flags = flags;
 	osd_req->r_callback = rbd_cb;

 	rbd_req->rq = rq;
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index fe3a6e8..6ddda5b 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -213,7 +213,6 @@ extern int ceph_calc_raw_layout(struct
ceph_file_layout *layout,
 			struct ceph_osd_req_op *op);

 extern struct ceph_osd_request *ceph_osdc_alloc_request(struct
ceph_osd_client *osdc,
-					       int flags,
 					       struct ceph_snap_context *snapc,
 					       struct ceph_osd_req_op *ops,
 					       bool use_mempool,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index baaec06..3e82e61 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -163,7 +163,6 @@ static int get_num_ops(struct ceph_osd_req_op *ops)
 }

 struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client
*osdc,
-					       int flags,
 					       struct ceph_snap_context *snapc,
 					       struct ceph_osd_req_op *ops,
 					       bool use_mempool,
@@ -200,10 +199,6 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	INIT_LIST_HEAD(&req->r_req_lru_item);
 	INIT_LIST_HEAD(&req->r_osd_item);

-	req->r_flags = flags;
-
-	WARN_ON((flags & (CEPH_OSD_FLAG_READ|CEPH_OSD_FLAG_WRITE)) == 0);
-
 	/* create reply message */
 	if (use_mempool)
 		msg = ceph_msgpool_get(&osdc->msgpool_op_reply, 0);
@@ -339,6 +334,8 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 	u64 data_len = 0;
 	int i;

+	WARN_ON((flags & (CEPH_OSD_FLAG_READ|CEPH_OSD_FLAG_WRITE)) == 0);
+
 	head = msg->front.iov_base;
 	head->snapid = cpu_to_le64(snap_id);
 	op = (void *)(head + 1);
@@ -434,12 +431,12 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	} else
 		ops[1].op = 0;

-	req = ceph_osdc_alloc_request(osdc, flags,
-					 snapc, ops,
+	req = ceph_osdc_alloc_request(osdc, snapc, ops,
 					 use_mempool,
 					 GFP_NOFS, NULL, NULL);
 	if (!req)
 		return ERR_PTR(-ENOMEM);
+	req->r_flags = flags;

 	/* calculate max write size */
 	r = calc_layout(vino, layout, off, plen, req, ops);
-- 
1.7.9.5

