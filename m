From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 04/14] libceph: move and add dout()s to ceph_osdc_request_{get,put}()
Date: Wed, 25 Jun 2014 21:16:37 +0400
Message-ID: <1403716607-13535-5-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:40574 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311AbaFYRRB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:01 -0400
Received: by mail-la0-f49.google.com with SMTP id gf5so1000187lab.36
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:00 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id i10sm4222232lbc.16.2014.06.25.10.16.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:16:59 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add dout()s to ceph_osdc_request_{get,put}().  Also move them to .c and
turn kref release callback into a static function.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osd_client.h |   11 ++---------
 net/ceph/osd_client.c           |   26 ++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 7490a03ac163..a8d5652f589d 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -328,15 +328,8 @@ extern void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
 extern void ceph_osdc_unregister_linger_request(struct ceph_osd_client *osdc,
 						struct ceph_osd_request *req);
 
-static inline void ceph_osdc_get_request(struct ceph_osd_request *req)
-{
-	kref_get(&req->r_kref);
-}
-extern void ceph_osdc_release_request(struct kref *kref);
-static inline void ceph_osdc_put_request(struct ceph_osd_request *req)
-{
-	kref_put(&req->r_kref, ceph_osdc_release_request);
-}
+extern void ceph_osdc_get_request(struct ceph_osd_request *req);
+extern void ceph_osdc_put_request(struct ceph_osd_request *req);
 
 extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
 				   struct ceph_osd_request *req,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6202923b41ff..7406046212dc 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -297,12 +297,15 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
 /*
  * requests
  */
-void ceph_osdc_release_request(struct kref *kref)
+static void ceph_osdc_release_request(struct kref *kref)
 {
-	struct ceph_osd_request *req;
+	struct ceph_osd_request *req = container_of(kref,
+					    struct ceph_osd_request, r_kref);
 	unsigned int which;
 
-	req = container_of(kref, struct ceph_osd_request, r_kref);
+	dout("%s %p (r_request %p r_reply %p)\n", __func__, req,
+	     req->r_request, req->r_reply);
+
 	if (req->r_request)
 		ceph_msg_put(req->r_request);
 	if (req->r_reply) {
@@ -320,7 +323,22 @@ void ceph_osdc_release_request(struct kref *kref)
 		kmem_cache_free(ceph_osd_request_cache, req);
 
 }
-EXPORT_SYMBOL(ceph_osdc_release_request);
+
+void ceph_osdc_get_request(struct ceph_osd_request *req)
+{
+	dout("%s %p (was %d)\n", __func__, req,
+	     atomic_read(&req->r_kref.refcount));
+	kref_get(&req->r_kref);
+}
+EXPORT_SYMBOL(ceph_osdc_get_request);
+
+void ceph_osdc_put_request(struct ceph_osd_request *req)
+{
+	dout("%s %p (was %d)\n", __func__, req,
+	     atomic_read(&req->r_kref.refcount));
+	kref_put(&req->r_kref, ceph_osdc_release_request);
+}
+EXPORT_SYMBOL(ceph_osdc_put_request);
 
 struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 					       struct ceph_snap_context *snapc,
-- 
1.7.10.4

