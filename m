From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/2] libceph: abstract out ceph_osd_request enqueue logic
Date: Fri,  5 Sep 2014 12:42:45 +0400
Message-ID: <1409906566-5662-2-git-send-email-ilya.dryomov@inktank.com>
References: <1409906566-5662-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:54231 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335AbaIEImw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Sep 2014 04:42:52 -0400
Received: by mail-we0-f169.google.com with SMTP id k48so11389488wev.14
        for <ceph-devel@vger.kernel.org>; Fri, 05 Sep 2014 01:42:51 -0700 (PDT)
Received: from localhost ([109.110.66.113])
        by mx.google.com with ESMTPSA id lh5sm704876wjb.12.2014.09.05.01.42.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 01:42:50 -0700 (PDT)
In-Reply-To: <1409906566-5662-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Introduce __enqueue_request() and switch to it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 30f6faf3584f..8db10b4a6553 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1346,6 +1346,19 @@ static int __calc_request_pg(struct ceph_osdmap *osdmap,
 				   &req->r_target_oid, pg_out);
 }
 
+static void __enqueue_request(struct ceph_osd_request *req)
+{
+	struct ceph_osd_client *osdc = req->r_osdc;
+
+	if (req->r_osd) {
+		__remove_osd_from_lru(req->r_osd);
+		list_add_tail(&req->r_osd_item, &req->r_osd->o_requests);
+		list_move_tail(&req->r_req_lru_item, &osdc->req_unsent);
+	} else {
+		list_move_tail(&req->r_req_lru_item, &osdc->req_notarget);
+	}
+}
+
 /*
  * Pick an osd (the first 'up' osd in the pg), allocate the osd struct
  * (as needed), and set the request r_osd appropriately.  If there is
@@ -1423,13 +1436,7 @@ static int __map_request(struct ceph_osd_client *osdc,
 			      &osdc->osdmap->osd_addr[o]);
 	}
 
-	if (req->r_osd) {
-		__remove_osd_from_lru(req->r_osd);
-		list_add_tail(&req->r_osd_item, &req->r_osd->o_requests);
-		list_move_tail(&req->r_req_lru_item, &osdc->req_unsent);
-	} else {
-		list_move_tail(&req->r_req_lru_item, &osdc->req_notarget);
-	}
+	__enqueue_request(req);
 	err = 1;   /* osd or pg changed */
 
 out:
-- 
1.7.10.4

