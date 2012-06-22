From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/9] libceph: encapsulate and document connect sequence
Date: Fri, 22 Jun 2012 17:48:13 -0500
Message-ID: <4FE4F62D.3070207@inktank.com>
References: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:53187 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab2FVWsN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:48:13 -0400
Received: by gglu4 with SMTP id u4so1973383ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:48:13 -0700 (PDT)
In-Reply-To: <4FE4F534.1000009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Encapsulate the code handles the initial phase of establishing a
ceph connection with a peer, and add a bunch of documentation about
what's involved.  Change process_banner() to return 1 on success
rather than 0, to allow the new ceph_con_connect_response() to
return 0 to indicate the response has not yet been completely read.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   71
++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 17 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1472,7 +1472,7 @@ static int process_banner(struct ceph_co
 		     ceph_pr_addr(&con->msgr->inst.addr.in_addr));
 	}

-	return 0;
+	return 1;
 }

 static void fail_protocol(struct ceph_connection *con)
@@ -1970,6 +1970,57 @@ static void process_message(struct ceph_
 	prepare_read_tag(con);
 }

+/*
+ * Initiate the first phase of establishing a connection with
+ * the peer (connecting).  This phase consists of:
+ *     - client requests TCP connection to server
+ *     - server accepts TCP connection from client
+ *     - client sends banner to server
+ *     - server receives and validates client's banner
+ *     - client sends little-endian encoded own socket (IP) address
+ *     - server recieves, validates, and records client's encoded address
+ * If all is well to this point, then we begin processing the
+ * connect response.
+ */
+static int ceph_con_connect(struct ceph_connection *con)
+{
+	set_bit(CONNECTING, &con->state);
+
+	con_out_kvec_reset(con);
+	prepare_write_banner(con);
+	prepare_read_banner(con);
+
+	BUG_ON(con->in_msg);
+	con->in_tag = CEPH_MSGR_TAG_READY;
+	dout("%s initiating connect on %p new state %lu\n",
+		__func__, con, con->state);
+
+	return ceph_tcp_connect(con);
+}
+
+/*
+ * Handle the response from the first phase of establishing a
+ * connection with the peer.  This consists of:
+ *     - server sends banner to client
+ *     - client receives and validates server's banner
+ *     - server sends little-endian encoded own socket (IP) address
+ *     - client recieves, validates, and records server's encoded address
+ *     - server sends little-endian encoded socket (IP) address for client
+ *     - client recieves and records its encoded address supplied by server
+ * If all is well to this point, then we can transition to the
+ * NEGOTIATING state.
+ */
+static int ceph_con_connect_response(struct ceph_connection *con)
+{
+	int ret;
+
+	dout("%s connecting\n", __func__);
+	ret = read_partial_banner(con);
+	if (ret > 0)
+		ret = process_banner(con);
+
+	return ret;
+}

 /*
  * Write something to the socket.  Called in a worker thread when the
@@ -1986,17 +2037,7 @@ more:

 	/* open the socket first? */
 	if (con->sock == NULL) {
-		set_bit(CONNECTING, &con->state);
-
-		con_out_kvec_reset(con);
-		prepare_write_banner(con);
-		prepare_read_banner(con);
-
-		BUG_ON(con->in_msg);
-		con->in_tag = CEPH_MSGR_TAG_READY;
-		dout("try_write initiating connect on %p new state %lu\n",
-		     con, con->state);
-		ret = ceph_tcp_connect(con);
+		ret = ceph_con_connect(con);
 		if (ret < 0) {
 			con->error_msg = "connect error";
 			goto out;
@@ -2095,13 +2136,9 @@ more:
 	}

 	if (test_bit(CONNECTING, &con->state)) {
-		dout("try_read connecting\n");
-		ret = read_partial_banner(con);
+		ret = ceph_con_connect_response(con);
 		if (ret <= 0)
 			goto out;
-		ret = process_banner(con);
-		if (ret < 0)
-			goto out;

 		clear_bit(CONNECTING, &con->state);
 		set_bit(NEGOTIATING, &con->state);
