From: Alex Elder <elder@inktank.com>
Subject: [PATCH 04/13] libceph: rename socket callbacks
Date: Wed, 30 May 2012 14:34:36 -0500
Message-ID: <4FC6764C.8030503@inktank.com>
References: <4FC673FC.3060004@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40020 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab2E3Teg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:34:36 -0400
Received: by vbbff1 with SMTP id ff1so123062vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:34:35 -0700 (PDT)
In-Reply-To: <4FC673FC.3060004@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change the names of the three socket callback functions to make it
more obvious they're specifically associated with a connection's
socket (not the ceph connection that uses it).

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |   28 ++++++++++++++--------------
  1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index fe3c2a1..5ad1f0a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -153,46 +153,46 @@ EXPORT_SYMBOL(ceph_msgr_flush);
   */

  /* data available on socket, or listen socket received a connect */
-static void ceph_data_ready(struct sock *sk, int count_unused)
+static void ceph_sock_data_ready(struct sock *sk, int count_unused)
  {
  	struct ceph_connection *con = sk->sk_user_data;

  	if (sk->sk_state != TCP_CLOSE_WAIT) {
-		dout("ceph_data_ready on %p state = %lu, queueing work\n",
+		dout("%s on %p state = %lu, queueing work\n", __func__,
  		     con, con->state);
  		queue_con(con);
  	}
  }

  /* socket has buffer space for writing */
-static void ceph_write_space(struct sock *sk)
+static void ceph_sock_write_space(struct sock *sk)
  {
  	struct ceph_connection *con = sk->sk_user_data;

  	/* only queue to workqueue if there is data we want to write,
  	 * and there is sufficient space in the socket buffer to accept
-	 * more data.  clear SOCK_NOSPACE so that ceph_write_space()
+	 * more data.  clear SOCK_NOSPACE so that ceph_sock_write_space()
  	 * doesn't get called again until try_write() fills the socket
  	 * buffer. See net/ipv4/tcp_input.c:tcp_check_space()
  	 * and net/core/stream.c:sk_stream_write_space().
  	 */
  	if (test_bit(WRITE_PENDING, &con->state)) {
  		if (sk_stream_wspace(sk) >= sk_stream_min_wspace(sk)) {
-			dout("ceph_write_space %p queueing write work\n", con);
+			dout("%s %p queueing write work\n", __func__, con);
  			clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
  			queue_con(con);
  		}
  	} else {
-		dout("ceph_write_space %p nothing to write\n", con);
+		dout("%s %p nothing to write\n", __func__, con);
  	}
  }

  /* socket's state has changed */
-static void ceph_state_change(struct sock *sk)
+static void ceph_sock_state_change(struct sock *sk)
  {
  	struct ceph_connection *con = sk->sk_user_data;

-	dout("ceph_state_change %p state = %lu sk_state = %u\n",
+	dout("%s %p state = %lu sk_state = %u\n", __func__,
  	     con, con->state, sk->sk_state);

  	if (test_bit(CLOSED, &con->state))
@@ -200,9 +200,9 @@ static void ceph_state_change(struct sock *sk)

  	switch (sk->sk_state) {
  	case TCP_CLOSE:
-		dout("ceph_state_change TCP_CLOSE\n");
+		dout("%s TCP_CLOSE\n", __func__);
  	case TCP_CLOSE_WAIT:
-		dout("ceph_state_change TCP_CLOSE_WAIT\n");
+		dout("%s TCP_CLOSE_WAIT\n", __func__);
  		if (test_and_set_bit(SOCK_CLOSED, &con->state) == 0) {
  			if (test_bit(CONNECTING, &con->state))
  				con->error_msg = "connection failed";
@@ -212,7 +212,7 @@ static void ceph_state_change(struct sock *sk)
  		}
  		break;
  	case TCP_ESTABLISHED:
-		dout("ceph_state_change TCP_ESTABLISHED\n");
+		dout("%s TCP_ESTABLISHED\n", __func__);
  		queue_con(con);
  		break;
  	default:	/* Everything else is uninteresting */
@@ -228,9 +228,9 @@ static void set_sock_callbacks(struct socket *sock,
  {
  	struct sock *sk = sock->sk;
  	sk->sk_user_data = con;
-	sk->sk_data_ready = ceph_data_ready;
-	sk->sk_write_space = ceph_write_space;
-	sk->sk_state_change = ceph_state_change;
+	sk->sk_data_ready = ceph_sock_data_ready;
+	sk->sk_write_space = ceph_sock_write_space;
+	sk->sk_state_change = ceph_sock_state_change;
  }


-- 
1.7.5.4

