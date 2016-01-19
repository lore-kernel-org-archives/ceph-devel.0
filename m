From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH V2 1/6] libceph: enlarge max number of operations in OSD request
Date: Tue, 19 Jan 2016 16:08:06 +0800
Message-ID: <1453190891-40937-2-git-send-email-zyan@redhat.com>
References: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445AbcASIIe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 03:08:34 -0500
In-Reply-To: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Each operation requires a 'ceph_osd_req_op' structure. To avoid
increasing memory usage of 'struct ceph_osd_request' in ordinary
cases, we dynamically allocate 'ceph_osd_req_op' structures when
number of operations in OSD request are larger than 3

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 include/linux/ceph/osd_client.h |  6 ++++--
 net/ceph/osd_client.c           | 46 +++++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 7506b48..5bf428a 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -43,7 +43,8 @@ struct ceph_osd {
 };
 
 
-#define CEPH_OSD_MAX_OP	3
+#define CEPH_OSD_MAX_OP		16
+#define CEPH_OSD_INITIAL_OP	3
 
 enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE = 0,
@@ -136,7 +137,8 @@ struct ceph_osd_request {
 
 	/* request osd ops array  */
 	unsigned int		r_num_ops;
-	struct ceph_osd_req_op	r_ops[CEPH_OSD_MAX_OP];
+	struct ceph_osd_req_op	*r_ops;
+	struct ceph_osd_req_op	r_inline_ops[CEPH_OSD_INITIAL_OP];
 
 	/* these are updated on each send */
 	__le32           *r_request_osdmap_epoch;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f8f2359..b93752e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -335,12 +335,14 @@ static void ceph_osdc_release_request(struct kref *kref)
 	for (which = 0; which < req->r_num_ops; which++)
 		osd_req_op_data_release(req, which);
 
+	if (req->r_ops != req->r_inline_ops)
+		kfree(req->r_ops);
+
 	ceph_put_snap_context(req->r_snapc);
 	if (req->r_mempool)
 		mempool_free(req, req->r_osdc->req_mempool);
 	else
 		kmem_cache_free(ceph_osd_request_cache, req);
-
 }
 
 void ceph_osdc_get_request(struct ceph_osd_request *req)
@@ -372,16 +374,6 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	BUILD_BUG_ON(CEPH_OSD_MAX_OP > U16_MAX);
 	BUG_ON(num_ops > CEPH_OSD_MAX_OP);
 
-	msg_size = 4 + 4 + 8 + 8 + 4+8;
-	msg_size += 2 + 4 + 8 + 4 + 4; /* oloc */
-	msg_size += 1 + 8 + 4 + 4;     /* pg_t */
-	msg_size += 4 + CEPH_MAX_OID_NAME_LEN; /* oid */
-	msg_size += 2 + num_ops*sizeof(struct ceph_osd_op);
-	msg_size += 8;  /* snapid */
-	msg_size += 8;  /* snap_seq */
-	msg_size += 8 * (snapc ? snapc->num_snaps : 0);  /* snaps */
-	msg_size += 4;
-
 	if (use_mempool) {
 		req = mempool_alloc(osdc->req_mempool, gfp_flags);
 		memset(req, 0, sizeof(*req));
@@ -395,6 +387,17 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	req->r_mempool = use_mempool;
 	req->r_num_ops = num_ops;
 
+	if (num_ops <= CEPH_OSD_INITIAL_OP) {
+		req->r_ops = req->r_inline_ops;
+	} else {
+		BUG_ON(use_mempool);
+		req->r_ops = kzalloc(sizeof(*req->r_ops) * num_ops, gfp_flags);
+		if (!req->r_ops) {
+			ceph_osdc_put_request(req);
+			return NULL;
+		}
+	}
+
 	kref_init(&req->r_kref);
 	init_completion(&req->r_completion);
 	init_completion(&req->r_safe_completion);
@@ -409,11 +412,18 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	req->r_target_oloc.pool = -1;
 
 	/* create reply message */
+	msg_size = OSD_OPREPLY_FRONT_LEN;
+	if (num_ops > CEPH_OSD_INITIAL_OP) {
+		/* ceph_osd_op and op_result */
+		msg_size += (num_ops - CEPH_OSD_INITIAL_OP) *
+			    (sizeof(struct ceph_osd_op) + 4);
+	}
+
 	if (use_mempool)
 		msg = ceph_msgpool_get(&osdc->msgpool_op_reply, 0);
 	else
-		msg = ceph_msg_new(CEPH_MSG_OSD_OPREPLY,
-				   OSD_OPREPLY_FRONT_LEN, gfp_flags, true);
+		msg = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, msg_size,
+				   gfp_flags, true);
 	if (!msg) {
 		ceph_osdc_put_request(req);
 		return NULL;
@@ -421,6 +431,16 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	req->r_reply = msg;
 
 	/* create request message; allow space for oid */
+	msg_size = 4 + 4 + 8 + 8 + 4 + 8;
+	msg_size += 2 + 4 + 8 + 4 + 4; /* oloc */
+	msg_size += 1 + 8 + 4 + 4;     /* pg_t */
+	msg_size += 4 + CEPH_MAX_OID_NAME_LEN; /* oid */
+	msg_size += 2 + num_ops * sizeof(struct ceph_osd_op);
+	msg_size += 8;  /* snapid */
+	msg_size += 8;  /* snap_seq */
+	msg_size += 8 * (snapc ? snapc->num_snaps : 0);  /* snaps */
+	msg_size += 4;
+
 	if (use_mempool)
 		msg = ceph_msgpool_get(&osdc->msgpool_op, 0);
 	else
-- 
2.5.0

