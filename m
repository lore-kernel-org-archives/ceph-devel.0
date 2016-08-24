From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 03/16] libceph: add ceph_osdc_call() single-page helper
Date: Wed, 24 Aug 2016 15:18:27 +0200
Message-ID: <1472044720-29116-4-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33011 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755202AbcHXNew (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:34:52 -0400
Received: by mail-yw0-f196.google.com with SMTP id z8so812632ywa.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:34:51 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.18.54
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:18:54 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Douglas Fuller <dfuller@redhat.com>

Add a convenience function to osd_client to send Ceph OSD
'class' ops. The interface assumes that the request and
reply data each consist of single pages.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/osd_client.h |  8 +++++++
 net/ceph/osd_client.c           | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 19821a191732..96337b15a60d 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -397,6 +397,14 @@ extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
 extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc);
 void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc);
 
+int ceph_osdc_call(struct ceph_osd_client *osdc,
+		   struct ceph_object_id *oid,
+		   struct ceph_object_locator *oloc,
+		   const char *class, const char *method,
+		   unsigned int flags,
+		   struct page *req_page, size_t req_len,
+		   struct page *resp_page, size_t *resp_len);
+
 extern int ceph_osdc_readpages(struct ceph_osd_client *osdc,
 			       struct ceph_vino vino,
 			       struct ceph_file_layout *layout,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index dd51ec8ce97f..fbc6b7090c65 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4027,6 +4027,57 @@ void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc)
 EXPORT_SYMBOL(ceph_osdc_maybe_request_map);
 
 /*
+ * Execute an OSD class method on an object.
+ *
+ * @flags: CEPH_OSD_FLAG_*
+ * @resp_len: out param for reply length
+ */
+int ceph_osdc_call(struct ceph_osd_client *osdc,
+		   struct ceph_object_id *oid,
+		   struct ceph_object_locator *oloc,
+		   const char *class, const char *method,
+		   unsigned int flags,
+		   struct page *req_page, size_t req_len,
+		   struct page *resp_page, size_t *resp_len)
+{
+	struct ceph_osd_request *req;
+	int ret;
+
+	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
+	if (!req)
+		return -ENOMEM;
+
+	ceph_oid_copy(&req->r_base_oid, oid);
+	ceph_oloc_copy(&req->r_base_oloc, oloc);
+	req->r_flags = flags;
+
+	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
+	if (ret)
+		goto out_put_req;
+
+	osd_req_op_cls_init(req, 0, CEPH_OSD_OP_CALL, class, method);
+	if (req_page)
+		osd_req_op_cls_request_data_pages(req, 0, &req_page, req_len,
+						  0, false, false);
+	if (resp_page)
+		osd_req_op_cls_response_data_pages(req, 0, &resp_page,
+						   PAGE_SIZE, 0, false, false);
+
+	ceph_osdc_start_request(osdc, req, false);
+	ret = ceph_osdc_wait_request(osdc, req);
+	if (ret >= 0) {
+		ret = req->r_ops[0].rval;
+		if (resp_page)
+			*resp_len = req->r_ops[0].outdata_len;
+	}
+
+out_put_req:
+	ceph_osdc_put_request(req);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_osdc_call);
+
+/*
  * init, shutdown
  */
 int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
-- 
2.4.3

