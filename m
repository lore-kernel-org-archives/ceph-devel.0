From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] libceph: make ceph_con_revoke() a msg operation
Date: Tue, 05 Jun 2012 22:31:49 -0500
Message-ID: <4FCECF25.2070300@inktank.com>
References: <4FCECD7F.9030002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40363 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab2FFDbp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 23:31:45 -0400
Received: by mail-yx0-f174.google.com with SMTP id m10so4637648yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 20:31:45 -0700 (PDT)
In-Reply-To: <4FCECD7F.9030002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

ceph_con_revoke() is passed both a message and a ceph connection.
Now that any message associated with a connection holds a pointer
to that connection, there's no need to provide the connection when
revoking a message.

This has the added benefit of precluding the possibility of the
providing the wrong connection pointer.  If the message's connection
pointer is null, it is not being tracked by any connection, so
revoking it is a no-op.  This is supported as a convenience for
upper layers, so they can revoke a message that is not actually
"in flight."

Rename the function ceph_msg_revoke() to reflect that it is really
an operation on a message, not a connection.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    3 ++-
 net/ceph/messenger.c           |    7 ++++++-
 net/ceph/mon_client.c          |    8 ++++----
 net/ceph/osd_client.c          |    4 ++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 6df837f..9008f81 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -239,7 +239,8 @@ extern void ceph_con_open(struct ceph_connection *con,
 extern bool ceph_con_opened(struct ceph_connection *con);
 extern void ceph_con_close(struct ceph_connection *con);
 extern void ceph_con_send(struct ceph_connection *con, struct ceph_msg
*msg);
-extern void ceph_con_revoke(struct ceph_connection *con, struct
ceph_msg *msg);
+
+extern void ceph_msg_revoke(struct ceph_msg *msg);
 extern void ceph_con_revoke_message(struct ceph_connection *con,
 				  struct ceph_msg *msg);
 extern void ceph_con_keepalive(struct ceph_connection *con);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 336707b..79f3032 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2421,8 +2421,13 @@ EXPORT_SYMBOL(ceph_con_send);
 /*
  * Revoke a message that was previously queued for send
  */
-void ceph_con_revoke(struct ceph_connection *con, struct ceph_msg *msg)
+void ceph_msg_revoke(struct ceph_msg *msg)
 {
+	struct ceph_connection *con = msg->con;
+
+	if (!con)
+		return;		/* Message not in our possession */
+
 	mutex_lock(&con->mutex);
 	if (!list_empty(&msg->list_head)) {
 		dout("%s %p msg %p - was on queue\n", __func__, con, msg);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ab6b24a..cf82e04 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -106,7 +106,7 @@ static void __send_prepared_auth_request(struct
ceph_mon_client *monc, int len)
 	monc->pending_auth = 1;
 	monc->m_auth->front.iov_len = len;
 	monc->m_auth->hdr.front_len = cpu_to_le32(len);
-	ceph_con_revoke(&monc->con, monc->m_auth);
+	ceph_msg_revoke(monc->m_auth);
 	ceph_msg_get(monc->m_auth);  /* keep our ref */
 	ceph_con_send(&monc->con, monc->m_auth);
 }
@@ -117,7 +117,7 @@ static void __send_prepared_auth_request(struct
ceph_mon_client *monc, int len)
 static void __close_session(struct ceph_mon_client *monc)
 {
 	dout("__close_session closing mon%d\n", monc->cur_mon);
-	ceph_con_revoke(&monc->con, monc->m_auth);
+	ceph_msg_revoke(monc->m_auth);
 	ceph_con_close(&monc->con);
 	monc->con.private = NULL;
 	monc->cur_mon = -1;
@@ -229,7 +229,7 @@ static void __send_subscribe(struct ceph_mon_client
*monc)

 		msg->front.iov_len = p - msg->front.iov_base;
 		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
-		ceph_con_revoke(&monc->con, msg);
+		ceph_msg_revoke(msg);
 		ceph_con_send(&monc->con, ceph_msg_get(msg));

 		monc->sub_sent = jiffies | 1;  /* never 0 */
@@ -687,7 +687,7 @@ static void __resend_generic_request(struct
ceph_mon_client *monc)

 	for (p = rb_first(&monc->generic_request_tree); p; p = rb_next(p)) {
 		req = rb_entry(p, struct ceph_mon_generic_request, node);
-		ceph_con_revoke(&monc->con, req->request);
+		ceph_msg_revoke(req->request);
 		ceph_con_send(&monc->con, ceph_msg_get(req->request));
 	}
 }
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 448c9da..403fefb 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -852,7 +852,7 @@ static void __unregister_request(struct
ceph_osd_client *osdc,

 	if (req->r_osd) {
 		/* make sure the original request isn't in flight. */
-		ceph_con_revoke(&req->r_osd->o_con, req->r_request);
+		ceph_msg_revoke(req->r_request);

 		list_del_init(&req->r_osd_item);
 		if (list_empty(&req->r_osd->o_requests) &&
@@ -879,7 +879,7 @@ static void __unregister_request(struct
ceph_osd_client *osdc,
 static void __cancel_request(struct ceph_osd_request *req)
 {
 	if (req->r_sent && req->r_osd) {
-		ceph_con_revoke(&req->r_osd->o_con, req->r_request);
+		ceph_msg_revoke(req->r_request);
 		req->r_sent = 0;
 	}
 }
-- 
1.7.5.4

