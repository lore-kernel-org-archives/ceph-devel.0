From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/4] libceph: move r_reply_op_{len,result} into struct ceph_osd_req_op
Date: Wed, 10 Feb 2016 12:24:05 +0100
Message-ID: <1455103447-23559-3-git-send-email-idryomov@gmail.com>
References: <1455103447-23559-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33930 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbcBJLYl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 06:24:41 -0500
Received: by mail-wm0-f67.google.com with SMTP id p63so3529027wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 03:24:41 -0800 (PST)
In-Reply-To: <1455103447-23559-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

From: "Yan, Zheng" <zyan@redhat.com>

This avoids defining large array of r_reply_op_{len,result} in
in struct ceph_osd_request.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c             | 2 +-
 include/linux/ceph/osd_client.h | 5 +++--
 net/ceph/osd_client.c           | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4a876785b68c..94f31bde73e8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1854,7 +1854,7 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 	 * passed to the block layer, which just supports a 32-bit
 	 * length field.
 	 */
-	obj_request->xferred = osd_req->r_reply_op_len[0];
+	obj_request->xferred = osd_req->r_ops[0].outdata_len;
 	rbd_assert(obj_request->xferred < (u64)UINT_MAX);
 
 	opcode = osd_req->r_ops[0].op;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 35c8b006916f..c6d1d603bacf 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -78,6 +78,9 @@ struct ceph_osd_req_op {
 	u16 op;           /* CEPH_OSD_OP_* */
 	u32 flags;        /* CEPH_OSD_OP_FLAG_* */
 	u32 indata_len;   /* request */
+	u32 outdata_len;  /* reply */
+	s32 rval;
+
 	union {
 		struct ceph_osd_data raw_data_in;
 		struct {
@@ -148,8 +151,6 @@ struct ceph_osd_request {
 	struct ceph_eversion *r_request_reassert_version;
 
 	int               r_result;
-	int               r_reply_op_len[CEPH_OSD_MAX_OP];
-	s32               r_reply_op_result[CEPH_OSD_MAX_OP];
 	int               r_got_reply;
 	int		  r_linger;
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 38bdfafe9dd6..d92fd4ad5a66 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1820,7 +1820,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 		int len;
 
 		len = le32_to_cpu(op->payload_len);
-		req->r_reply_op_len[i] = len;
+		req->r_ops[i].outdata_len = len;
 		dout(" op %d has %d bytes\n", i, len);
 		payload_len += len;
 		p += sizeof(*op);
@@ -1835,7 +1835,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	ceph_decode_need(&p, end, 4 + numops * 4, bad_put);
 	retry_attempt = ceph_decode_32(&p);
 	for (i = 0; i < numops; i++)
-		req->r_reply_op_result[i] = ceph_decode_32(&p);
+		req->r_ops[i].rval = ceph_decode_32(&p);
 
 	if (le16_to_cpu(msg->hdr.version) >= 6) {
 		p += 8 + 4; /* skip replay_version */
-- 
2.4.3

