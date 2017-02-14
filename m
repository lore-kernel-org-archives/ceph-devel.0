From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 05/15] libceph: pass reply buffer length through ceph_osdc_call()
Date: Tue, 14 Feb 2017 21:11:54 +0100
Message-ID: <1487103124-2974-6-git-send-email-idryomov@gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35879 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754953AbdBNUMk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 15:12:40 -0500
Received: by mail-qt0-f195.google.com with SMTP id h53so18733528qth.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 12:12:40 -0800 (PST)
In-Reply-To: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@ieee.org>

To spare checking for "this reply fits into a page, but does it fit
into my buffer?" in some callers, osd_req_op_cls_response_data_pages()
needs to know how big it is.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/cls_lock_client.c | 2 +-
 net/ceph/osd_client.c      | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 50f040fdb2a9..f13a1ea87459 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -278,7 +278,7 @@ int ceph_cls_lock_info(struct ceph_osd_client *osdc,
 	int get_info_op_buf_size;
 	int name_len = strlen(lock_name);
 	struct page *get_info_op_page, *reply_page;
-	size_t reply_len;
+	size_t reply_len = PAGE_SIZE;
 	void *p, *end;
 	int ret;
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 3a2417bb6ff0..ac4753421d0c 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4023,7 +4023,7 @@ EXPORT_SYMBOL(ceph_osdc_maybe_request_map);
  * Execute an OSD class method on an object.
  *
  * @flags: CEPH_OSD_FLAG_*
- * @resp_len: out param for reply length
+ * @resp_len: in/out param for reply length
  */
 int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   struct ceph_object_id *oid,
@@ -4036,6 +4036,9 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 	struct ceph_osd_request *req;
 	int ret;
 
+	if (req_len > PAGE_SIZE || (resp_page && *resp_len > PAGE_SIZE))
+		return -E2BIG;
+
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
 	if (!req)
 		return -ENOMEM;
@@ -4054,7 +4057,7 @@ int ceph_osdc_call(struct ceph_osd_client *osdc,
 						  0, false, false);
 	if (resp_page)
 		osd_req_op_cls_response_data_pages(req, 0, &resp_page,
-						   PAGE_SIZE, 0, false, false);
+						   *resp_len, 0, false, false);
 
 	ceph_osdc_start_request(osdc, req, false);
 	ret = ceph_osdc_wait_request(osdc, req);
-- 
2.4.3

