From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: define connection flag helpers
Date: Fri, 22 Feb 2013 11:17:59 -0600
Message-ID: <5127A847.8020000@inktank.com>
References: <5127A7C1.3070609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:54876 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758575Ab3BVRSG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:18:06 -0500
Received: by mail-ie0-f177.google.com with SMTP id 16so988374iea.22
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:18:06 -0800 (PST)
In-Reply-To: <5127A7C1.3070609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Define and use functions that encapsulate operations performed on
a connection's flags.

This resolves:
    http://tracker.ceph.com/issues/4234

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |  107
++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 29 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8a62a55..771d4c9 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -98,6 +98,57 @@
 #define CON_FLAG_SOCK_CLOSED	   3  /* socket state changed to closed */
 #define CON_FLAG_BACKOFF           4  /* need to retry queuing delayed
work */

+static bool con_flag_valid(unsigned long con_flag)
+{
+	switch (con_flag) {
+	case CON_FLAG_LOSSYTX:
+	case CON_FLAG_KEEPALIVE_PENDING:
+	case CON_FLAG_WRITE_PENDING:
+	case CON_FLAG_SOCK_CLOSED:
+	case CON_FLAG_BACKOFF:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void con_flag_clear(struct ceph_connection *con, unsigned long
con_flag)
+{
+	BUG_ON(!con_flag_valid(con_flag));
+
+	clear_bit(con_flag, &con->flags);
+}
+
+static void con_flag_set(struct ceph_connection *con, unsigned long
con_flag)
+{
+	BUG_ON(!con_flag_valid(con_flag));
+
+	set_bit(con_flag, &con->flags);
+}
+
+static bool con_flag_test(struct ceph_connection *con, unsigned long
con_flag)
+{
+	BUG_ON(!con_flag_valid(con_flag));
+
+	return test_bit(con_flag, &con->flags);
+}
+
+static bool con_flag_test_and_clear(struct ceph_connection *con,
+					unsigned long con_flag)
+{
+	BUG_ON(!con_flag_valid(con_flag));
+
+	return test_and_clear_bit(con_flag, &con->flags);
+}
+
+static bool con_flag_test_and_set(struct ceph_connection *con,
+					unsigned long con_flag)
+{
+	BUG_ON(!con_flag_valid(con_flag));
+
+	return test_and_set_bit(con_flag, &con->flags);
+}
+
 /* static tag bytes (protocol control messages) */
 static char tag_msg = CEPH_MSGR_TAG_MSG;
 static char tag_ack = CEPH_MSGR_TAG_ACK;
@@ -309,7 +360,7 @@ static void ceph_sock_write_space(struct sock *sk)
 	 * buffer. See net/ipv4/tcp_input.c:tcp_check_space()
 	 * and net/core/stream.c:sk_stream_write_space().
 	 */
-	if (test_bit(CON_FLAG_WRITE_PENDING, &con->flags)) {
+	if (con_flag_test(con, CON_FLAG_WRITE_PENDING)) {
 		if (sk_stream_wspace(sk) >= sk_stream_min_wspace(sk)) {
 			dout("%s %p queueing write work\n", __func__, con);
 			clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
@@ -334,7 +385,7 @@ static void ceph_sock_state_change(struct sock *sk)
 	case TCP_CLOSE_WAIT:
 		dout("%s TCP_CLOSE_WAIT\n", __func__);
 		con_sock_state_closing(con);
-		set_bit(CON_FLAG_SOCK_CLOSED, &con->flags);
+		con_flag_set(con, CON_FLAG_SOCK_CLOSED);
 		queue_con(con);
 		break;
 	case TCP_ESTABLISHED:
@@ -475,7 +526,7 @@ static int con_close_socket(struct ceph_connection *con)
 	 * received a socket close event before we had the chance to
 	 * shut the socket down.
 	 */
-	clear_bit(CON_FLAG_SOCK_CLOSED, &con->flags);
+	con_flag_clear(con, CON_FLAG_SOCK_CLOSED);

 	con_sock_state_closed(con);
 	return rc;
@@ -539,11 +590,10 @@ void ceph_con_close(struct ceph_connection *con)
 	     ceph_pr_addr(&con->peer_addr.in_addr));
 	con->state = CON_STATE_CLOSED;

-	clear_bit(CON_FLAG_LOSSYTX, &con->flags); /* so we retry next connect */
-	clear_bit(CON_FLAG_KEEPALIVE_PENDING, &con->flags);
-	clear_bit(CON_FLAG_WRITE_PENDING, &con->flags);
-	clear_bit(CON_FLAG_KEEPALIVE_PENDING, &con->flags);
-	clear_bit(CON_FLAG_BACKOFF, &con->flags);
+	con_flag_clear(con, CON_FLAG_LOSSYTX);	/* so we retry next connect */
+	con_flag_clear(con, CON_FLAG_KEEPALIVE_PENDING);
+	con_flag_clear(con, CON_FLAG_WRITE_PENDING);
+	con_flag_clear(con, CON_FLAG_BACKOFF);

 	reset_connection(con);
 	con->peer_global_seq = 0;
@@ -799,7 +849,7 @@ static void prepare_write_message(struct
ceph_connection *con)
 		/* no, queue up footer too and be done */
 		prepare_write_message_footer(con);

-	set_bit(CON_FLAG_WRITE_PENDING, &con->flags);
+	con_flag_set(con, CON_FLAG_WRITE_PENDING);
 }

 /*
@@ -820,7 +870,7 @@ static void prepare_write_ack(struct ceph_connection
*con)
 				&con->out_temp_ack);

 	con->out_more = 1;  /* more will follow.. eventually.. */
-	set_bit(CON_FLAG_WRITE_PENDING, &con->flags);
+	con_flag_set(con, CON_FLAG_WRITE_PENDING);
 }

 /*
@@ -831,7 +881,7 @@ static void prepare_write_keepalive(struct
ceph_connection *con)
 	dout("prepare_write_keepalive %p\n", con);
 	con_out_kvec_reset(con);
 	con_out_kvec_add(con, sizeof (tag_keepalive), &tag_keepalive);
-	set_bit(CON_FLAG_WRITE_PENDING, &con->flags);
+	con_flag_set(con, CON_FLAG_WRITE_PENDING);
 }

 /*
@@ -874,7 +924,7 @@ static void prepare_write_banner(struct
ceph_connection *con)
 					&con->msgr->my_enc_addr);

 	con->out_more = 0;
-	set_bit(CON_FLAG_WRITE_PENDING, &con->flags);
+	con_flag_set(con, CON_FLAG_WRITE_PENDING);
 }

 static int prepare_write_connect(struct ceph_connection *con)
@@ -924,7 +974,7 @@ static int prepare_write_connect(struct
ceph_connection *con)
 					auth->authorizer_buf);

 	con->out_more = 0;
-	set_bit(CON_FLAG_WRITE_PENDING, &con->flags);
+	con_flag_set(con, CON_FLAG_WRITE_PENDING);

 	return 0;
 }
@@ -1644,7 +1694,7 @@ static int process_connect(struct ceph_connection
*con)
 			le32_to_cpu(con->in_reply.connect_seq));

 		if (con->in_reply.flags & CEPH_MSG_CONNECT_LOSSY)
-			set_bit(CON_FLAG_LOSSYTX, &con->flags);
+			con_flag_set(con, CON_FLAG_LOSSYTX);

 		con->delay = 0;      /* reset backoff memory */

@@ -2081,15 +2131,14 @@ do_next:
 			prepare_write_ack(con);
 			goto more;
 		}
-		if (test_and_clear_bit(CON_FLAG_KEEPALIVE_PENDING,
-				       &con->flags)) {
+		if (con_flag_test_and_clear(con, CON_FLAG_KEEPALIVE_PENDING)) {
 			prepare_write_keepalive(con);
 			goto more;
 		}
 	}

 	/* Nothing to do! */
-	clear_bit(CON_FLAG_WRITE_PENDING, &con->flags);
+	con_flag_clear(con, CON_FLAG_WRITE_PENDING);
 	dout("try_write nothing else to write.\n");
 	ret = 0;
 out:
@@ -2269,7 +2318,7 @@ static void queue_con(struct ceph_connection *con)

 static bool con_sock_closed(struct ceph_connection *con)
 {
-	if (!test_and_clear_bit(CON_FLAG_SOCK_CLOSED, &con->flags))
+	if (!con_flag_test_and_clear(con, CON_FLAG_SOCK_CLOSED))
 		return false;

 #define CASE(x)								\
@@ -2310,14 +2359,14 @@ restart:
 	if (con_sock_closed(con))
 		goto fault;

-	if (test_and_clear_bit(CON_FLAG_BACKOFF, &con->flags)) {
+	if (con_flag_test_and_clear(con, CON_FLAG_BACKOFF)) {
 		dout("con_work %p backing off\n", con);
 		ret = queue_con_delay(con, round_jiffies_relative(con->delay));
 		if (ret) {
 			dout("con_work %p FAILED to back off %lu\n", con,
 			     con->delay);
 			BUG_ON(ret == -ENOENT);
-			set_bit(CON_FLAG_BACKOFF, &con->flags);
+			con_flag_set(con, CON_FLAG_BACKOFF);
 		}
 		goto done;
 	}
@@ -2382,7 +2431,7 @@ static void ceph_fault(struct ceph_connection *con)

 	con_close_socket(con);

-	if (test_bit(CON_FLAG_LOSSYTX, &con->flags)) {
+	if (con_flag_test(con, CON_FLAG_LOSSYTX)) {
 		dout("fault on LOSSYTX channel, marking CLOSED\n");
 		con->state = CON_STATE_CLOSED;
 		goto out_unlock;
@@ -2402,9 +2451,9 @@ static void ceph_fault(struct ceph_connection *con)
 	/* If there are no messages queued or keepalive pending, place
 	 * the connection in a STANDBY state */
 	if (list_empty(&con->out_queue) &&
-	    !test_bit(CON_FLAG_KEEPALIVE_PENDING, &con->flags)) {
+	    !con_flag_test(con, CON_FLAG_KEEPALIVE_PENDING)) {
 		dout("fault %p setting STANDBY clearing WRITE_PENDING\n", con);
-		clear_bit(CON_FLAG_WRITE_PENDING, &con->flags);
+		con_flag_clear(con, CON_FLAG_WRITE_PENDING);
 		con->state = CON_STATE_STANDBY;
 	} else {
 		/* retry after a delay. */
@@ -2413,7 +2462,7 @@ static void ceph_fault(struct ceph_connection *con)
 			con->delay = BASE_DELAY_INTERVAL;
 		else if (con->delay < MAX_DELAY_INTERVAL)
 			con->delay *= 2;
-		set_bit(CON_FLAG_BACKOFF, &con->flags);
+		con_flag_set(con, CON_FLAG_BACKOFF);
 		queue_con(con);
 	}

@@ -2470,8 +2519,8 @@ static void clear_standby(struct ceph_connection *con)
 		dout("clear_standby %p and ++connect_seq\n", con);
 		con->state = CON_STATE_PREOPEN;
 		con->connect_seq++;
-		WARN_ON(test_bit(CON_FLAG_WRITE_PENDING, &con->flags));
-		WARN_ON(test_bit(CON_FLAG_KEEPALIVE_PENDING, &con->flags));
+		WARN_ON(con_flag_test(con, CON_FLAG_WRITE_PENDING));
+		WARN_ON(con_flag_test(con, CON_FLAG_KEEPALIVE_PENDING));
 	}
 }

@@ -2512,7 +2561,7 @@ void ceph_con_send(struct ceph_connection *con,
struct ceph_msg *msg)

 	/* if there wasn't anything waiting to send before, queue
 	 * new work */
-	if (test_and_set_bit(CON_FLAG_WRITE_PENDING, &con->flags) == 0)
+	if (con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
 		queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_send);
@@ -2601,8 +2650,8 @@ void ceph_con_keepalive(struct ceph_connection *con)
 	mutex_lock(&con->mutex);
 	clear_standby(con);
 	mutex_unlock(&con->mutex);
-	if (test_and_set_bit(CON_FLAG_KEEPALIVE_PENDING, &con->flags) == 0 &&
-	    test_and_set_bit(CON_FLAG_WRITE_PENDING, &con->flags) == 0)
+	if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
+	    con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
 		queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_keepalive);
-- 
1.7.9.5

