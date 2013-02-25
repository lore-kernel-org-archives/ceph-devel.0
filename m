From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: don't pass request to calc_layout()
Date: Mon, 25 Feb 2013 17:12:34 -0600
Message-ID: <512BEFE2.1080409@inktank.com>
References: <512BEF26.3030207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33709 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758265Ab3BYXMh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 18:12:37 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so3873544ieb.29
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 15:12:37 -0800 (PST)
In-Reply-To: <512BEF26.3030207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The only remaining reason to pass the osd request to calc_layout()
is to fill in its r_num_pages and r_page_alignment fields.  Once it
fills those in, it doesn't do anything more with them.

We can therefore move those assignments into the caller, and get rid
of the "req" parameter entirely.

Note, however, that the only caller is ceph_osdc_new_request(),
and that immediately overwrites those fields with values based on
its passed-in page offset.  So the assignment inside calc_layout()
was redundant anyway.

This resolves:
    http://tracker.ceph.com/issues/4262

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 4f90c24..980911e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -64,7 +64,6 @@ static int op_has_extent(int op)
  * fill osd op in request message.
  */
 static int calc_layout(struct ceph_file_layout *layout, u64 off, u64 *plen,
-		       struct ceph_osd_request *req,
 		       struct ceph_osd_req_op *op, u64 *bno)
 {
 	u64 orig_len = *plen;
@@ -95,13 +94,10 @@ static int calc_layout(struct ceph_file_layout
*layout, u64 off, u64 *plen,
 				op->extent.truncate_size = osize;
 		}
 	}
-	req->r_num_pages = calc_pages_for(off, *plen);
-	req->r_page_alignment = off & ~PAGE_MASK;
 	if (op->op == CEPH_OSD_OP_WRITE)
 		op->payload_len = *plen;

-	dout("calc_layout bno=%llx %llu~%llu (%d pages)\n",
-	     *bno, objoff, objlen, req->r_num_pages);
+	dout("calc_layout bno=%llx %llu~%llu\n", *bno, objoff, objlen);

 	return 0;
 }
@@ -431,7 +427,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	req->r_flags = flags;

 	/* calculate max write size */
-	r = calc_layout(layout, off, plen, req, ops, &bno);
+	r = calc_layout(layout, off, plen, ops, &bno);
 	if (r < 0) {
 		ceph_osdc_put_request(req);
 		return ERR_PTR(r);
@@ -442,8 +438,8 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, bno);
 	req->r_oid_len = strlen(req->r_oid);

-	/* in case it differs from natural (file) alignment that
-	   calc_layout filled in for us */
+	/* The alignment may differ from the natural (file) alignment */
+
 	req->r_num_pages = calc_pages_for(page_align, *plen);
 	req->r_page_alignment = page_align;

-- 
1.7.9.5

