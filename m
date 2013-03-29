From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] libceph: don't update op in calc_layout()
Date: Fri, 29 Mar 2013 16:32:06 -0500
Message-ID: <51560856.4070805@inktank.com>
References: <5156080E.9040603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:45547 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab3C2VcI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 17:32:08 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so697079iak.32
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 14:32:08 -0700 (PDT)
In-Reply-To: <5156080E.9040603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The ceph_osdc_new_request() an array of osd operations is built up
and filled in partially within that function and partially in the
called function calc_layout().  Move the latter part back out to
ceph_osdc_new_request() so it's all done in one place.  This makes
it unnecessary to pass the op pointer to calc_layout(), so get rid
of that parameter.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f782aca..0eb417b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -64,8 +64,7 @@ static int op_has_extent(int op)
  * fill osd op in request message.
  */
 static int calc_layout(struct ceph_file_layout *layout, u64 off, u64 *plen,
-		       struct ceph_osd_req_op *op, u64 *objnum,
-		       u64 *objoff, u64 *objlen)
+			u64 *objnum, u64 *objoff, u64 *objlen)
 {
 	u64 orig_len = *plen;
 	int r;
@@ -81,21 +80,6 @@ static int calc_layout(struct ceph_file_layout
*layout, u64 off, u64 *plen,
 		     orig_len - *plen, off, *plen);
 	}

-	if (op_has_extent(op->op)) {
-		u32 osize = le32_to_cpu(layout->fl_object_size);
-		op->extent.offset = *objoff;
-		op->extent.length = *objlen;
-		if (op->extent.truncate_size <= off - *objoff) {
-			op->extent.truncate_size = 0;
-		} else {
-			op->extent.truncate_size -= off - *objoff;
-			if (op->extent.truncate_size > osize)
-				op->extent.truncate_size = osize;
-		}
-	}
-	if (op->op == CEPH_OSD_OP_WRITE)
-		op->payload_len = *plen;
-
 	dout("calc_layout objnum=%llx %llu~%llu\n", *objnum, *objoff, *objlen);

 	return 0;
@@ -594,11 +578,27 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	req->r_flags = flags;

 	/* calculate max write size */
-	r = calc_layout(layout, off, plen, ops, &objnum, &objoff, &objlen);
+	r = calc_layout(layout, off, plen, &objnum, &objoff, &objlen);
 	if (r < 0) {
 		ceph_osdc_put_request(req);
 		return ERR_PTR(r);
 	}
+
+	if (op_has_extent(ops[0].op)) {
+		u32 osize = le32_to_cpu(layout->fl_object_size);
+		ops[0].extent.offset = objoff;
+		ops[0].extent.length = objlen;
+		if (ops[0].extent.truncate_size <= off - objoff) {
+			ops[0].extent.truncate_size = 0;
+		} else {
+			ops[0].extent.truncate_size -= off - objoff;
+			if (ops[0].extent.truncate_size > osize)
+				ops[0].extent.truncate_size = osize;
+		}
+	}
+	if (ops[0].op == CEPH_OSD_OP_WRITE)
+		ops[0].payload_len = *plen;
+
 	req->r_file_layout = *layout;  /* keep a copy */

 	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx",
-- 
1.7.9.5

