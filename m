From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/9] libceph: encapsulate and document negotiation phase
Date: Fri, 22 Jun 2012 17:48:18 -0500
Message-ID: <4FE4F632.2020807@inktank.com>
References: <4FE4F534.1000009@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42424 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab2FVWsT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 18:48:19 -0400
Received: by yenl2 with SMTP id l2so1973211yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 15:48:18 -0700 (PDT)
In-Reply-To: <4FE4F534.1000009@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Encapsulate the code handles the negotiation phase of establishing a
ceph connection with a peer, and add a bunch of documentation about
what's involved.  Change process_connect() to return 1 on success
rather than 0, to allow the new ceph_con_negotiate_response() to
return 0 to indicate the response has not yet been completely read.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |  107
+++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 16 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1633,7 +1633,7 @@ static int process_connect(struct ceph_c
 		con->error_msg = "protocol error, garbage tag during connect";
 		return -1;
 	}
-	return 0;
+	return 1;
 }


@@ -2023,6 +2023,82 @@ static int ceph_con_connect_response(str
 }

 /*
+ * The first phase of connecting with the peer succeeded.  Now start
+ * the second phase (negotiating), which consists of:
+ *  - client sends a connect message to server, specifying
+ *    information about itself, including the protocol it intends to
+ *    use and the features it supports.
+ *  - if authorizer data is needed for the connection, its length is
+ *    recorded in the connect message, and client sends its content
+ *    immediately after the connect message
+ *  - server receives the connect message from the client, and if it
+ *    indicates authorizer data follows, reads that also.
+ * If all is well to this point, then we begin processing the
+ * negotiation response.
+ */
+static int ceph_con_negotiate(struct ceph_connection *con)
+{
+	int ret;
+
+	clear_bit(CONNECTING, &con->state);
+	set_bit(NEGOTIATING, &con->state);
+
+	/* Banner was good, exchange connection info */
+	ret = prepare_write_connect(con);
+	if (ret >= 0)
+		prepare_read_connect(con);
+
+	return ret;
+}
+
+/*
+ * Handle the response from the negotiating phase of connecting the
+ * peer.  This consists of:
+ *  - server validates the connect message (and possibly authorizer
+ *    data), and sends a response to the client:
+ *      - if the protocol version supplied by the client is not what
+ *        was expected, response is a BADPROTOVER tag
+ *      - if the features supported by the client are missing
+ *        features required by the server, response is a FEATURES
+ *        tag.
+ *      - if the features supported by the client are missing
+ *      - if authorizer data is supplied by the client and it is not
+ *        valid, response is a BADAUTHORIZER tag.
+ *      - (There are some other conditions related to message and
+ *        connection sequence numbers but they are not covered here)
+ *      - Otherwise the response will begin with a READY tag, and
+ *        will include a ceph connect reply message, which will
+ *        include the features supported by the server, and the
+ *        server's own authorization data.
+ *  - client validates the connect message (and possibly authorizer
+ *    data) from the server:
+ *      - If the tag indicates a bad protocol or mismatching
+ *        features, the connection attempt is abandoned, so the ceph
+ *        connection is reset and closed.
+ *      - If the tag indicates a bad authorizer, a second connect
+ *        attempt is initiated.  If a second attempt fails due to a
+ *        bad authorizer, the connection attempt fails.
+ *      - If the tag indicates READY, the client will check the
+ *        features supported by the server.  If the server's
+ *        features do not include a feature required by the client,
+ *        the connection attempt is abandoned, so the ceph
+ *        connection is reset and closed.
+ *  If no failures occurred to this point, the connection is established.
+ */
+static int ceph_con_negotiate_response(struct ceph_connection *con)
+{
+	int ret;
+
+	dout("%s negotiating\n", __func__);
+
+	ret = read_partial_connect(con);
+	if (ret > 0)
+		ret = process_connect(con);
+
+	return ret;
+}
+
+/*
  * Write something to the socket.  Called in a worker thread when the
  * socket appears to be writeable and we have something ready to send.
  */
@@ -2136,31 +2212,30 @@ more:
 	}

 	if (test_bit(CONNECTING, &con->state)) {
+		/*
+		 * See if we got the response we expect from our
+		 * connection request.
+		 */
 		ret = ceph_con_connect_response(con);
 		if (ret <= 0)
 			goto out;

-		clear_bit(CONNECTING, &con->state);
-		set_bit(NEGOTIATING, &con->state);
-
-		/* Banner is good, exchange connection info */
-		ret = prepare_write_connect(con);
-		if (ret < 0)
-			goto out;
-		prepare_read_connect(con);
+		/*
+		 * All good.  Initiate the negotiation phase of the
+		 * connection.  If this succeeds, we're done reading
+		 * and we next need to send the messages we've
+		 * queued up.  If it fails, we're also done.
+		 */
+		ret = ceph_con_negotiate(con);

-		/* Send connection info before awaiting response */
-		goto out;
+		goto out;	/* Regardless of result */
 	}

 	if (test_bit(NEGOTIATING, &con->state)) {
-		dout("try_read negotiating\n");
-		ret = read_partial_connect(con);
+		ret = ceph_con_negotiate_response(con);
 		if (ret <= 0)
 			goto out;
-		ret = process_connect(con);
-		if (ret < 0)
-			goto out;
+
 		goto more;
 	}

