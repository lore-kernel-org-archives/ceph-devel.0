From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/6] libceph: prepend requests in order when kicking
Date: Mon, 25 Mar 2013 21:27:42 -0500
Message-ID: <5151079E.3020108@inktank.com>
References: <5151071C.3000309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:51750 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab3CZC1p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 22:27:45 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so6081502iak.4
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 19:27:44 -0700 (PDT)
In-Reply-To: <5151071C.3000309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The osd expects incoming requests from a given client to arrive in
order, with the tid for each request being greater than the tid for
requests that have already arrived.  This patch fixes one place
the osd client might not maintain that ordering.

For the osd client, the connection fault method is osd_reset().
That function calls __reset_osd() to close and re-open the
connection, then calls __kick_osd_requests() to cause all
outstanding requests for the affected osd to be re-sent after
the connection has been re-established.

When an osd is reset, both in-flight and unsent messages will need
to be re-sent.  An osd client maintains distinct lists for unsent
and in-flight messages.  Meanwhile, an osd maintains a single list
of call its requests (both sent and un-sent).  (Each message is
linked into two lists--one for the osd client and one list for the
osd.)

To process an osd "kick" operation, the osd's request list is
traversed, and each request is moved off whichever osd *client* list
it was on (unsent or sent) and placed onto the osd client's unsent
list.  (It remains where it is on the osd's request list.)

When that is done, osd_reset() calls __send_queued() to cause each
of the osd client's unsent messages to be sent.

OK, with that background...

As the osd request list is traversed each request is prepended to
the osd client's unsent list in the order they're seen.  The effect
of this is to reverse the order of these requests as they are put
(back) onto the unsent list.

Instead, traverse the osd request list in reverse, so their order is
preserved when prepending them to the unsent list.  We still want
to prepend these requests, because they will have lower tids than
any previously-sent request.

Just below that, traverse the linger list in forward order as
before, but add them to the *tail* of the list rather than the head.
These requests get re-registered, and in the process are give a new
(higher) tid, so the should go at the end.

This partially resolves:
    http://tracker.ceph.com/issues/4392

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 3723a7f..707d632 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -577,7 +577,14 @@ static void __kick_osd_requests(struct
ceph_osd_client *osdc,
 	if (err)
 		return;

-	list_for_each_entry(req, &osd->o_requests, r_osd_item) {
+	/*
+	 * Traverse the osd's list of requests in reverse, moving
+	 * each entry from whatever osd client list it's on (unsent
+	 * or in-flight/lru) to the front of the osd client's unsent
+	 * list.  When we're done all the osd's requests will all be
+	 * in the osd client unsent list in increasing order of tid.
+	 */
+	list_for_each_entry_reverse(req, &osd->o_requests, r_osd_item) {
 		list_move(&req->r_req_lru_item, &osdc->req_unsent);
 		dout("requeued %p tid %llu osd%d\n", req, req->r_tid,
 		     osd->o_osd);
@@ -585,6 +592,11 @@ static void __kick_osd_requests(struct
ceph_osd_client *osdc,
 			req->r_flags |= CEPH_OSD_FLAG_RETRY;
 	}

+	/*
+	 * Linger requests are re-registered before sending, which
+	 * sets up a new tid for each.  We add them to the unsent
+	 * list at the end to keep things in tid order.
+	 */
 	list_for_each_entry_safe(req, nreq, &osd->o_linger_requests,
 				 r_linger_osd) {
 		/*
@@ -593,7 +605,7 @@ static void __kick_osd_requests(struct
ceph_osd_client *osdc,
 		 */
 		BUG_ON(!list_empty(&req->r_req_lru_item));
 		__register_request(osdc, req);
-		list_add(&req->r_req_lru_item, &osdc->req_unsent);
+		list_add_tail(&req->r_req_lru_item, &osdc->req_unsent);
 		list_add(&req->r_osd_item, &req->r_osd->o_requests);
 		__unregister_linger_request(osdc, req);
 		dout("requeued lingering %p tid %llu osd%d\n", req, req->r_tid,
-- 
1.7.9.5

