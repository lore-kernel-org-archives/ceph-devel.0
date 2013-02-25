From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] libceph: format target object name in caller
Date: Mon, 25 Feb 2013 17:12:15 -0600
Message-ID: <512BEFCF.80408@inktank.com>
References: <512BEF26.3030207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:64504 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758265Ab3BYXMT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 18:12:19 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so2950875iaz.2
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 15:12:18 -0800 (PST)
In-Reply-To: <512BEF26.3030207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Move the formatting of the object name (oid) to use for an object
request into the caller of calc_layout().  This makes the "vino"
parameter no longer necessary, so get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index fcc783b..4f90c24 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -63,9 +63,7 @@ static int op_has_extent(int op)
  *
  * fill osd op in request message.
  */
-static int calc_layout(struct ceph_vino vino,
-		       struct ceph_file_layout *layout,
-		       u64 off, u64 *plen,
+static int calc_layout(struct ceph_file_layout *layout, u64 off, u64 *plen,
 		       struct ceph_osd_request *req,
 		       struct ceph_osd_req_op *op, u64 *bno)
 {
@@ -105,9 +103,6 @@ static int calc_layout(struct ceph_vino vino,
 	dout("calc_layout bno=%llx %llu~%llu (%d pages)\n",
 	     *bno, objoff, objlen, req->r_num_pages);

-	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, *bno);
-	req->r_oid_len = strlen(req->r_oid);
-
 	return 0;
 }

@@ -436,7 +431,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	req->r_flags = flags;

 	/* calculate max write size */
-	r = calc_layout(vino, layout, off, plen, req, ops, &bno);
+	r = calc_layout(layout, off, plen, req, ops, &bno);
 	if (r < 0) {
 		ceph_osdc_put_request(req);
 		return ERR_PTR(r);
@@ -444,6 +439,9 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,

 	req->r_file_layout = *layout;  /* keep a copy */

+	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, bno);
+	req->r_oid_len = strlen(req->r_oid);
+
 	/* in case it differs from natural (file) alignment that
 	   calc_layout filled in for us */
 	req->r_num_pages = calc_pages_for(page_align, *plen);
-- 
1.7.9.5

