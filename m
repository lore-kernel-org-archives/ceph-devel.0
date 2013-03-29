From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] libceph: pass offset and length out of calc_layout()
Date: Fri, 29 Mar 2013 16:31:53 -0500
Message-ID: <51560849.9060602@inktank.com>
References: <5156080E.9040603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40555 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213Ab3C2Vb4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 17:31:56 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so699346iac.33
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 14:31:55 -0700 (PDT)
In-Reply-To: <5156080E.9040603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The purpose of calc_layout() is to determine, given a file offset
and length and a layout describing the placement of file data across
objects, where in "object space" that data resides.

Specifically, it determines which object should hold the first part
of the specified range of file data, and the offset and length of
data within that object.  The length will not exceed the bounds
of the object, and the caller is informed of that maximum length.

Add two parameters to calc_layout() to allow the object-relative
offset and length to be passed back to the caller.

This is the first steps toward having ceph_osdc_new_request() build
its osd op structure using osd_req_op_extent_init().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 02ed728..f782aca 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -64,32 +64,31 @@ static int op_has_extent(int op)
  * fill osd op in request message.
  */
 static int calc_layout(struct ceph_file_layout *layout, u64 off, u64 *plen,
-		       struct ceph_osd_req_op *op, u64 *bno)
+		       struct ceph_osd_req_op *op, u64 *objnum,
+		       u64 *objoff, u64 *objlen)
 {
 	u64 orig_len = *plen;
-	u64 objoff = 0;
-	u64 objlen = 0;
 	int r;

 	/* object extent? */
-	r = ceph_calc_file_object_mapping(layout, off, orig_len, bno,
-					  &objoff, &objlen);
+	r = ceph_calc_file_object_mapping(layout, off, orig_len, objnum,
+					  objoff, objlen);
 	if (r < 0)
 		return r;
-	if (objlen < orig_len) {
-		*plen = objlen;
+	if (*objlen < orig_len) {
+		*plen = *objlen;
 		dout(" skipping last %llu, final file extent %llu~%llu\n",
 		     orig_len - *plen, off, *plen);
 	}

 	if (op_has_extent(op->op)) {
 		u32 osize = le32_to_cpu(layout->fl_object_size);
-		op->extent.offset = objoff;
-		op->extent.length = objlen;
-		if (op->extent.truncate_size <= off - objoff) {
+		op->extent.offset = *objoff;
+		op->extent.length = *objlen;
+		if (op->extent.truncate_size <= off - *objoff) {
 			op->extent.truncate_size = 0;
 		} else {
-			op->extent.truncate_size -= off - objoff;
+			op->extent.truncate_size -= off - *objoff;
 			if (op->extent.truncate_size > osize)
 				op->extent.truncate_size = osize;
 		}
@@ -97,7 +96,7 @@ static int calc_layout(struct ceph_file_layout
*layout, u64 off, u64 *plen,
 	if (op->op == CEPH_OSD_OP_WRITE)
 		op->payload_len = *plen;

-	dout("calc_layout bno=%llx %llu~%llu\n", *bno, objoff, objlen);
+	dout("calc_layout objnum=%llx %llu~%llu\n", *objnum, *objoff, *objlen);

 	return 0;
 }
@@ -572,7 +571,9 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	struct ceph_osd_req_op ops[2];
 	struct ceph_osd_request *req;
 	unsigned int num_op = 1;
-	u64 bno = 0;
+	u64 objnum = 0;
+	u64 objoff = 0;
+	u64 objlen = 0;
 	int r;

 	memset(&ops, 0, sizeof ops);
@@ -593,14 +594,15 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	req->r_flags = flags;

 	/* calculate max write size */
-	r = calc_layout(layout, off, plen, ops, &bno);
+	r = calc_layout(layout, off, plen, ops, &objnum, &objoff, &objlen);
 	if (r < 0) {
 		ceph_osdc_put_request(req);
 		return ERR_PTR(r);
 	}
 	req->r_file_layout = *layout;  /* keep a copy */

-	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, bno);
+	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx",
+		vino.ino, objnum);
 	req->r_oid_len = strlen(req->r_oid);

 	ceph_osdc_build_request(req, off, num_op, ops,
-- 
1.7.9.5

