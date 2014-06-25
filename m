From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 08/14] libceph: fix linger request check in __unregister_request()
Date: Wed, 25 Jun 2014 21:16:41 +0400
Message-ID: <1403716607-13535-9-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:46911 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757641AbaFYRRM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:12 -0400
Received: by mail-lb0-f177.google.com with SMTP id u10so2083056lbd.36
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:10 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id tv3sm4208363lbb.49.2014.06.25.10.17.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:17:10 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We should check if request is on the linger request list of any of the
OSDs, not whether request is registered or not.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 12ec553a7e76..8104db24bc09 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1221,7 +1221,7 @@ static void __unregister_request(struct ceph_osd_client *osdc,
 
 		list_del_init(&req->r_osd_item);
 		maybe_move_osd_to_lru(osdc, req->r_osd);
-		if (list_empty(&req->r_linger_item))
+		if (list_empty(&req->r_linger_osd_item))
 			req->r_osd = NULL;
 	}
 
-- 
1.7.10.4

