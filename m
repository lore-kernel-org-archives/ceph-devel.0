From: Alex Elder <elder@inktank.com>
Subject: [PATCH] ceph: don't reference req after put
Date: Thu, 29 Nov 2012 08:38:48 -0600
Message-ID: <50B77378.1040202@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53541 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab2K2Oiu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 09:38:50 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so12121501iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 06:38:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

In __unregister_request(), there is a call to list_del_init()
referencing a request that was the subject of a call to
ceph_osdc_put_request() on the previous line.  This is not
safe, because the request structure could have been freed
by the time we reach the list_del_init().

Fix this by reversing the order of these lines.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 9b6f0e4..d1177ec 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -797,9 +797,9 @@ static void __unregister_request(struct
ceph_osd_client *osdc,
 			req->r_osd = NULL;
 	}

+	list_del_init(&req->r_req_lru_item);
 	ceph_osdc_put_request(req);

-	list_del_init(&req->r_req_lru_item);
 	if (osdc->num_requests == 0) {
 		dout(" no requests, canceling timeout\n");
 		__cancel_osd_timeout(osdc);
-- 
1.7.9.5

