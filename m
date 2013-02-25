From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] libceph: pass object number back to calc_layout() caller
Date: Mon, 25 Feb 2013 17:12:01 -0600
Message-ID: <512BEFC1.5020006@inktank.com>
References: <512BEF26.3030207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:49627 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757698Ab3BYXMF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 18:12:05 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so3797065ieb.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 15:12:04 -0800 (PST)
In-Reply-To: <512BEF26.3030207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Have calc_layout() pass the computed object number back to its
caller.  (This is a small step to simplify review.)

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5daced2..fcc783b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -67,16 +67,15 @@ static int calc_layout(struct ceph_vino vino,
 		       struct ceph_file_layout *layout,
 		       u64 off, u64 *plen,
 		       struct ceph_osd_request *req,
-		       struct ceph_osd_req_op *op)
+		       struct ceph_osd_req_op *op, u64 *bno)
 {
 	u64 orig_len = *plen;
-	u64 bno = 0;
 	u64 objoff = 0;
 	u64 objlen = 0;
 	int r;

 	/* object extent? */
-	r = ceph_calc_file_object_mapping(layout, off, orig_len, &bno,
+	r = ceph_calc_file_object_mapping(layout, off, orig_len, bno,
 					  &objoff, &objlen);
 	if (r < 0)
 		return r;
@@ -104,9 +103,9 @@ static int calc_layout(struct ceph_vino vino,
 		op->payload_len = *plen;

 	dout("calc_layout bno=%llx %llu~%llu (%d pages)\n",
-	     bno, objoff, objlen, req->r_num_pages);
+	     *bno, objoff, objlen, req->r_num_pages);

-	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, bno);
+	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, *bno);
 	req->r_oid_len = strlen(req->r_oid);

 	return 0;
@@ -416,6 +415,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	struct ceph_osd_req_op ops[2];
 	struct ceph_osd_request *req;
 	unsigned int num_op = 1;
+	u64 bno = 0;
 	int r;

 	memset(&ops, 0, sizeof ops);
@@ -436,11 +436,12 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	req->r_flags = flags;

 	/* calculate max write size */
-	r = calc_layout(vino, layout, off, plen, req, ops);
+	r = calc_layout(vino, layout, off, plen, req, ops, &bno);
 	if (r < 0) {
 		ceph_osdc_put_request(req);
 		return ERR_PTR(r);
 	}
+
 	req->r_file_layout = *layout;  /* keep a copy */

 	/* in case it differs from natural (file) alignment that
-- 
1.7.9.5

