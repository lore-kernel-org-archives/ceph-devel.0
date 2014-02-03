From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/4] libceph: factor out logic from ceph_osdc_start_request()
Date: Mon,  3 Feb 2014 15:47:07 +0200
Message-ID: <1391435228-27874-4-git-send-email-ilya.dryomov@inktank.com>
References: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:41255 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbaBCNrT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 08:47:19 -0500
Received: by mail-we0-f182.google.com with SMTP id u57so2249103wes.27
        for <ceph-devel@vger.kernel.org>; Mon, 03 Feb 2014 05:47:18 -0800 (PST)
Received: from localhost ([109.110.66.110])
        by mx.google.com with ESMTPSA id e18sm26007334wic.4.2014.02.03.05.47.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 05:47:17 -0800 (PST)
In-Reply-To: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Factor out logic from ceph_osdc_start_request() into a new helper,
__ceph_osdc_start_request().  ceph_osdc_start_request() now amounts to
taking locks and calling __ceph_osdc_start_request().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |   62 +++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 166d4c7ba065..2aa82b6bb305 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1427,6 +1427,40 @@ static void __send_queued(struct ceph_osd_client *osdc)
 }
 
 /*
+ * Caller should hold map_sem for read and request_mutex.
+ */
+static int __ceph_osdc_start_request(struct ceph_osd_client *osdc,
+				     struct ceph_osd_request *req,
+				     bool nofail)
+{
+	int rc;
+
+	__register_request(osdc, req);
+	req->r_sent = 0;
+	req->r_got_reply = 0;
+	rc = __map_request(osdc, req, 0);
+	if (rc < 0) {
+		if (nofail) {
+			dout("osdc_start_request failed map, "
+				" will retry %lld\n", req->r_tid);
+			rc = 0;
+		} else {
+			__unregister_request(osdc, req);
+		}
+		return rc;
+	}
+
+	if (req->r_osd == NULL) {
+		dout("send_request %p no up osds in pg\n", req);
+		ceph_monc_request_next_osdmap(&osdc->client->monc);
+	} else {
+		__send_queued(osdc);
+	}
+
+	return 0;
+}
+
+/*
  * Timeout callback, called every N seconds when 1 or more osd
  * requests has been active for more than N seconds.  When this
  * happens, we ping all OSDs with requests who have timed out to
@@ -2351,34 +2385,16 @@ int ceph_osdc_start_request(struct ceph_osd_client *osdc,
 			    struct ceph_osd_request *req,
 			    bool nofail)
 {
-	int rc = 0;
+	int rc;
 
 	down_read(&osdc->map_sem);
 	mutex_lock(&osdc->request_mutex);
-	__register_request(osdc, req);
-	req->r_sent = 0;
-	req->r_got_reply = 0;
-	rc = __map_request(osdc, req, 0);
-	if (rc < 0) {
-		if (nofail) {
-			dout("osdc_start_request failed map, "
-				" will retry %lld\n", req->r_tid);
-			rc = 0;
-		} else {
-			__unregister_request(osdc, req);
-		}
-		goto out_unlock;
-	}
-	if (req->r_osd == NULL) {
-		dout("send_request %p no up osds in pg\n", req);
-		ceph_monc_request_next_osdmap(&osdc->client->monc);
-	} else {
-		__send_queued(osdc);
-	}
-	rc = 0;
-out_unlock:
+
+	rc = __ceph_osdc_start_request(osdc, req, nofail);
+
 	mutex_unlock(&osdc->request_mutex);
 	up_read(&osdc->map_sem);
+
 	return rc;
 }
 EXPORT_SYMBOL(ceph_osdc_start_request);
-- 
1.7.10.4

