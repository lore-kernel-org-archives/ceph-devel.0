From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/6] libceph: verify requests queued in order
Date: Mon, 25 Mar 2013 21:28:25 -0500
Message-ID: <515107C9.2000906@inktank.com>
References: <5151071C.3000309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:49369 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab3CZC21 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 22:28:27 -0400
Received: by mail-ia0-f176.google.com with SMTP id i1so6037504iaa.35
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 19:28:26 -0700 (PDT)
In-Reply-To: <5151071C.3000309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add checking to verify all osd requests for an osd are added to the
queue in order of increasing tid.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 4d98424..b059cf6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -563,6 +563,41 @@ __lookup_request_ge(struct ceph_osd_client *osdc,
 	return NULL;
 }

+#define list_last_entry(ptr, type, member) \
+	list_entry((ptr)->prev, type, member)
+
+/*
+ * Returns true if it's OK to move the given request to the
+ * the osd client's unsent list.  Called before moving the
+ * request to the beginning of the list (prepend == true) or
+ * to the end  (prepend == * false).
+ */
+static bool osdc_unsent_check(struct ceph_osd_client *osdc,
+			struct ceph_osd_request *req,
+			bool prepend)
+{
+	struct ceph_osd_request *list_req;
+	int bad;
+
+	if (list_empty(&osdc->req_unsent))
+		return true;
+
+	if (prepend) {
+		list_req = list_first_entry(&osdc->req_unsent,
+				    struct ceph_osd_request,
+				    r_req_lru_item);
+		bad = WARN_ON(req->r_tid > list_req->r_tid);
+	} else {
+		list_req = list_last_entry(&osdc->req_unsent,
+				    struct ceph_osd_request,
+				    r_req_lru_item);
+		bad = WARN_ON(req->r_tid < list_req->r_tid);
+	}
+	bad = bad || WARN_ON(req->r_tid == list_req->r_tid);
+
+	return !bad;
+}
+
 /*
  * Resubmit requests pending on the given osd.
  */
@@ -585,6 +620,7 @@ static void __kick_osd_requests(struct
ceph_osd_client *osdc,
 	 * in the osd client unsent list in increasing order of tid.
 	 */
 	list_for_each_entry_reverse(req, &osd->o_requests, r_osd_item) {
+		osdc_unsent_check(osdc, req, true);
 		list_move(&req->r_req_lru_item, &osdc->req_unsent);
 		dout("requeued %p tid %llu osd%d\n", req, req->r_tid,
 		     osd->o_osd);
@@ -605,6 +641,7 @@ static void __kick_osd_requests(struct
ceph_osd_client *osdc,
 		 */
 		BUG_ON(!list_empty(&req->r_req_lru_item));
 		__register_request(osdc, req);
+		osdc_unsent_check(osdc, req, false);
 		list_add_tail(&req->r_req_lru_item, &osdc->req_unsent);
 		list_add_tail(&req->r_osd_item, &req->r_osd->o_requests);
 		__unregister_linger_request(osdc, req);
@@ -1023,6 +1060,7 @@ static int __map_request(struct ceph_osd_client *osdc,
 	if (req->r_osd) {
 		__remove_osd_from_lru(req->r_osd);
 		list_add_tail(&req->r_osd_item, &req->r_osd->o_requests);
+		osdc_unsent_check(osdc, req, false);
 		list_move_tail(&req->r_req_lru_item, &osdc->req_unsent);
 	} else {
 		list_move_tail(&req->r_req_lru_item, &osdc->req_notarget);
-- 
1.7.9.5

