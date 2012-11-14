From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] libceph: drop snapid in ceph_calc_raw_layout()
Date: Wed, 14 Nov 2012 10:15:40 -0600
Message-ID: <50A3C3AC.8030703@inktank.com>
References: <50A3C346.1010400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34929 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423015Ab2KNQPm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 11:15:42 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so846711iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 08:15:42 -0800 (PST)
In-Reply-To: <50A3C346.1010400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

A snapshot id must be provided to ceph_calc_raw_layout() even though
it is not needed at all for calculating the layout.

Where the snapshot id *is* needed is when building the request
message for an osd operation.

Drop the snapid parameter from ceph_calc_raw_layout() and pass
that value instead in ceph_osdc_build_request().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    4 ++--
 include/linux/ceph/osd_client.h |    2 +-
 net/ceph/osd_client.c           |   14 ++++----------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 08d1b6e..4e44085 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1171,10 +1171,10 @@ static int rbd_do_request(struct request *rq,

 	rbd_layout_init(&osd_req->r_file_layout, rbd_dev->spec->pool_id);
 	ret = ceph_calc_raw_layout(osdc, &osd_req->r_file_layout,
-				snapid, ofs, &len, &bno, osd_req, ops);
+				ofs, &len, &bno, osd_req, ops);
 	rbd_assert(ret == 0);

-	ceph_osdc_build_request(osd_req, ofs, len, ops, snapc, &mtime);
+	ceph_osdc_build_request(osd_req, ofs, len, ops, snapc, snapid, &mtime);

 	if (linger_req) {
 		ceph_osdc_set_request_linger(osdc, osd_req);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 4bfb458..0e82a0a 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -209,7 +209,6 @@ extern void ceph_osdc_handle_map(struct
ceph_osd_client *osdc,

 extern int ceph_calc_raw_layout(struct ceph_osd_client *osdc,
 			struct ceph_file_layout *layout,
-			u64 snapid,
 			u64 off, u64 *plen, u64 *bno,
 			struct ceph_osd_request *req,
 			struct ceph_osd_req_op *op);
@@ -227,6 +226,7 @@ extern void ceph_osdc_build_request(struct
ceph_osd_request *req,
 				    u64 off, u64 len,
 				    struct ceph_osd_req_op *src_ops,
 				    struct ceph_snap_context *snapc,
+				    u64 snap_id,
 				    struct timespec *mtime);

 extern struct ceph_osd_request *ceph_osdc_new_request(struct
ceph_osd_client *,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 60c4e15..f844a35 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -40,18 +40,14 @@ static int op_has_extent(int op)

 int ceph_calc_raw_layout(struct ceph_osd_client *osdc,
 			struct ceph_file_layout *layout,
-			u64 snapid,
 			u64 off, u64 *plen, u64 *bno,
 			struct ceph_osd_request *req,
 			struct ceph_osd_req_op *op)
 {
-	struct ceph_osd_request_head *reqhead = req->r_request->front.iov_base;
 	u64 orig_len = *plen;
 	u64 objoff, objlen;    /* extent in object */
 	int r;

-	reqhead->snapid = cpu_to_le64(snapid);
-
 	/* object extent? */
 	r = ceph_calc_file_object_mapping(layout, off, orig_len, bno,
 					  &objoff, &objlen);
@@ -113,8 +109,7 @@ static int calc_layout(struct ceph_osd_client *osdc,
 	u64 bno;
 	int r;

-	r = ceph_calc_raw_layout(osdc, layout, vino.snap, off,
-				 plen, &bno, req, op);
+	r = ceph_calc_raw_layout(osdc, layout, off, plen, &bno, req, op);
 	if (r < 0)
 		return r;

@@ -332,7 +327,7 @@ static void osd_req_encode_op(struct
ceph_osd_request *req,
 void ceph_osdc_build_request(struct ceph_osd_request *req,
 			     u64 off, u64 len,
 			     struct ceph_osd_req_op *src_ops,
-			     struct ceph_snap_context *snapc,
+			     struct ceph_snap_context *snapc, u64 snap_id,
 			     struct timespec *mtime)
 {
 	struct ceph_msg *msg = req->r_request;
@@ -347,6 +342,7 @@ void ceph_osdc_build_request(struct ceph_osd_request
*req,
 	int i;

 	head = msg->front.iov_base;
+	head->snapid = cpu_to_le64(snap_id);
 	op = (void *)(head + 1);
 	p = (void *)(op + num_op);

@@ -458,9 +454,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	req->r_num_pages = calc_pages_for(page_align, *plen);
 	req->r_page_alignment = page_align;

-	ceph_osdc_build_request(req, off, *plen, ops,
-				snapc,
-				mtime);
+	ceph_osdc_build_request(req, off, *plen, ops, snapc, vino.snap, mtime);

 	return req;
 }
-- 
1.7.9.5

