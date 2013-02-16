From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] libceph: lock outside send_queued()
Date: Sat, 16 Feb 2013 10:34:18 -0600
Message-ID: <511FB50A.6090604@inktank.com>
References: <511FB4D9.7050009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:58142 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab3BPQeV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:34:21 -0500
Received: by mail-qa0-f48.google.com with SMTP id j8so735045qah.0
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:34:20 -0800 (PST)
In-Reply-To: <511FB4D9.7050009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Two of the three callers of the osd client's send_queued() function
already hold the osd client mutex and drop it before the call.

Change send_queued() so it assumes the caller holds the mutex, and
update all callers accordingly.  Rename it __send_queued() to match
the convention used elsewhere in the file with respect to the lock.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d3e7513..edda070 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -23,7 +23,7 @@

 static const struct ceph_connection_operations osd_con_ops;

-static void send_queued(struct ceph_osd_client *osdc);
+static void __send_queued(struct ceph_osd_client *osdc);
 static int __reset_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd);
 static void __register_request(struct ceph_osd_client *osdc,
 			       struct ceph_osd_request *req);
@@ -554,8 +554,8 @@ static void osd_reset(struct ceph_connection *con)
 	down_read(&osdc->map_sem);
 	mutex_lock(&osdc->request_mutex);
 	__kick_osd_requests(osdc, osd);
+	__send_queued(osdc);
 	mutex_unlock(&osdc->request_mutex);
-	send_queued(osdc);
 	up_read(&osdc->map_sem);
 }

@@ -997,16 +997,13 @@ static void __send_request(struct ceph_osd_client
*osdc,
 /*
  * Send any requests in the queue (req_unsent).
  */
-static void send_queued(struct ceph_osd_client *osdc)
+static void __send_queued(struct ceph_osd_client *osdc)
 {
 	struct ceph_osd_request *req, *tmp;

-	dout("send_queued\n");
-	mutex_lock(&osdc->request_mutex);
-	list_for_each_entry_safe(req, tmp, &osdc->req_unsent, r_req_lru_item) {
+	dout("__send_queued\n");
+	list_for_each_entry_safe(req, tmp, &osdc->req_unsent, r_req_lru_item)
 		__send_request(osdc, req);
-	}
-	mutex_unlock(&osdc->request_mutex);
 }

 /*
@@ -1058,8 +1055,8 @@ static void handle_timeout(struct work_struct *work)
 	}

 	__schedule_osd_timeout(osdc);
+	__send_queued(osdc);
 	mutex_unlock(&osdc->request_mutex);
-	send_queued(osdc);
 	up_read(&osdc->map_sem);
 }

@@ -1397,7 +1394,9 @@ done:
 	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
 		ceph_monc_request_next_osdmap(&osdc->client->monc);

-	send_queued(osdc);
+	mutex_lock(&osdc->request_mutex);
+	__send_queued(osdc);
+	mutex_unlock(&osdc->request_mutex);
 	up_read(&osdc->map_sem);
 	wake_up_all(&osdc->client->auth_wq);
 	return;
-- 
1.7.9.5

