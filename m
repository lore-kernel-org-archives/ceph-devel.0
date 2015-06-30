From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH RFC 4/6] osd_client: added single object method call
Date: Tue, 30 Jun 2015 13:27:59 -0700
Message-ID: <06080d26bb1873f93d602df947772614551768e9.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48464 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429AbbF3U35 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 16:29:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 49088BACD8
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 20:29:57 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5UKTrtl018417
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 16:29:57 -0400
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add a convenience function to osd_client to call class ops. The interface
assumes that request and reply data each consist of single pages.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 include/linux/ceph/osd_client.h |  6 ++++++
 net/ceph/osd_client.c           | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 7fbbd22..40561ff 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -362,6 +362,12 @@ extern struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *,
 				      u32 truncate_seq, u64 truncate_size,
 				      bool use_mempool);
 
+extern int ceph_osd_op_cls_call(struct ceph_osd_client *osdc, int poolid,
+				char *obj_name, char *class, char *method,
+				int flags, struct page **req_data,
+				size_t req_len, struct page **resp_data,
+				size_t *resp_len);
+
 extern void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
 					 struct ceph_osd_request *req);
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index da451eb..9db3657 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -898,6 +898,50 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 }
 EXPORT_SYMBOL(ceph_osdc_new_request);
 
+int ceph_osd_op_cls_call(struct ceph_osd_client *osdc, int poolid,
+			 char *obj_name, char *class, char *method, int flags,
+			 struct page **req_data, size_t req_len,
+			 struct page **resp_data, size_t *resp_len)
+{
+	struct ceph_osd_request *osd_req;
+	int ret = -ENOMEM;
+	struct timespec tm = CURRENT_TIME;
+
+	osd_req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
+	if (!osd_req)
+		return ret;
+	osd_req->r_flags = flags;
+	osd_req->r_base_oloc.pool = poolid;
+	ceph_oid_set_name(&osd_req->r_base_oid, obj_name);
+	osd_req_op_cls_init(osd_req, 0, CEPH_OSD_OP_CALL, class, method);
+
+	if (req_data)
+		osd_req_op_cls_request_data_pages(osd_req, 0, req_data,
+						  req_len, 0, false, false);
+	if (resp_data)
+		osd_req_op_cls_response_data_pages(osd_req, 0, resp_data,
+						   PAGE_SIZE, 0, false, false);
+
+	ceph_osdc_build_request(osd_req, 0, NULL, CEPH_NOSNAP, &tm);
+
+	ret = ceph_osdc_start_request(osdc, osd_req, false);
+	if (ret)
+		goto out;
+
+	ret = ceph_osdc_wait_request(osdc, osd_req);
+	if (ret < 0)
+		goto out;
+
+	if (resp_data)
+		*resp_len = osd_req->r_reply_op_len[0];
+
+	ret = osd_req->r_reply_op_result[0];
+out:
+	ceph_osdc_put_request(osd_req);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_osd_op_cls_call);
+
 /*
  * We keep osd requests in an rbtree, sorted by ->r_tid.
  */
-- 
1.9.3

