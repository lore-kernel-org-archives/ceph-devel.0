From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH V2 4/6] libceph: add helper that extends numner of operations in OSD request
Date: Tue, 19 Jan 2016 16:08:09 +0800
Message-ID: <1453190891-40937-5-git-send-email-zyan@redhat.com>
References: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60082 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445AbcASIIt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 03:08:49 -0500
In-Reply-To: <1453190891-40937-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

The helper function resizes the r_ops array and re-allocates request
messages.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 include/linux/ceph/osd_client.h |  3 +++
 net/ceph/osd_client.c           | 56 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 9802df1..6430766 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -322,6 +322,9 @@ extern struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *
 					       unsigned int num_ops,
 					       bool use_mempool,
 					       gfp_t gfp_flags);
+extern int ceph_osdc_extend_request(struct ceph_osd_request *req,
+				    unsigned int num_ops, gfp_t gfp_flags);
+
 
 extern void ceph_osdc_build_request(struct ceph_osd_request *req, u64 off,
 				    struct ceph_snap_context *snapc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 9c0cf2e..c9df912 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -361,6 +361,62 @@ void ceph_osdc_put_request(struct ceph_osd_request *req)
 }
 EXPORT_SYMBOL(ceph_osdc_put_request);
 
+int ceph_osdc_extend_request(struct ceph_osd_request *req,
+			     unsigned int num_ops, gfp_t gfp_flags)
+{
+	struct ceph_osd_req_op *new_ops;
+	struct ceph_msg *request_msg;
+	struct ceph_msg *reply_msg = NULL;
+	size_t msg_size;
+
+	if (num_ops > CEPH_OSD_MAX_OP)
+		return -EINVAL;
+
+	if (num_ops <= req->r_max_ops)
+		return 0;
+
+	msg_size = req->r_request->front_alloc_len +
+		   (num_ops - req->r_max_ops) *
+		   sizeof(struct ceph_osd_op);
+	request_msg = ceph_msg_new(CEPH_MSG_OSD_OP, msg_size, gfp_flags, true);
+	if (!request_msg)
+		return -ENOMEM;
+
+	if (num_ops > CEPH_OSD_INITIAL_OP) {
+		msg_size = req->r_reply->front_alloc_len +
+			   (num_ops - req->r_max_ops) *
+			   (sizeof(struct ceph_osd_op) + 4);
+		reply_msg = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, msg_size,
+					 gfp_flags, true);
+		if (!reply_msg)
+			goto out_enomem;
+
+		new_ops = kzalloc(sizeof(*req->r_ops) * num_ops, gfp_flags);
+		if (!new_ops)
+			goto out_enomem;
+
+		memcpy(new_ops, req->r_ops,
+		       sizeof(*req->r_ops) * req->r_num_ops);
+		if (req->r_ops != req->r_inline_ops)
+			kfree(req->r_ops);
+		req->r_ops = new_ops;
+
+		ceph_msg_put(req->r_reply);
+		req->r_reply = reply_msg;
+	}
+
+	ceph_msg_put(req->r_request);
+	req->r_request = request_msg;
+	req->r_max_ops = num_ops;
+	return 0;
+out_enomem:
+	ceph_msg_put(request_msg);
+	if (reply_msg)
+		ceph_msg_put(reply_msg);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(ceph_osdc_extend_request);
+
 struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
 					       unsigned int num_ops,
-- 
2.5.0

