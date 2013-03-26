From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] libceph: slightly defer registering osd request
Date: Mon, 25 Mar 2013 21:27:11 -0500
Message-ID: <5151077F.10504@inktank.com>
References: <5151071C.3000309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:65157 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab3CZC1O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 22:27:14 -0400
Received: by mail-ia0-f178.google.com with SMTP id r13so4945203iar.37
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 19:27:13 -0700 (PDT)
In-Reply-To: <5151071C.3000309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

One of the first things ceph_osdc_start_request() does is register
the request.  It then acquires the osd client's map semaphore and
request mutex and proceeds to map and send the request.

There is no reason the request has to be registered before acquiring
the map semaphore.  So hold off doing so until after the map
semaphore is held.

Since register_request() is nothing more than a wrapper around
__register_request(), call the latter function instead, after
acquiring the request mutex.

That leaves register_request() unused, so get rid of it.

This partially resolves:
    http://tracker.ceph.com/issues/4392

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7041906..f9276cb 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -831,14 +831,6 @@ static void __register_request(struct
ceph_osd_client *osdc,
 	}
 }

-static void register_request(struct ceph_osd_client *osdc,
-			     struct ceph_osd_request *req)
-{
-	mutex_lock(&osdc->request_mutex);
-	__register_request(osdc, req);
-	mutex_unlock(&osdc->request_mutex);
-}
-
 /*
  * called under osdc->request_mutex
  */
@@ -1785,8 +1777,6 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,
 	ceph_osdc_msg_data_set(req->r_reply, &req->r_data_in);
 	ceph_osdc_msg_data_set(req->r_request, &req->r_data_out);

-	register_request(osdc, req);
-
 	down_read(&osdc->map_sem);
 	mutex_lock(&osdc->request_mutex);
 	/*
@@ -1794,6 +1784,7 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,
 	 * while we dropped request_mutex above, so only send now if
 	 * the request still han't been touched yet.
 	 */
+	__register_request(osdc, req);
 	if (req->r_sent == 0) {
 		rc = __map_request(osdc, req, 0);
 		if (rc < 0) {
-- 
1.7.9.5

