From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH 1/3] ceph: support multiple class method calls in one ceph_msg
Date: Thu, 23 Apr 2015 12:06:31 -0700
Message-ID: <e1c36ea6a73d7c517eb96ad437567cda4de971b8.1429814290.git.dfuller@redhat.com>
References: <cover.1429814290.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030449AbbDWTHD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Apr 2015 15:07:03 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 95CCE8EA30
	for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 19:07:03 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com (vpn-56-33.rdu2.redhat.com [10.10.56.33])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3NJ6vZW006593
	for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 15:07:03 -0400
In-Reply-To: <cover.1429814290.git.dfuller@redhat.com>
In-Reply-To: <cover.1429814290.git.dfuller@redhat.com>
References: <cover.1429814290.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Messages are received from the wire directly into destination buffers.
A short read could result in corruption of the following destination
buffers. Allocate a single message buffer for all class method calls
and split them at the osd_client level. This only applies to ceph_msgs
containing multiple op call and may break support for ceph_msgs
containing a mix of class method calls that return data and other ops.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 include/linux/ceph/osd_client.h |  1 +
 net/ceph/messenger.c            |  4 ++
 net/ceph/osd_client.c           | 92 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 61b19c4..65fcf80 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -99,6 +99,7 @@ struct ceph_osd_req_op {
 			struct ceph_osd_data request_info;
 			struct ceph_osd_data request_data;
 			struct ceph_osd_data response_data;
+			struct ceph_osd_data chain_data;
 			__u8 class_len;
 			__u8 method_len;
 			__u8 argc;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 967080a..ec04be4 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -907,6 +907,10 @@ static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data_cursor *cursor,
 	BUG_ON(!data->pages);
 	BUG_ON(!data->length);
 
+	/*
+	 * bug here if a short read occurs and length < data->length; see
+	 * http://tracker.ceph.com/issues/11424
+	 */
 	cursor->resid = min(length, data->length);
 	page_count = calc_pages_for(data->alignment, (u64)data->length);
 	cursor->page_offset = data->alignment & ~PAGE_MASK;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 41a4abc..3999dfa 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -301,6 +301,73 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
 	}
 }
 
+static int __build_op_cls_chain(struct ceph_osd_request *osd_req)
+{
+	u64 chain_length = 0;
+	u32 chain_pagecount = 0;
+	struct ceph_osd_req_op *op = NULL;
+	struct ceph_osd_data *osd_data;
+	struct ceph_osd_data *chain_data;
+	struct page **pages;
+	int i;
+
+	chain_data = osd_req_op_data(osd_req, 0, cls, chain_data);
+
+	for (i=0; i<osd_req->r_num_ops; i++)
+	{
+		op = &osd_req->r_ops[i];
+		if (op->op != CEPH_OSD_OP_CALL)
+			break;
+
+		osd_data = osd_req_op_data(osd_req, i, cls, chain_data);
+		osd_data->length = 0;
+
+		osd_data = osd_req_op_data(osd_req, i, cls, response_data);
+		chain_length += osd_data->length;
+	}
+
+	chain_data->length = chain_length;
+	chain_pagecount = (u32)calc_pages_for(0, chain_data->length);
+	pages = ceph_alloc_page_vector(chain_pagecount, GFP_KERNEL);
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
+	ceph_osd_data_pages_init(chain_data, pages, chain_length, 0, false, false);
+
+	return 0;
+}
+
+static int __split_cls_op_chain(struct ceph_osd_request *osd_req)
+{
+	int i;
+	void * data;
+	void * p;
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, 0, cls, chain_data);
+
+	if (osd_data->length == 0)
+		return 0;
+
+	data = kzalloc(osd_data->length, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ceph_copy_from_page_vector(osd_data->pages, data, 0, osd_data->length);
+	ceph_osd_data_release(osd_data);
+
+	p = data;
+	for (i = 0; i < osd_req->r_num_ops; i++)
+	{
+		osd_data = osd_req_op_data(osd_req, i, cls, response_data);
+		ceph_copy_to_page_vector(osd_data->pages, p,
+			0, osd_req->r_reply_op_len[i]);
+		p += osd_req->r_reply_op_len[i];
+	}
+
+	kfree(data);
+	return 0;
+}
+
 /*
  * requests
  */
@@ -694,8 +761,20 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 			src->payload_len += data_length;
 			request_data_len += data_length;
 		}
-		osd_data = &src->cls.response_data;
-		ceph_osdc_msg_data_add(req->r_reply, osd_data);
+		if (which == 0)
+		{
+			int err;
+
+			err = __build_op_cls_chain(req);
+			if (err == -ENOMEM)
+			{
+				pr_err("error allocating memory for op chain\n");
+				return 0;
+			}
+			osd_data = &src->cls.chain_data;
+			if (osd_data->length)
+				ceph_osdc_msg_data_add(req->r_reply, osd_data);
+		}
 		break;
 	case CEPH_OSD_OP_STARTSYNC:
 		break;
@@ -1825,6 +1904,15 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 	for (i = 0; i < numops; i++)
 		req->r_reply_op_result[i] = ceph_decode_32(&p);
 
+	if (req->r_ops[0].op == CEPH_OSD_OP_CALL &&
+			req->r_ops[0].cls.chain_data.length)
+	{
+		int err;
+		err = __split_cls_op_chain(req);
+		if (err == -ENOMEM)
+			goto bad_put;
+	}
+
 	if (le16_to_cpu(msg->hdr.version) >= 6) {
 		p += 8 + 4; /* skip replay_version */
 		p += 8; /* skip user_version */
-- 
1.9.3

