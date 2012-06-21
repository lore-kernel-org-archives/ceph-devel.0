From: Alex Elder <elder@inktank.com>
Subject: [PATCH 02/12] libceph: don't change socket state on sock event
Date: Thu, 21 Jun 2012 09:21:07 -0500
Message-ID: <4FE32DD3.2020001@inktank.com>
References: <4FE32C84.2050408@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48665 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921Ab2FUOVK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 10:21:10 -0400
Received: by gglu4 with SMTP id u4so495707ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 07:21:09 -0700 (PDT)
In-Reply-To: <4FE32C84.2050408@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently the socket state change event handler records an error
message on a connection to distinguish a close while connecting from
a close while a connection was already established.

Changing connection information during handling of a socket event is
not very clean, so instead move this assignment inside con_work(),
where it can be done during normal connection-level processing (and
under protection of the connection mutex as well).

Move the handling of a socket closed event up to the top of the
processing loop in con_work(); there's no point in handling backoff
etc. if we have a newly-closed socket to take care of.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -261,13 +261,8 @@ static void ceph_sock_state_change(struc
 	case TCP_CLOSE_WAIT:
 		dout("%s TCP_CLOSE_WAIT\n", __func__);
 		con_sock_state_closing(con);
-		if (test_and_set_bit(SOCK_CLOSED, &con->flags) == 0) {
-			if (test_bit(CONNECTING, &con->state))
-				con->error_msg = "connection failed";
-			else
-				con->error_msg = "socket closed";
+		if (!test_and_set_bit(SOCK_CLOSED, &con->flags))
 			queue_con(con);
-		}
 		break;
 	case TCP_ESTABLISHED:
 		dout("%s TCP_ESTABLISHED\n", __func__);
@@ -2212,6 +2207,14 @@ static void con_work(struct work_struct

 	mutex_lock(&con->mutex);
 restart:
+	if (test_and_clear_bit(SOCK_CLOSED, &con->flags)) {
+		if (test_bit(CONNECTING, &con->state))
+			con->error_msg = "connection failed";
+		else
+			con->error_msg = "socket closed";
+		goto fault;
+	}
+
 	if (test_and_clear_bit(BACKOFF, &con->flags)) {
 		dout("con_work %p backing off\n", con);
 		if (queue_delayed_work(ceph_msgr_wq, &con->work,
@@ -2241,9 +2244,6 @@ restart:
 		con_close_socket(con);
 	}

-	if (test_and_clear_bit(SOCK_CLOSED, &con->flags))
-		goto fault;
-
 	ret = try_read(con);
 	if (ret == -EAGAIN)
 		goto restart;
