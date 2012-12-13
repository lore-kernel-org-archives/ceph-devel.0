From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/9] ceph: don't reference req after put
Date: Thu, 13 Dec 2012 11:01:24 -0600
Message-ID: <50CA09E4.4010406@inktank.com>
References: <50CA0915.1090801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56754 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab2LMRBc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 12:01:32 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so4280962ieb.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:01:32 -0800 (PST)
In-Reply-To: <50CA0915.1090801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In __unregister_request(), there is a call to list_del_init()
referencing a request that was the subject of a call to
ceph_osdc_put_request() on the previous line.  This is not
safe, because the request structure could have been freed
by the time we reach the list_del_init().

Fix this by reversing the order of these lines.

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/osd_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7ebfe13..ac7be72 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -871,9 +871,9 @@ static void __unregister_request(struct
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

