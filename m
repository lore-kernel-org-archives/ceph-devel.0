From: Alex Elder <elder@linaro.org>
Subject: [PATCH 6/7] messenger: encapsulate grabbing incoming message
Date: Mon, 27 Apr 2015 12:13:14 -0500
Message-ID: <1430154795-17123-7-git-send-email-elder@linaro.org>
References: <1430154795-17123-1-git-send-email-elder@linaro.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35629 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964813AbbD0RNZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 13:13:25 -0400
Received: by pabtp1 with SMTP id tp1so135677809pab.2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 10:13:24 -0700 (PDT)
Received: from shibby.corp.google.com ([104.135.1.105])
        by mx.google.com with ESMTPSA id ff10sm12124675pab.13.2015.04.27.10.13.23
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 10:13:23 -0700 (PDT)
In-Reply-To: <1430154795-17123-1-git-send-email-elder@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are currently three places in the messenger code that grab a
connection's incoming message (i.e., get the message--if any--and
and replace the connection's incoming message with a null pointer).

Create a new function ceph_con_in_msg_grab() to encapsulate this
operation, returning what had been the connection's incoming
message.  The connection's reference to the message is transferred
to the caller.  In the new function, test for a few null pointers
before using them, in case of pathological errors.

Do not call BUG_ON() if the message's connection pointer is bad.
Instead, report an error, then drop and ignore the message.  Take
care to use the right connection's "put" operation.

Establish the naming convention that "in_msg" is a pointer to a
message that was a connection's incoming message.  (This affects
some additional code in process_message().)

Signed-off-by: Alex Elder <elder@linaro.org>
---
 net/ceph/messenger.c | 88 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 28 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index a0d2673..ec60c23 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -650,21 +650,55 @@ static void ceph_msg_remove_list(struct list_head *head)
 	}
 }
 
+/*
+ * Grab the given connection's incoming message.
+ */
+static struct ceph_msg *ceph_con_in_msg_grab(struct ceph_connection *con)
+{
+	struct ceph_msg *in_msg;
+	struct ceph_connection *in_msg_con;
+
+	if (!con->in_msg)
+		return NULL;
+
+	/*
+	 * Grab the incoming message and its connection, then update
+	 * their pointers to each other.  The connection's reference
+	 * to the message is transferred to the caller unless there
+	 * is an error.
+	 */
+	in_msg = con->in_msg;
+	con->in_msg = NULL;
+	in_msg_con = in_msg->con;
+	in_msg->con = NULL;
+
+	if (in_msg_con && in_msg->con->ops)
+		in_msg_con->ops->put(in_msg_con);
+
+	if (in_msg_con == con)
+		return in_msg;
+
+	pr_err("incoming message %p with bad connection (%p != %p)\n",
+		in_msg, in_msg_con, con);
+	ceph_msg_put(in_msg);
+
+	return NULL;
+}
+
 static void reset_connection(struct ceph_connection *con)
 {
+	struct ceph_msg *in_msg;
+
 	/* reset connection, out_queue, msg_ and connect_seq */
 	/* discard existing out_queue and msg_seq */
 	dout("reset_connection %p\n", con);
 	ceph_msg_remove_list(&con->out_queue);
 	ceph_msg_remove_list(&con->out_sent);
 
-	if (con->in_msg) {
-		BUG_ON(con->in_msg->con != con);
-		con->in_msg->con = NULL;
-		ceph_msg_put(con->in_msg);
-		con->in_msg = NULL;
-		con->ops->put(con);
-	}
+	/* If there is an incoming message, grab it and release it */
+	in_msg = ceph_con_in_msg_grab(con);
+	if (in_msg)
+		ceph_msg_put(in_msg);
 
 	con->connect_seq = 0;
 	con->out_seq = 0;
@@ -2428,30 +2462,29 @@ static int read_partial_message(struct ceph_connection *con)
  */
 static void process_message(struct ceph_connection *con)
 {
-	struct ceph_msg *msg;
+	struct ceph_msg *in_msg = ceph_con_in_msg_grab(con);
 
-	BUG_ON(con->in_msg->con != con);
-	con->in_msg->con = NULL;
-	msg = con->in_msg;
-	con->in_msg = NULL;
-	con->ops->put(con);
+	if (!in_msg) {
+		pr_err("no message to process");
+		return;
+	}
 
 	/* if first message, set peer_name */
 	if (con->peer_name.type == 0)
-		con->peer_name = msg->hdr.src;
+		con->peer_name = in_msg->hdr.src;
 
 	con->in_seq++;
 	mutex_unlock(&con->mutex);
 
 	dout("===== %p %llu from %s%lld %d=%s len %d+%d (%u %u %u) =====\n",
-	     msg, le64_to_cpu(msg->hdr.seq),
-	     ENTITY_NAME(msg->hdr.src),
-	     le16_to_cpu(msg->hdr.type),
-	     ceph_msg_type_name(le16_to_cpu(msg->hdr.type)),
-	     le32_to_cpu(msg->hdr.front_len),
-	     le32_to_cpu(msg->hdr.data_len),
+	     in_msg, le64_to_cpu(in_msg->hdr.seq),
+	     ENTITY_NAME(in_msg->hdr.src),
+	     le16_to_cpu(in_msg->hdr.type),
+	     ceph_msg_type_name(le16_to_cpu(in_msg->hdr.type)),
+	     le32_to_cpu(in_msg->hdr.front_len),
+	     le32_to_cpu(in_msg->hdr.data_len),
 	     con->in_front_crc, con->in_middle_crc, con->in_data_crc);
-	con->ops->dispatch(con, msg);
+	con->ops->dispatch(con, in_msg);
 
 	mutex_lock(&con->mutex);
 }
@@ -2876,6 +2909,8 @@ static void con_work(struct work_struct *work)
  */
 static void con_fault(struct ceph_connection *con)
 {
+	struct ceph_msg *in_msg;
+
 	dout("fault %p state %lu to peer %s\n",
 	     con, con->state, ceph_pr_addr(&con->peer_addr.in_addr));
 
@@ -2895,13 +2930,10 @@ static void con_fault(struct ceph_connection *con)
 		return;
 	}
 
-	if (con->in_msg) {
-		BUG_ON(con->in_msg->con != con);
-		con->in_msg->con = NULL;
-		ceph_msg_put(con->in_msg);
-		con->in_msg = NULL;
-		con->ops->put(con);
-	}
+	/* If there is an incoming message, grab it and release it */
+	in_msg = ceph_con_in_msg_grab(con);
+	if (in_msg)
+		ceph_msg_put(in_msg);
 
 	/* Requeue anything that hasn't been acked */
 	list_splice_init(&con->out_sent, &con->out_queue);
-- 
2.1.0

