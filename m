From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH V2 2/6] libceph: move r_reply_op_{len,result} into struct ceph_osd_req_op
Date: Tue, 19 Jan 2016 16:08:07 +0800
Message-ID: <1453190891-40937-3-git-send-email-zyan@redhat.com>
References: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60068 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445AbcASIIj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 03:08:39 -0500
In-Reply-To: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

This avoids defining large array of r_reply_op_{len,result} in
in 'struct ceph_osd_request'

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 drivers/block/rbd.c             | 2 +-
 include/linux/ceph/osd_client.h | 5 +++--
 net/ceph/osd_client.c           | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4a87678..22cfc01 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1854,7 +1854,7 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 	 * passed to the block layer, which just supports a 32-bit
 	 * length field.
 	 */
-	obj_request->xferred = osd_req->r_reply_op_len[0];
+	obj_request->xferred = osd_req->r_ops[0].reply_op_len;
 	rbd_assert(obj_request->xferred < (u64)UINT_MAX);
 
 	opcode = osd_req->r_ops[0].op;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 5bf428a..fda3a05 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -116,6 +116,9 @@ struct ceph_osd_req_op {
 			u64 expected_write_size;
 		} alloc_hint;
 	};
+	/* reply */
+	int               reply_op_len;
+	s32               reply_op_result;
 };
 
 /* an in-flight request */
@@ -150,8 +153,6 @@ struct ceph_osd_request {
 	struct ceph_eversion *r_request_reassert_version;
 
 	int               r_result;
-	int               r_reply_op_len[CEPH_OSD_MAX_OP];
-	s32               r_reply_op_result[CEPH_OSD_MAX_OP];
 	int               r_got_reply;
 	int		  r_linger;
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b93752e..3852006 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1840,7 +1840,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 		int len;
 
 		len = le32_to_cpu(op->payload_len);
-		req->r_reply_op_len[i] = len;
+		req->r_ops[i].reply_op_len = len;
 		dout(" op %d has %d bytes\n", i, len);
 		payload_len += len;
 		p += sizeof(*op);
@@ -1855,7 +1855,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	ceph_decode_need(&p, end, 4 + numops * 4, bad_put);
 	retry_attempt = ceph_decode_32(&p);
 	for (i = 0; i < numops; i++)
-		req->r_reply_op_result[i] = ceph_decode_32(&p);
+		req->r_ops[i].reply_op_result = ceph_decode_32(&p);
 
 	if (le16_to_cpu(msg->hdr.version) >= 6) {
 		p += 8 + 4; /* skip replay_version */
-- 
2.5.0

