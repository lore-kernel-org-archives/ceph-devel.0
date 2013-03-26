From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/6] libceph: no more kick_requests() race
Date: Mon, 25 Mar 2013 21:27:27 -0500
Message-ID: <5151078F.5000509@inktank.com>
References: <5151071C.3000309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:46587 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab3CZC1d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 22:27:33 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so6019479iad.26
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 19:27:32 -0700 (PDT)
In-Reply-To: <5151071C.3000309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Since we no longer drop the request mutex between registering and
mapping an osd request in ceph_osdc_start_request(), there is no
chance of a race with kick_requests().

We can now therefore map and send the new request unconditionally
(but we'll issue a warning should it ever occur).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f9276cb..3723a7f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1779,31 +1779,24 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,

 	down_read(&osdc->map_sem);
 	mutex_lock(&osdc->request_mutex);
-	/*
-	 * a racing kick_requests() may have sent the message for us
-	 * while we dropped request_mutex above, so only send now if
-	 * the request still han't been touched yet.
-	 */
 	__register_request(osdc, req);
-	if (req->r_sent == 0) {
-		rc = __map_request(osdc, req, 0);
-		if (rc < 0) {
-			if (nofail) {
-				dout("osdc_start_request failed map, "
-				     " will retry %lld\n", req->r_tid);
-				rc = 0;
-			}
-			goto out_unlock;
-		}
-		if (req->r_osd == NULL) {
-			dout("send_request %p no up osds in pg\n", req);
-			ceph_monc_request_next_osdmap(&osdc->client->monc);
-		} else {
-			__send_request(osdc, req);
+	WARN_ON(req->r_sent);
+	rc = __map_request(osdc, req, 0);
+	if (rc < 0) {
+		if (nofail) {
+			dout("osdc_start_request failed map, "
+				" will retry %lld\n", req->r_tid);
+			rc = 0;
 		}
-		rc = 0;
+		goto out_unlock;
 	}
-
+	if (req->r_osd == NULL) {
+		dout("send_request %p no up osds in pg\n", req);
+		ceph_monc_request_next_osdmap(&osdc->client->monc);
+	} else {
+		__send_request(osdc, req);
+	}
+	rc = 0;
 out_unlock:
 	mutex_unlock(&osdc->request_mutex);
 	up_read(&osdc->map_sem);
-- 
1.7.9.5

