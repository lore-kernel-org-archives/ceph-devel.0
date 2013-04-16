From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/7] libceph: clean up osd data field access functions
Date: Mon, 15 Apr 2013 22:37:47 -0500
Message-ID: <516CC78B.9000608@inktank.com>
References: <516CC6E4.6070307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:39885 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DPDhu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 23:37:50 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so47006iah.17
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 20:37:48 -0700 (PDT)
In-Reply-To: <516CC6E4.6070307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are a bunch of functions defined to encapsulate getting the
address of a data field for a particular op in an osd request.
They're all defined the same way, so create a macro to take the
place of all of them.

Two of these are used outside the osd client code, so preserve them
(but convert them to use the new macro internally).  Stop exporting
the ones that aren't used elsewhere.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   48
+++++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b76e416..104353a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -115,43 +115,25 @@ static void ceph_osd_data_bio_init(struct
ceph_osd_data *osd_data,
 }
 #endif /* CONFIG_BLOCK */

+#define osd_req_op_data(oreq, whch, typ, fld)	\
+	({						\
+		BUG_ON(whch >= (oreq)->r_num_ops);	\
+		&(oreq)->r_ops[whch].typ.fld;		\
+	})
+
 struct ceph_osd_data *
 osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
 			unsigned int which)
 {
-	BUG_ON(which >= osd_req->r_num_ops);
-
-	return &osd_req->r_ops[which].extent.osd_data;
+	return osd_req_op_data(osd_req, which, extent, osd_data);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data);

 struct ceph_osd_data *
-osd_req_op_cls_request_info(struct ceph_osd_request *osd_req,
-			unsigned int which)
-{
-	BUG_ON(which >= osd_req->r_num_ops);
-
-	return &osd_req->r_ops[which].cls.request_info;
-}
-EXPORT_SYMBOL(osd_req_op_cls_request_info);	/* ??? */
-
-struct ceph_osd_data *
-osd_req_op_cls_request_data(struct ceph_osd_request *osd_req,
-			unsigned int which)
-{
-	BUG_ON(which >= osd_req->r_num_ops);
-
-	return &osd_req->r_ops[which].cls.request_data;
-}
-EXPORT_SYMBOL(osd_req_op_cls_request_data);	/* ??? */
-
-struct ceph_osd_data *
 osd_req_op_cls_response_data(struct ceph_osd_request *osd_req,
 			unsigned int which)
 {
-	BUG_ON(which >= osd_req->r_num_ops);
-
-	return &osd_req->r_ops[which].cls.response_data;
+	return osd_req_op_data(osd_req, which, cls, response_data);
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_data);	/* ??? */

@@ -162,7 +144,7 @@ void osd_req_op_extent_osd_data_pages(struct
ceph_osd_request *osd_req,
 {
 	struct ceph_osd_data *osd_data;

-	osd_data = osd_req_op_extent_osd_data(osd_req, which);
+	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
 	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
 				pages_from_pool, own_pages);
 }
@@ -173,7 +155,7 @@ void osd_req_op_extent_osd_data_pagelist(struct
ceph_osd_request *osd_req,
 {
 	struct ceph_osd_data *osd_data;

-	osd_data = osd_req_op_extent_osd_data(osd_req, which);
+	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_pagelist);
@@ -183,7 +165,8 @@ void osd_req_op_extent_osd_data_bio(struct
ceph_osd_request *osd_req,
 			unsigned int which, struct bio *bio, size_t bio_length)
 {
 	struct ceph_osd_data *osd_data;
-	osd_data = osd_req_op_extent_osd_data(osd_req, which);
+
+	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
 	ceph_osd_data_bio_init(osd_data, bio, bio_length);
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_bio);
@@ -195,7 +178,7 @@ static void osd_req_op_cls_request_info_pagelist(
 {
 	struct ceph_osd_data *osd_data;

-	osd_data = osd_req_op_cls_request_info(osd_req, which);
+	osd_data = osd_req_op_data(osd_req, which, cls, request_info);
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
 }

@@ -205,7 +188,7 @@ void osd_req_op_cls_request_data_pagelist(
 {
 	struct ceph_osd_data *osd_data;

-	osd_data = osd_req_op_cls_request_data(osd_req, which);
+	osd_data = osd_req_op_data(osd_req, which, cls, request_data);
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
 }
 EXPORT_SYMBOL(osd_req_op_cls_request_data_pagelist);
@@ -216,7 +199,7 @@ void osd_req_op_cls_response_data_pages(struct
ceph_osd_request *osd_req,
 {
 	struct ceph_osd_data *osd_data;

-	osd_data = osd_req_op_cls_response_data(osd_req, which);
+	osd_data = osd_req_op_data(osd_req, which, cls, response_data);
 	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
 				pages_from_pool, own_pages);
 }
@@ -241,7 +224,6 @@ static u64 ceph_osd_data_length(struct ceph_osd_data
*osd_data)
 	}
 }

-
 static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
 {
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES && osd_data->own_pages) {
-- 
1.7.9.5

