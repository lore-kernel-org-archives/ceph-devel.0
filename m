From: Alex Elder <elder@inktank.com>
Subject: [PATCH 09/12] libceph: distinguish two phases of connect sequence
Date: Thu, 21 Jun 2012 09:22:32 -0500
Message-ID: <4FE32E28.8030006@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:52957 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078Ab2FUOWe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:22:34 -0400
Received: by ghrr11 with SMTP id r11so499988ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:22:33 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently a ceph connection enters a "CONNECTING" state when it
begins the process of (re-)connecting with its peer.  Once the two
ends have successfully exchanged their banner and addresses, an
additional NEGOTIATING bit is set in the ceph connection's state to
indicate the connection information exhange has begun.  The
CONNECTING bit/state continues to be set during this phase.

Rather than have the CONNECTING state continue while the NEGOTIATING
bit is set, interpret these two phases as distinct states.  In other
words, when NEGOTIATING is set, clear CONNECTING.  That way only
one of them will be active at a time.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   48
++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1583,7 +1583,6 @@ static int process_connect(struct ceph_c
 			return -1;
 		}
 		clear_bit(NEGOTIATING, &con->state);
-		clear_bit(CONNECTING, &con->state);
 		set_bit(CONNECTED, &con->state);
 		con->peer_global_seq = le32_to_cpu(con->in_reply.global_seq);
 		con->connect_seq++;
@@ -2025,7 +2024,8 @@ more_kvec:
 	}

 do_next:
-	if (!test_bit(CONNECTING, &con->state)) {
+	if (!test_bit(CONNECTING, &con->state) &&
+			!test_bit(NEGOTIATING, &con->state)) {
 		/* is anything else pending? */
 		if (!list_empty(&con->out_queue)) {
 			prepare_write_message(con);
@@ -2082,25 +2082,29 @@ more:
 	}

 	if (test_bit(CONNECTING, &con->state)) {
-		if (!test_bit(NEGOTIATING, &con->state)) {
-			dout("try_read connecting\n");
-			ret = read_partial_banner(con);
-			if (ret <= 0)
-				goto out;
-			ret = process_banner(con);
-			if (ret < 0)
-				goto out;
+		dout("try_read connecting\n");
+		ret = read_partial_banner(con);
+		if (ret <= 0)
+			goto out;
+		ret = process_banner(con);
+		if (ret < 0)
+			goto out;

-			/* Banner is good, exchange connection info */
-			ret = prepare_write_connect(con);
-			if (ret < 0)
-				goto out;
-			prepare_read_connect(con);
-			set_bit(NEGOTIATING, &con->state);
+		clear_bit(CONNECTING, &con->state);
+		set_bit(NEGOTIATING, &con->state);

-			/* Send connection info before awaiting response */
+		/* Banner is good, exchange connection info */
+		ret = prepare_write_connect(con);
+		if (ret < 0)
 			goto out;
-		}
+		prepare_read_connect(con);
+
+		/* Send connection info before awaiting response */
+		goto out;
+	}
+
+	if (test_bit(NEGOTIATING, &con->state)) {
+		dout("try_read negotiating\n");
 		ret = read_partial_connect(con);
 		if (ret <= 0)
 			goto out;
@@ -2222,12 +2226,12 @@ restart:
 	if (test_and_clear_bit(SOCK_CLOSED, &con->flags)) {
 		if (test_and_clear_bit(CONNECTED, &con->state))
 			con->error_msg = "socket closed";
-		else if (test_and_clear_bit(CONNECTING, &con->state)) {
-			clear_bit(NEGOTIATING, &con->state);
+		else if (test_and_clear_bit(NEGOTIATING, &con->state))
+			con->error_msg = "negotiation failed";
+		else if (test_and_clear_bit(CONNECTING, &con->state))
 			con->error_msg = "connection failed";
-		} else {
+		else
 			con->error_msg = "unrecognized con state";
-		}
 		goto fault;
 	}

