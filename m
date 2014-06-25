From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 02/14] libceph: add maybe_move_osd_to_lru() and switch to it
Date: Wed, 25 Jun 2014 21:16:35 +0400
Message-ID: <1403716607-13535-3-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:50119 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311AbaFYRQ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:16:56 -0400
Received: by mail-lb0-f177.google.com with SMTP id u10so2031043lbd.8
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:16:55 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id jf10sm1810387lac.26.2014.06.25.10.16.53
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:16:54 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Abstract out __move_osd_to_lru() logic from __unregister_request() and
__unregister_linger_request().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d5d2be3bd113..6202923b41ff 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1029,12 +1029,23 @@ static void remove_all_osds(struct ceph_osd_client *osdc)
 static void __move_osd_to_lru(struct ceph_osd_client *osdc,
 			      struct ceph_osd *osd)
 {
-	dout("__move_osd_to_lru %p\n", osd);
+	dout("%s %p\n", __func__, osd);
 	BUG_ON(!list_empty(&osd->o_osd_lru));
+
 	list_add_tail(&osd->o_osd_lru, &osdc->osd_lru);
 	osd->lru_ttl = jiffies + osdc->client->options->osd_idle_ttl * HZ;
 }
 
+static void maybe_move_osd_to_lru(struct ceph_osd_client *osdc,
+				  struct ceph_osd *osd)
+{
+	dout("%s %p\n", __func__, osd);
+
+	if (list_empty(&osd->o_requests) &&
+	    list_empty(&osd->o_linger_requests))
+		__move_osd_to_lru(osdc, osd);
+}
+
 static void __remove_osd_from_lru(struct ceph_osd *osd)
 {
 	dout("__remove_osd_from_lru %p\n", osd);
@@ -1182,11 +1193,7 @@ static void __unregister_request(struct ceph_osd_client *osdc,
 		ceph_msg_revoke(req->r_request);
 
 		list_del_init(&req->r_osd_item);
-		if (list_empty(&req->r_osd->o_requests) &&
-		    list_empty(&req->r_osd->o_linger_requests)) {
-			dout("moving osd to %p lru\n", req->r_osd);
-			__move_osd_to_lru(osdc, req->r_osd);
-		}
+		maybe_move_osd_to_lru(osdc, req->r_osd);
 		if (list_empty(&req->r_linger_item))
 			req->r_osd = NULL;
 	}
@@ -1229,12 +1236,7 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 	list_del_init(&req->r_linger_item);
 	if (req->r_osd) {
 		list_del_init(&req->r_linger_osd_item);
-
-		if (list_empty(&req->r_osd->o_requests) &&
-		    list_empty(&req->r_osd->o_linger_requests)) {
-			dout("moving osd to %p lru\n", req->r_osd);
-			__move_osd_to_lru(osdc, req->r_osd);
-		}
+		maybe_move_osd_to_lru(osdc, req->r_osd);
 		if (list_empty(&req->r_osd_item))
 			req->r_osd = NULL;
 	}
-- 
1.7.10.4

