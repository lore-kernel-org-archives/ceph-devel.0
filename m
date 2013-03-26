From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/6] libceph: keep request lists in tid order
Date: Mon, 25 Mar 2013 21:27:56 -0500
Message-ID: <515107AC.5090407@inktank.com>
References: <5151071C.3000309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:51138 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab3CZC16 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 22:27:58 -0400
Received: by mail-ie0-f179.google.com with SMTP id k11so8299343iea.10
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 19:27:58 -0700 (PDT)
In-Reply-To: <5151071C.3000309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In __map_request(), when adding a request to an osd client's unsent
list, add it to the tail rather than the head.  That way the newest
entries (with the highest tid value) will be last.

Maintain an osd's request list in order of increasing tid also.

Finally--to be consistent--maintain an osd client's "notarget" list
in that order as well.

This partially resolves:
    http://tracker.ceph.com/issues/4392

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 707d632..202b9cd 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -606,7 +606,7 @@ static void __kick_osd_requests(struct
ceph_osd_client *osdc,
 		BUG_ON(!list_empty(&req->r_req_lru_item));
 		__register_request(osdc, req);
 		list_add_tail(&req->r_req_lru_item, &osdc->req_unsent);
-		list_add(&req->r_osd_item, &req->r_osd->o_requests);
+		list_add_tail(&req->r_osd_item, &req->r_osd->o_requests);
 		__unregister_linger_request(osdc, req);
 		dout("requeued lingering %p tid %llu osd%d\n", req, req->r_tid,
 		     osd->o_osd);
@@ -1022,10 +1022,10 @@ static int __map_request(struct ceph_osd_client
*osdc,

 	if (req->r_osd) {
 		__remove_osd_from_lru(req->r_osd);
-		list_add(&req->r_osd_item, &req->r_osd->o_requests);
-		list_move(&req->r_req_lru_item, &osdc->req_unsent);
+		list_add_tail(&req->r_osd_item, &req->r_osd->o_requests);
+		list_move_tail(&req->r_req_lru_item, &osdc->req_unsent);
 	} else {
-		list_move(&req->r_req_lru_item, &osdc->req_notarget);
+		list_move_tail(&req->r_req_lru_item, &osdc->req_notarget);
 	}
 	err = 1;   /* osd or pg changed */

-- 
1.7.9.5

