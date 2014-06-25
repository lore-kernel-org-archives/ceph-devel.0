From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 13/14] libceph: nuke ceph_osdc_unregister_linger_request()
Date: Wed, 25 Jun 2014 21:16:46 +0400
Message-ID: <1403716607-13535-14-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:55352 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757735AbaFYRRZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:25 -0400
Received: by mail-lb0-f178.google.com with SMTP id 10so2100937lbg.9
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:23 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id i1sm4211648lbj.43.2014.06.25.10.17.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:17:22 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Remove now unused ceph_osdc_unregister_linger_request().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osd_client.h |    2 --
 net/ceph/osd_client.c           |   12 ------------
 2 files changed, 14 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index de09cad7b7c7..03aeb27fcc69 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -325,8 +325,6 @@ extern struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *,
 
 extern void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
 					 struct ceph_osd_request *req);
-extern void ceph_osdc_unregister_linger_request(struct ceph_osd_client *osdc,
-						struct ceph_osd_request *req);
 
 extern void ceph_osdc_get_request(struct ceph_osd_request *req);
 extern void ceph_osdc_put_request(struct ceph_osd_request *req);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ef44cc0bbc6a..30f6faf3584f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1281,18 +1281,6 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 	ceph_osdc_put_request(req);
 }
 
-void ceph_osdc_unregister_linger_request(struct ceph_osd_client *osdc,
-					 struct ceph_osd_request *req)
-{
-	mutex_lock(&osdc->request_mutex);
-	if (req->r_linger) {
-		req->r_linger = 0;
-		__unregister_linger_request(osdc, req);
-	}
-	mutex_unlock(&osdc->request_mutex);
-}
-EXPORT_SYMBOL(ceph_osdc_unregister_linger_request);
-
 void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
 				  struct ceph_osd_request *req)
 {
-- 
1.7.10.4

