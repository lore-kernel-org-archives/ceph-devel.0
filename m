From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 4/6] libceph: drop osdc from ceph_calc_raw_layout()
Date: Fri, 04 Jan 2013 08:33:59 -0600
Message-ID: <50E6E857.6080608@inktank.com>
References: <50E6E7C2.2020604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48460 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab3ADOeB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 09:34:01 -0500
Received: by mail-ie0-f178.google.com with SMTP id c12so19386669ieb.23
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 06:34:01 -0800 (PST)
In-Reply-To: <50E6E7C2.2020604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The osdc parameter to ceph_calc_raw_layout() is not used, so get rid
of it.  Consequently, the corresponding parameter in calc_layout()
becomes unused, so get rid of that as well.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    2 +-
 include/linux/ceph/osd_client.h |    3 +--
 net/ceph/osd_client.c           |   10 ++++------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 82a1460..09bcf08 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1168,7 +1168,7 @@ static int rbd_do_request(struct request *rq,
 	osd_req->r_oid_len = strlen(osd_req->r_oid);

 	rbd_layout_init(&osd_req->r_file_layout, rbd_dev->spec->pool_id);
-	ret = ceph_calc_raw_layout(osdc, &osd_req->r_file_layout,
+	ret = ceph_calc_raw_layout(&osd_req->r_file_layout,
 				ofs, &len, &bno, osd_req, ops);
 	rbd_assert(ret == 0);

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 0e82a0a..fe3a6e8 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -207,8 +207,7 @@ extern void ceph_osdc_handle_reply(struct
ceph_osd_client *osdc,
 extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);

-extern int ceph_calc_raw_layout(struct ceph_osd_client *osdc,
-			struct ceph_file_layout *layout,
+extern int ceph_calc_raw_layout(struct ceph_file_layout *layout,
 			u64 off, u64 *plen, u64 *bno,
 			struct ceph_osd_request *req,
 			struct ceph_osd_req_op *op);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 75e57de..1b55fbe 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -38,8 +38,7 @@ static int op_has_extent(int op)
 		op == CEPH_OSD_OP_WRITE);
 }

-int ceph_calc_raw_layout(struct ceph_osd_client *osdc,
-			struct ceph_file_layout *layout,
+int ceph_calc_raw_layout(struct ceph_file_layout *layout,
 			u64 off, u64 *plen, u64 *bno,
 			struct ceph_osd_request *req,
 			struct ceph_osd_req_op *op)
@@ -99,8 +98,7 @@ EXPORT_SYMBOL(ceph_calc_raw_layout);
  *
  * fill osd op in request message.
  */
-static int calc_layout(struct ceph_osd_client *osdc,
-		       struct ceph_vino vino,
+static int calc_layout(struct ceph_vino vino,
 		       struct ceph_file_layout *layout,
 		       u64 off, u64 *plen,
 		       struct ceph_osd_request *req,
@@ -109,7 +107,7 @@ static int calc_layout(struct ceph_osd_client *osdc,
 	u64 bno;
 	int r;

-	r = ceph_calc_raw_layout(osdc, layout, off, plen, &bno, req, op);
+	r = ceph_calc_raw_layout(layout, off, plen, &bno, req, op);
 	if (r < 0)
 		return r;

@@ -444,7 +442,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 		return ERR_PTR(-ENOMEM);

 	/* calculate max write size */
-	r = calc_layout(osdc, vino, layout, off, plen, req, ops);
+	r = calc_layout(vino, layout, off, plen, req, ops);
 	if (r < 0)
 		return ERR_PTR(r);
 	req->r_file_layout = *layout;  /* keep a copy */
-- 
1.7.9.5

