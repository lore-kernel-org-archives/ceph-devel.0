From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/9] libceph: drop ceph_osd_request->r_con_filling_msg
Date: Thu, 04 Apr 2013 11:18:32 -0500
Message-ID: <515DA7D8.4070004@inktank.com>
References: <515DA755.2090504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37469 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762890Ab3DDQSe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 12:18:34 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so3266734ieb.31
        for <ceph-devel@vger.kernel.org>; Thu, 04 Apr 2013 09:18:34 -0700 (PDT)
In-Reply-To: <515DA755.2090504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

A field in an osd request keeps track of whether a connection is
currently filling the request's reply message.  This patch gets rid
of that field.

An osd request includes two messages--a request and a reply--and
they're both associated with the connection that existed to its
the target osd at the time the request was created.

An osd request can be dropped early, even when it's in flight.
And at that time both messages are released.  It's possible the
reply message has been supplied to its connection to receive
an incoming response message at the time the osd request gets
dropped.  So ceph_osdc_release_request() revokes that message
from the connection before releasing it so things get cleaned up
properly.

Previously this may have caused a problem, because the connection
that a message was associated with might have gone away before the
revoke request.  And to avoid any problems using that connection,
the osd client held a reference to it when it supplies its response
message.

However since this commit:
    38941f80 libceph: have messages point to their connection
all messages hold a reference to the connection they are associated
with whenever the connection is actively operating on the message
(i.e. while the message is queued to send or sending, and when it
data is being received into it).  And if a message has no connection
associated with it, ceph_msg_revoke_incoming() won't do anything
when asked to revoke it.

As a result, there is no need to keep an additional reference to the
connection associated with a message when we hand the message to the
messenger when it calls our alloc_msg() method to receive something.
If the connection *were* operating on it, it would have its own
reference, and if not, there's no work to be done when we need to
revoke it.

So get rid of the osd request's r_con_filling_msg field.

This resolves:
    http://tracker.ceph.com/issues/4647

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    2 --
 net/ceph/osd_client.c           |   29 +++++------------------------
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 5fd2cbf..3b5ba31 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -89,8 +89,6 @@ struct ceph_osd_request {
 	int              r_pg_osds[CEPH_PG_MAX_SIZE];
 	int              r_num_pg_osds;

-	struct ceph_connection *r_con_filling_msg;
-
 	struct ceph_msg  *r_request, *r_reply;
 	int               r_flags;     /* any additional flags for the osd */
 	u32               r_sent;      /* >0 if r_request is sending/sent */
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ca79cad..e088792 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -91,15 +91,10 @@ void ceph_osdc_release_request(struct kref *kref)

 	if (req->r_request)
 		ceph_msg_put(req->r_request);
-	if (req->r_con_filling_msg) {
-		dout("%s revoking msg %p from con %p\n", __func__,
-		     req->r_reply, req->r_con_filling_msg);
+	if (req->r_reply) {
 		ceph_msg_revoke_incoming(req->r_reply);
-		req->r_con_filling_msg->ops->put(req->r_con_filling_msg);
-		req->r_con_filling_msg = NULL;
-	}
-	if (req->r_reply)
 		ceph_msg_put(req->r_reply);
+	}

 	if (req->r_data_in.type == CEPH_OSD_DATA_TYPE_PAGES &&
 			req->r_data_in.own_pages) {
@@ -1353,16 +1348,6 @@ static void handle_reply(struct ceph_osd_client
*osdc, struct ceph_msg *msg,
 	for (i = 0; i < numops; i++)
 		req->r_reply_op_result[i] = ceph_decode_32(&p);

-	/*
-	 * if this connection filled our message, drop our reference now, to
-	 * avoid a (safe but slower) revoke later.
-	 */
-	if (req->r_con_filling_msg == con && req->r_reply == msg) {
-		dout(" dropping con_filling_msg ref %p\n", con);
-		req->r_con_filling_msg = NULL;
-		con->ops->put(con);
-	}
-
 	if (!req->r_got_reply) {
 		unsigned int bytes;

@@ -2199,13 +2184,10 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 		goto out;
 	}

-	if (req->r_con_filling_msg) {
+	if (req->r_reply->con)
 		dout("%s revoking msg %p from old con %p\n", __func__,
-		     req->r_reply, req->r_con_filling_msg);
-		ceph_msg_revoke_incoming(req->r_reply);
-		req->r_con_filling_msg->ops->put(req->r_con_filling_msg);
-		req->r_con_filling_msg = NULL;
-	}
+		     req->r_reply, req->r_reply->con);
+	ceph_msg_revoke_incoming(req->r_reply);

 	if (front > req->r_reply->front.iov_len) {
 		pr_warning("get_reply front %d > preallocated %d\n",
@@ -2236,7 +2218,6 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 		}
 	}
 	*skip = 0;
-	req->r_con_filling_msg = con->ops->get(con);
 	dout("get_reply tid %lld %p\n", tid, m);

 out:
-- 
1.7.9.5

