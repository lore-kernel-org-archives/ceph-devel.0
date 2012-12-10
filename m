From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: remove linger unconditionally
Date: Sun, 09 Dec 2012 18:37:16 -0600
Message-ID: <50C52EBC.9070701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35835 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab2LJAhT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Dec 2012 19:37:19 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so6950184iea.26
        for <ceph-devel@vger.kernel.org>; Sun, 09 Dec 2012 16:37:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

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
index c018e52..218a97f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -833,8 +833,8 @@ static void __unregister_linger_request(struct
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

