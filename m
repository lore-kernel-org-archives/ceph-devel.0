From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/7] libceph: support raw data requests
Date: Mon, 15 Apr 2013 22:38:03 -0500
Message-ID: <516CC79B.6030606@inktank.com>
References: <516CC6E4.6070307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:62469 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DPDiF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 23:38:05 -0400
Received: by mail-ia0-f181.google.com with SMTP id y25so43882iay.40
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 20:38:04 -0700 (PDT)
In-Reply-To: <516CC6E4.6070307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Allow osd request ops that aren't otherwise structured (not class,
extent, or watch ops) to specify "raw" data to be used to hold
incoming data for the op.  Make use of this capability for the osd
STAT op.

Prefix the name of the private function osd_req_op_init() with "_",
and expose a new function by that (earlier) name whose purpose is to
initialize osd ops with (only) implied data.

For now we'll just support the use of a page array for an osd op
with incoming raw data.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |   10 ++++++++++
 net/ceph/osd_client.c           |   38
++++++++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 26d29cd..7d4fd18 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -83,6 +83,7 @@ struct ceph_osd_req_op {
 	u16 op;           /* CEPH_OSD_OP_* */
 	u32 payload_len;
 	union {
+		struct ceph_osd_data raw_data_in;
 		struct {
 			u64 offset, length;
 			u64 truncate_size;
@@ -230,6 +231,15 @@ extern void ceph_osdc_handle_reply(struct
ceph_osd_client *osdc,
 extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);

+extern void osd_req_op_init(struct ceph_osd_request *osd_req,
+					unsigned int which, u16 opcode);
+
+extern void osd_req_op_raw_data_in_pages(struct ceph_osd_request *,
+					unsigned int which,
+					struct page **pages, u64 length,
+					u32 alignment, bool pages_from_pool,
+					bool own_pages);
+
 extern void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
 					u64 offset, u64 length,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 104353a..74ef9fd 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -121,6 +121,14 @@ static void ceph_osd_data_bio_init(struct
ceph_osd_data *osd_data,
 		&(oreq)->r_ops[whch].typ.fld;		\
 	})

+static struct ceph_osd_data *
+osd_req_op_raw_data_in(struct ceph_osd_request *osd_req, unsigned int
which)
+{
+	BUG_ON(which >= osd_req->r_num_ops);
+
+	return &osd_req->r_ops[which].raw_data_in;
+}
+
 struct ceph_osd_data *
 osd_req_op_extent_osd_data(struct ceph_osd_request *osd_req,
 			unsigned int which)
@@ -137,6 +145,19 @@ osd_req_op_cls_response_data(struct
ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_data);	/* ??? */

+void osd_req_op_raw_data_in_pages(struct ceph_osd_request *osd_req,
+			unsigned int which, struct page **pages,
+			u64 length, u32 alignment,
+			bool pages_from_pool, bool own_pages)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_raw_data_in(osd_req, which);
+	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
+				pages_from_pool, own_pages);
+}
+EXPORT_SYMBOL(osd_req_op_raw_data_in_pages);
+
 void osd_req_op_extent_osd_data_pages(struct ceph_osd_request *osd_req,
 			unsigned int which, struct page **pages,
 			u64 length, u32 alignment,
@@ -437,7 +458,7 @@ static bool osd_req_opcode_valid(u16 opcode)
  * common init routine for all the other init functions, below.
  */
 static struct ceph_osd_req_op *
-osd_req_op_init(struct ceph_osd_request *osd_req, unsigned int which,
+_osd_req_op_init(struct ceph_osd_request *osd_req, unsigned int which,
 				u16 opcode)
 {
 	struct ceph_osd_req_op *op;
@@ -452,12 +473,19 @@ osd_req_op_init(struct ceph_osd_request *osd_req,
unsigned int which,
 	return op;
 }

+void osd_req_op_init(struct ceph_osd_request *osd_req,
+				unsigned int which, u16 opcode)
+{
+	(void)_osd_req_op_init(osd_req, which, opcode);
+}
+EXPORT_SYMBOL(osd_req_op_init);
+
 void osd_req_op_extent_init(struct ceph_osd_request *osd_req,
 				unsigned int which, u16 opcode,
 				u64 offset, u64 length,
 				u64 truncate_size, u32 truncate_seq)
 {
-	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which, opcode);
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
 	size_t payload_len = 0;

 	BUG_ON(opcode != CEPH_OSD_OP_READ && opcode != CEPH_OSD_OP_WRITE);
@@ -495,7 +523,7 @@ EXPORT_SYMBOL(osd_req_op_extent_update);
 void osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int
which,
 			u16 opcode, const char *class, const char *method)
 {
-	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which, opcode);
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
 	struct ceph_pagelist *pagelist;
 	size_t payload_len = 0;
 	size_t size;
@@ -532,7 +560,7 @@ void osd_req_op_watch_init(struct ceph_osd_request
*osd_req,
 				unsigned int which, u16 opcode,
 				u64 cookie, u64 version, int flag)
 {
-	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which, opcode);
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);

 	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY_ACK && opcode != CEPH_OSD_OP_WATCH);

@@ -584,6 +612,8 @@ static u64 osd_req_encode_op(struct ceph_osd_request
*req,

 	switch (src->op) {
 	case CEPH_OSD_OP_STAT:
+		osd_data = &src->raw_data_in;
+		ceph_osdc_msg_data_add(req->r_reply, osd_data);
 		break;
 	case CEPH_OSD_OP_READ:
 	case CEPH_OSD_OP_WRITE:
-- 
1.7.9.5

