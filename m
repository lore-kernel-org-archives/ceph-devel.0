From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/2] libceph: resend lingering requests with a new tid
Date: Fri,  5 Sep 2014 12:42:46 +0400
Message-ID: <1409906566-5662-3-git-send-email-ilya.dryomov@inktank.com>
References: <1409906566-5662-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:55147 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756351AbaIEImz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Sep 2014 04:42:55 -0400
Received: by mail-we0-f171.google.com with SMTP id u56so11518225wes.16
        for <ceph-devel@vger.kernel.org>; Fri, 05 Sep 2014 01:42:53 -0700 (PDT)
Received: from localhost ([109.110.66.113])
        by mx.google.com with ESMTPSA id dc9sm1227669wib.5.2014.09.05.01.42.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 01:42:52 -0700 (PDT)
In-Reply-To: <1409906566-5662-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Both not yet registered (r_linger && list_empty(&r_linger_item)) and
registered linger requests should use the new tid on resend to avoid
the dup op detection logic on the OSDs, yet we were doing this only for
"registered" case.  Factor out and simplify the "registered" logic and
use the new helper for "not registered" case as well.

Fixes: http://tracker.ceph.com/issues/8806

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |   75 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 20 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 8db10b4a6553..81ee046b24d0 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -30,8 +30,11 @@ static void __send_queued(struct ceph_osd_client *osdc);
 static int __reset_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd);
 static void __register_request(struct ceph_osd_client *osdc,
 			       struct ceph_osd_request *req);
+static void __unregister_request(struct ceph_osd_client *osdc,
+				 struct ceph_osd_request *req);
 static void __unregister_linger_request(struct ceph_osd_client *osdc,
 					struct ceph_osd_request *req);
+static void __enqueue_request(struct ceph_osd_request *req);
 static void __send_request(struct ceph_osd_client *osdc,
 			   struct ceph_osd_request *req);
 
@@ -892,6 +895,39 @@ __lookup_request_ge(struct ceph_osd_client *osdc,
 	return NULL;
 }
 
+static void __kick_linger_request(struct ceph_osd_request *req,
+				  bool lingering)
+{
+	struct ceph_osd_client *osdc = req->r_osdc;
+	struct ceph_osd *osd = req->r_osd;
+
+	/*
+	 * Linger requests need to be resent with a new tid to avoid
+	 * the dup op detection logic on the OSDs.  Achieve this with
+	 * a re-register dance instead of open-coding.
+	 */
+	ceph_osdc_get_request(req);
+	if (!lingering)
+		__unregister_request(osdc, req);
+	else
+		__unregister_linger_request(osdc, req);
+	__register_request(osdc, req);
+	ceph_osdc_put_request(req);
+
+	/*
+	 * Unless request has been registered as both normal and
+	 * lingering, __unregister{,_linger}_request clears r_osd.
+	 * However, here we need to preserve r_osd to make sure we
+	 * requeue on the same OSD.
+	 */
+	WARN_ON(req->r_osd || !osd);
+	req->r_osd = osd;
+
+	dout("requeueing %p tid %llu osd%d lingering=%d\n", req, req->r_tid,
+	     osd->o_osd, lingering);
+	__enqueue_request(req);
+}
+
 /*
  * Resubmit requests pending on the given osd.
  */
@@ -900,12 +936,14 @@ static void __kick_osd_requests(struct ceph_osd_client *osdc,
 {
 	struct ceph_osd_request *req, *nreq;
 	LIST_HEAD(resend);
+	LIST_HEAD(resend_linger);
 	int err;
 
 	dout("__kick_osd_requests osd%d\n", osd->o_osd);
 	err = __reset_osd(osdc, osd);
 	if (err)
 		return;
+
 	/*
 	 * Build up a list of requests to resend by traversing the
 	 * osd's list of requests.  Requests for a given object are
@@ -926,33 +964,30 @@ static void __kick_osd_requests(struct ceph_osd_client *osdc,
 	list_for_each_entry(req, &osd->o_requests, r_osd_item) {
 		if (!req->r_sent)
 			break;
-		list_move_tail(&req->r_req_lru_item, &resend);
-		dout("requeueing %p tid %llu osd%d\n", req, req->r_tid,
-		     osd->o_osd);
-		if (!req->r_linger)
+
+		if (!req->r_linger) {
+			dout("requeueing %p tid %llu osd%d\n", req, req->r_tid,
+			     osd->o_osd);
+			list_move_tail(&req->r_req_lru_item, &resend);
 			req->r_flags |= CEPH_OSD_FLAG_RETRY;
+		} else {
+			list_move_tail(&req->r_req_lru_item, &resend_linger);
+		}
 	}
 	list_splice(&resend, &osdc->req_unsent);
 
 	/*
-	 * Linger requests are re-registered before sending, which
-	 * sets up a new tid for each.  We add them to the unsent
-	 * list at the end to keep things in tid order.
+	 * Both not yet registered and registered linger requests are
+	 * enqueued with a new tid on the same OSD.  We add/move them
+	 * to req_unsent/o_requests at the end to keep things in tid
+	 * order.
 	 */
+	list_for_each_entry_safe(req, nreq, &resend_linger, r_req_lru_item)
+		__kick_linger_request(req, false);
+
 	list_for_each_entry_safe(req, nreq, &osd->o_linger_requests,
-				 r_linger_osd_item) {
-		/*
-		 * reregister request prior to unregistering linger so
-		 * that r_osd is preserved.
-		 */
-		BUG_ON(!list_empty(&req->r_req_lru_item));
-		__register_request(osdc, req);
-		list_add_tail(&req->r_req_lru_item, &osdc->req_unsent);
-		list_add_tail(&req->r_osd_item, &req->r_osd->o_requests);
-		__unregister_linger_request(osdc, req);
-		dout("requeued lingering %p tid %llu osd%d\n", req, req->r_tid,
-		     osd->o_osd);
-	}
+				 r_linger_osd_item)
+		__kick_linger_request(req, true);
 }
 
 /*
-- 
1.7.10.4

