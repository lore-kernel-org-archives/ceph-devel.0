From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/9] rbd: remove linger unconditionally
Date: Thu, 13 Dec 2012 11:02:24 -0600
Message-ID: <50CA0A20.4000502@inktank.com>
References: <50CA0915.1090801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40865 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab2LMRC1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 12:02:27 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2164086iay.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:02:27 -0800 (PST)
In-Reply-To: <50CA0915.1090801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In __unregister_linger_request(), the request is being removed
from the osd client's req_linger list only when the request
has a non-null osd pointer.  It should be done whether or not
the request currently has an osd.

This is most likely a non-issue because I believe the request
will always have an osd when this function is called.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 470816c..b15b475 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -907,8 +907,8 @@ static void __unregister_linger_request(struct
ceph_osd_client *osdc,
 					struct ceph_osd_request *req)
 {
 	dout("__unregister_linger_request %p\n", req);
+	list_del_init(&req->r_linger_item);
 	if (req->r_osd) {
-		list_del_init(&req->r_linger_item);
 		list_del_init(&req->r_linger_osd);

 		if (list_empty(&req->r_osd->o_requests) &&
-- 
1.7.9.5

