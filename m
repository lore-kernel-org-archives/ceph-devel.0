From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/4] libceph: introduce ceph_osdc_cancel_request()
Date: Fri, 20 Jun 2014 13:09:41 +0400
Message-ID: <1403255383-5729-3-git-send-email-ilya.dryomov@inktank.com>
References: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:61513 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965376AbaFTJJx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jun 2014 05:09:53 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so2221100lab.9
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jun 2014 02:09:51 -0700 (PDT)
Received: from localhost ([109.110.66.173])
        by mx.google.com with ESMTPSA id an10sm3395090lac.4.2014.06.20.02.09.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 02:09:51 -0700 (PDT)
In-Reply-To: <1403255383-5729-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Introduce ceph_osdc_cancel_request() intended for canceling requests
from the higher layers (rbd and cephfs).  Because higher layers are in
charge and are supposed to know what and when they are canceling, the
request is not completed, only unref'ed and removed from the libceph
data structures.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osd_client.h |    1 +
 net/ceph/osd_client.c           |   25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 94ec69672164..8ba70a213d97 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -341,6 +341,7 @@ static inline void ceph_osdc_put_request(struct ceph_osd_request *req)
 extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
 				   struct ceph_osd_request *req,
 				   bool nofail);
+extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
 extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
 				  struct ceph_osd_request *req);
 extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6b8c5e8c49ce..318d1c55485d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2431,6 +2431,24 @@ int ceph_osdc_start_request(struct ceph_osd_client *osdc,
 EXPORT_SYMBOL(ceph_osdc_start_request);
 
 /*
+ * Unregister a registered request.  The request is not completed (i.e.
+ * no callbacks or wakeups) - higher layers are supposed to know what
+ * they are canceling.
+ */
+void ceph_osdc_cancel_request(struct ceph_osd_request *req)
+{
+	struct ceph_osd_client *osdc = req->r_osdc;
+
+	mutex_lock(&osdc->request_mutex);
+	__cancel_request(req);
+	__unregister_request(osdc, req);
+	mutex_unlock(&osdc->request_mutex);
+
+	dout("%s tid %llu canceled\n", __func__, req->r_tid);
+}
+EXPORT_SYMBOL(ceph_osdc_cancel_request);
+
+/*
  * wait for a request to complete
  */
 int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
@@ -2440,12 +2458,9 @@ int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
 
 	rc = wait_for_completion_interruptible(&req->r_completion);
 	if (rc < 0) {
-		mutex_lock(&osdc->request_mutex);
-		__cancel_request(req);
-		__unregister_request(osdc, req);
-		mutex_unlock(&osdc->request_mutex);
+		dout("%s tid %llu interrupted\n", __func__, req->r_tid);
+		ceph_osdc_cancel_request(req);
 		complete_request(req);
-		dout("wait_request tid %llu canceled/timed out\n", req->r_tid);
 		return rc;
 	}
 
-- 
1.7.10.4

