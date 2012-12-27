From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: WARN, don't BUG on unexpected connection states
Date: Thu, 27 Dec 2012 17:17:52 -0600
Message-ID: <50DCD720.4070909@inktank.com>
References: <50DCD544.8000602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:50237 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab2L0XRz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Dec 2012 18:17:55 -0500
Received: by mail-ia0-f171.google.com with SMTP id k27so8382359iad.2
        for <ceph-devel@vger.kernel.org>; Thu, 27 Dec 2012 15:17:54 -0800 (PST)
In-Reply-To: <50DCD544.8000602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A number of assertions in the ceph messenger are implemented with
BUG_ON(), killing the system if connection's state doesn't match
what's expected.  At this point our state model is (evidently) not
well understood enough for these assertions to trigger a BUG().
Convert all BUG_ON(con->state...) calls to be WARN_ON(con->state...)
so we learn about these issues without killing the machine.

We now recognize that a connection fault can occur due to a socket
closure at any time, regardless of the state of the connection.  So
there is really nothing we can assert about the state of the
connection at that point so eliminate that assertion.

Reported-by: Ugis <ugis22@gmail.com>
Tested-by: Ugis <ugis22@gmail.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 4d111fd..075b9fd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -561,7 +561,7 @@ void ceph_con_open(struct ceph_connection *con,
 	mutex_lock(&con->mutex);
 	dout("con_open %p %s\n", con, ceph_pr_addr(&addr->in_addr));

-	BUG_ON(con->state != CON_STATE_CLOSED);
+	WARN_ON(con->state != CON_STATE_CLOSED);
 	con->state = CON_STATE_PREOPEN;

 	con->peer_name.type = (__u8) entity_type;
@@ -1509,7 +1509,7 @@ static int process_banner(struct ceph_connection *con)
 static void fail_protocol(struct ceph_connection *con)
 {
 	reset_connection(con);
-	BUG_ON(con->state != CON_STATE_NEGOTIATING);
+	WARN_ON(con->state != CON_STATE_NEGOTIATING);
 	con->state = CON_STATE_CLOSED;
 }

@@ -1635,7 +1635,7 @@ static int process_connect(struct ceph_connection
*con)
 			return -1;
 		}

-		BUG_ON(con->state != CON_STATE_NEGOTIATING);
+		WARN_ON(con->state != CON_STATE_NEGOTIATING);
 		con->state = CON_STATE_OPEN;

 		con->peer_global_seq = le32_to_cpu(con->in_reply.global_seq);
@@ -2132,7 +2132,6 @@ more:
 		if (ret < 0)
 			goto out;

-		BUG_ON(con->state != CON_STATE_CONNECTING);
 		con->state = CON_STATE_NEGOTIATING;

 		/*
@@ -2160,7 +2159,7 @@ more:
 		goto more;
 	}

-	BUG_ON(con->state != CON_STATE_OPEN);
+	WARN_ON(con->state != CON_STATE_OPEN);

 	if (con->in_base_pos < 0) {
 		/*
@@ -2382,10 +2381,6 @@ static void ceph_fault(struct ceph_connection *con)
 	dout("fault %p state %lu to peer %s\n",
 	     con, con->state, ceph_pr_addr(&con->peer_addr.in_addr));

-	BUG_ON(con->state != CON_STATE_CONNECTING &&
-	       con->state != CON_STATE_NEGOTIATING &&
-	       con->state != CON_STATE_OPEN);
-
 	con_close_socket(con);

 	if (test_bit(CON_FLAG_LOSSYTX, &con->flags)) {
-- 
1.7.9.5

